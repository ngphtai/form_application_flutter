part of 'splash_bloc.dart';

@immutable
sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashRunInProgress extends SplashState {
  const SplashRunInProgress(this.duration);
  final int duration;

  @override
  List<Object?> get props => [duration];
}

final class SplashComplete extends SplashState {
  const SplashComplete();

  @override
  List<Object?> get props => [];
}
