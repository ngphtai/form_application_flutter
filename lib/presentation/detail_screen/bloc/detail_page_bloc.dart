import 'package:bloc/bloc.dart';
import 'package:dsoft_form_application/common/constant/constants.dart';
import '/common/logger/app_logger.dart';
import '/core/locators/locators.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/models/post_model.dart';

part 'detail_page_event.dart';
part 'detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  DetailPageBloc() : super(DetailPageInitial()) {
    on<LoadDetailPost>(_loadDetailPost);
    on<LoadDetailPostLocal>(_loadDetailPostFromLocal);
  }
  final _postSeviceable = diPostSeviceable;

  Future<void> _loadDetailPost(
      LoadDetailPost event, Emitter<DetailPageState> emit) async {
    //analytics

    await diAnalytics.log(LogEvents.api_get_detail_form, {"id form": event.id});
    emit(DetailPageLoading());
    var result = await _postSeviceable.getDetailPost(event.id);
    return result.fold((left) {
      AppLogger.instance.e(left.toString());
    }, (result) {
      emit(DetailPageLoaded(result));
    });
  }

  Future<void> _loadDetailPostFromLocal(
      LoadDetailPostLocal event, Emitter<DetailPageState> emit) async {
    await diAnalytics
        .log(LogEvents.local_get_detail_form, {"id form": event.id});
    final result = await _postSeviceable.getAnswerFromLocal(event.id);
    result.fold(
      (left) {
        AppLogger.instance.e(left.toString());
      },
      (result) {
        emit(DetailPageLoaded(result ?? [] as PostsModel));
        AppLogger.instance.i("Detail post is loaded from local success!!");
      },
    );
  }
}
