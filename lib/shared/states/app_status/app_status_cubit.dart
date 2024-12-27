import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../common/constant/app_errors/app_error.dart';

part 'app_status_state.dart';

/// [AppStatusCubit] class is used listen event from StreamSubscription.
/// Follow any value state change, and emit [AppError].
///
/// [AppStatusCubit] class extends [Cubit]
class AppStatusCubit extends Cubit<AppStatusState> {
  /// Init
  AppStatusCubit() : super(AppStatusInitial());

  /// Emit app status logged
  void appChangeStatusLogged({required bool isLogged}) {
    if (isLogged) {
      emit(AppStatusLogged());
    } else {
      emit(AppStatusLogout());
    }
  }

  /// Change status loading in app
  void appStatusLoading() {
    emit(AppStatusLoading());
  }
}
