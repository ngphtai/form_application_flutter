import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  final bool isLogEnable;
  AppBlocObserver({this.isLogEnable = true});

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logging(name: "onEvent", value: event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logging(name: "onError", value: stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logging(
        name: "onChange",
        value: "currentState: "
            "${change.currentState} --> nextState: ${change.nextState}");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logging(
        name: "onTransition",
        value: "currentState: "
            "${transition.currentState} --> nextState: ${transition.nextState}");
  }

  void _logging({required String name, required dynamic value}) {
    if (isLogEnable) {
      log('$name $value');
    }
  }
}
