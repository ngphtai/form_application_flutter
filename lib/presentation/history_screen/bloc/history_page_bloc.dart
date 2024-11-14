import 'package:bloc/bloc.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:equatable/equatable.dart';

part 'history_page_event.dart';
part 'history_page_state.dart';

class HistoryPageBloc extends Bloc<HistoryPageEvent, HistoryPageState> {
  HistoryPageBloc() : super(HistoryPageInitial()) {
    on<LoadPostFromLocal>(_loadPostFromLocal);
  }
}

Future<void> _loadPostFromLocal(
    LoadPostFromLocal event, Emitter<HistoryPageState> emit) async {
  try {
    final postServiceable = diPostSeviceable;
    final result = await postServiceable.getPostsFromLocal();

    result.fold((error) => AppLogger.instance.e(error.toString()), (result) {
      emit(HistoryPageLoaded(result));
    });
  } catch (e) {
    AppLogger.instance.e("error to fetch local: ${e.toString()}");
  }
}
