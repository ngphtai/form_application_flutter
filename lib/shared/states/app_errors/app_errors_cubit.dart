import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../common/constant/app_errors/app_error.dart';

part 'app_errors_state.dart';

/// [AppErrorsCubit] class is used listen event from StreamSubscription.
/// Follow any value state change, and emit [AppError].
///
/// [AppErrorsCubit] class extends [Cubit]
class AppErrorsCubit extends Cubit<AppErrorsState> {
  /// Init
  AppErrorsCubit() : super(AppErrorsInitial());
}
