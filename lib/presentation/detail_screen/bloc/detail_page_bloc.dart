import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_page_event.dart';
part 'detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  DetailPageBloc() : super(DetailPageInitial());

  @override
  Stream<DetailPageState> mapEventToState(
    DetailPageEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
