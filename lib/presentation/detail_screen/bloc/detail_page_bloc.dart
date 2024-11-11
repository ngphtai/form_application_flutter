import 'package:bloc/bloc.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/models/post_model.dart';

part 'detail_page_event.dart';
part 'detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  DetailPageBloc() : super(DetailPageInitial()) {
    on<LoadDetailPost>(_loadDetailPost);
  }
  final _postSeviceable = diPostSeviceable;

  Future<void> _loadDetailPost(
      LoadDetailPost event, Emitter<DetailPageState> emit) async {
    emit(DetailPageLoading());
    var result = await _postSeviceable.getDetailPost(event.id);
    return result.fold((left) {
      AppLogger.instance.e(left.toString());
    }, (result) {
      emit(DetailPageLoaded(result));
    });
  }
}
