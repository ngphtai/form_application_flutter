import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_page_event.dart';
part 'form_page_state.dart';

class FormPageBloc extends Bloc<FormPageEvent, FormPageState> {
  FormPageBloc() : super(FormPageInitial());

  @override
  Stream<FormPageState> mapEventToState(
    FormPageEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
