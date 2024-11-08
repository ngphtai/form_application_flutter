import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropButtonBloc extends Cubit<CustomDropButtonState> {
  CustomDropButtonBloc()
      : super(CustomDropButtonState(isError: false, isSelected: ""));

  void validate(String value) {
    if (isClosed) return; // Ngăn phát nếu đã đóng

    try {
      if (!isClosed) {
        if (value != '')
          emit(CustomDropButtonState(isError: false, isSelected: value));
        else
          emit(CustomDropButtonState(isError: true, isSelected: ""));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class CustomDropButtonState {
  late bool isError;
  final String isSelected;

  CustomDropButtonState({required this.isError, required this.isSelected});
}
