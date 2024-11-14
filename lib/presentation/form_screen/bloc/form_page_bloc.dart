import 'package:bloc/bloc.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/data/model/entities/post_model_entity.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:equatable/equatable.dart';

part 'form_page_event.dart';
part 'form_page_state.dart';

class FormPageBloc extends Bloc<FormPageEvent, FormPageState> {
  FormPageBloc() : super(FormPageInitial()) {
    on<SaveForm>(_saveForm);
    on<LoadAnswerLocal>(_loadAnswerLocal);
  }

  final seviceable = diPostSeviceable;
  Future<void> _saveForm(SaveForm event, Emitter<FormPageState> emit) async {
    final result = await seviceable.saveResultPostToLocal(event.postsEntity);

    if (result == true) {
      emit(FormPageSaveSuccess(event.postsEntity));
      AppLogger.instance.e("Post submit success!!!");
    } else {
      AppLogger.instance.e("Post submit failed! ");
    }
  }

  Future<void> _loadAnswerLocal(
      LoadAnswerLocal event, Emitter<FormPageState> emit) async {
    final result = await seviceable.getAnswerFromLocal(event.id);
    result.fold(
      (left) {
        AppLogger.instance.e(left.toString());
      },
      (post) {
        emit(FormPageLoaded(post));
      },
    );
  }
}
