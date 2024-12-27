import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_path.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
    on<SplashTimerTicked>(_onSplashTimerTicked);
    on<SplashMoveToApp>(_onSplashMoveToApp);
  }

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onSplashStarted(SplashStarted event, Emitter emit) async {
    event.context.go(Routers.homePage);
  }

  void _onSplashMoveToApp(SplashMoveToApp event, Emitter emit) {
    emit(const SplashComplete());
  }

  void _onSplashTimerTicked(SplashTimerTicked event, Emitter emit) {
    if (event.duration > 0) {
      emit(SplashRunInProgress(event.duration));
    } else {
      emit(const SplashComplete());
    }
  }
}
