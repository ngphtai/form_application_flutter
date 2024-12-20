import 'package:bloc/bloc.dart';
import '../../../common/constant/constants.dart';
import '/common/logger/app_logger.dart';
import '/core/locators/locators.dart';
import '/data/model/entities/post_model_entity.dart';
import '/domain/models/post_model.dart';
import 'package:equatable/equatable.dart';

part 'form_page_event.dart';
part 'form_page_state.dart';

class FormPageBloc extends Bloc<FormPageEvent, FormPageState> {
  FormPageBloc() : super(FormPageInitial()) {
    // on<SaveForm>(_saveForm);
    on<SaveAnswerToGoogleSheet>(_saveAnswersToGoogleSheet);
    on<LoadAnswerLocal>(_loadAnswerLocal);
  }

  final seviceable = diPostSeviceable;

  Future<void> _saveAnswersToGoogleSheet(
      SaveAnswerToGoogleSheet event, Emitter<FormPageState> emit) async {
    emit(FormPageLoading()); // Đặt trạng thái loading trước

    // Lưu Google Sheet
    final result = await seviceable.saveAnswerToGoogleSheet(event.post);

    await diAnalytics.log(
        LogEvents.api_submit_google_sheet, {"id form": event.post.metaData.id});
    await result.fold(
      (left) async {
        // Lưu thất bại Google Sheet
        if (!emit.isDone) {
          emit(const FormPageSaveGoogleSheetFailed(
              errorMessage: "Bugggggggggg"));
        }
      },
      (success) async {
        AppLogger.instance.i("Answer is saved to google sheet success!!");
        final resultLocal = await seviceable.saveResultPostToLocal(event.post);

        await diAnalytics.log(LogEvents.local_save_filled_form,
            {"id form": event.post.metaData.id});
        await resultLocal.fold(
          (left) async {
            AppLogger.instance.e(left.toString());
          },
          (right) async {
            if (!emit.isDone) {
              emit(FormPageSaveSuccess(event.post));
              AppLogger.instance.i("Answer is saved to local success!!");
            }
          },
        );
      },
    );
  }

  Future<void> _loadAnswerLocal(
      LoadAnswerLocal event, Emitter<FormPageState> emit) async {
    await diAnalytics
        .log(LogEvents.local_get_filled_form_local, {"id form": event.id});
    final result = await seviceable.getAnswerFromLocal(event.id);
    result.fold(
      (left) {
        AppLogger.instance.e(left.toString());
      },
      (post) {
        emit(FormPageLoaded(post));
        AppLogger.instance.i("Answer is loaded from local success!!");
      },
    );
  }
}
