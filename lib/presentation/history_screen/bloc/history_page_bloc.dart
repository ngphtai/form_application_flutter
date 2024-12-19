import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '/common/logger/app_logger.dart';
import '/core/locators/locators.dart';
import '/domain/models/post_model.dart';
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
  emit(const HistoryPageLoading());
  await FirebaseAnalytics.instance.logEvent(
    name: 'get_filled_form_local',
  );
  final postServiceable = diPostSeviceable;
  final result = await postServiceable.getPostsFromLocal();
  result.fold((error) => AppLogger.instance.e(error.toString()), (result) {
    emit(HistoryPageLoaded(result));
  });
}
