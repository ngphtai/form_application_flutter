import 'package:flutter_bloc/flutter_bloc.dart';

class TimePickerCustomBloc extends Cubit<bool> {
  TimePickerCustomBloc() : super(true);
  void validate(String Value) {
    emit(Value.isNotEmpty);
    if (Value == "false") emit(false);
  }
}
