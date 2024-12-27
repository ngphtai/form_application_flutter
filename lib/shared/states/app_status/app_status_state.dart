part of 'app_status_cubit.dart';

/// {@template app_status_state}
/// Base class for all [AppStatusState]s which are
/// managed by the [AppStatusCubit].
/// {@endtemplate}
@immutable
sealed class AppStatusState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// The initial state of the [AppStatusCubit].
final class AppStatusInitial extends AppStatusState {}

/// {@template app_status_loading}
/// The state of the [AppStatusCubit] is loading to show progress view.
/// {@endtemplate}
final class AppStatusLoading extends AppStatusState {
  /// {@macro app_status_loading}
  AppStatusLoading();

  @override
  List<Object> get props => [];
}

/// {@template app_status_logged}
/// The state of the [AppStatusCubit] is logged
/// {@endtemplate}
final class AppStatusLogged extends AppStatusState {
  /// {@macro app_status_logged}
  AppStatusLogged();

  @override
  List<Object> get props => [];
}

/// {@template app_status_logout}
/// The state of the [AppStatusCubit] is logout.
/// {@endtemplate}
final class AppStatusLogout extends AppStatusState {
  /// {@macro app_status_logout}
  AppStatusLogout();

  @override
  List<Object> get props => [];
}
