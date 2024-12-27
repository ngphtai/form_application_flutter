part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

final class SplashStarted extends SplashEvent {
  const SplashStarted(this.context);
  final BuildContext context;

  @override
  List<Object?> get props => [];
}

final class SplashMoveToApp extends SplashEvent {
  const SplashMoveToApp();

  @override
  List<Object?> get props => [];
}

final class SplashTimerTicked extends SplashEvent {
  const SplashTimerTicked(this.context, this.duration);

  final BuildContext context;
  final int duration;

  @override
  List<Object?> get props => [context, duration];
}
