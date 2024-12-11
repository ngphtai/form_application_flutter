import '/common/logger/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropButtonBloc extends Cubit<CustomDropButtonState> {
  CustomDropButtonBloc()
      : super(CustomDropButtonState(isError: false, isSelected: ""));

  bool isValid = false;
  bool get getValue => isValid;

  void validate(String? value) {
    try {
      if (!isClosed) {
        if (value != null) {
          isValid = true;
          emit(CustomDropButtonState(isError: false, isSelected: value));
        } else {
          emit(CustomDropButtonState(isError: true, isSelected: null));
        }
      }
    } catch (e) {
      AppLogger.instance.e('Error in custom drop button: ${e.toString()}');
    }
  }
}

class CustomDropButtonState {
  late bool isError;
  final String? isSelected;

  CustomDropButtonState({required this.isError, required this.isSelected});
}
