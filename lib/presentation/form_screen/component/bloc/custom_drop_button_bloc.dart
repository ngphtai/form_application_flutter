import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropButtonBloc extends Cubit<CustomDropButtonState> {
  CustomDropButtonBloc()
      : super(CustomDropButtonState(isError: false, isSelected: ""));

  void validate(String value) {
    try {
      if (!isClosed) {
        if (value != '') {
          emit(CustomDropButtonState(isError: false, isSelected: value));
        } else {
          emit(CustomDropButtonState(isError: true, isSelected: ""));
        }
      }
    } catch (e) {
      AppLogger.instance.e('Error in custom drop button: ${e.toString()}');
    }
  }
}

class CustomDropButtonState {
  late bool isError;
  final String isSelected;

  CustomDropButtonState({required this.isError, required this.isSelected});
}
