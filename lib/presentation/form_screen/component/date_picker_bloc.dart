import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerBloc extends Cubit<bool> {
  DatePickerBloc() : super(false);

  void validate(DateTime value) {
    emit(true);
  }

  void Error(bool check) {
    emit(check);
  }
}
