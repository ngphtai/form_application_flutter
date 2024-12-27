part of 'app_errors_cubit.dart';

/// {@template app_errors_state}
/// Base class for all [AppErrorsState]s which are
/// managed by the [AppErrorsCubit].
/// {@endtemplate}
@immutable
sealed class AppErrorsState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// The initial state of the [AppErrorsCubit].
final class AppErrorsInitial extends AppErrorsState {}



