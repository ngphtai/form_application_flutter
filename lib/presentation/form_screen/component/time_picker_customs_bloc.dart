import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'time_picker_state.dart';

class TimePickerCustomBloc extends Cubit<TimePickerState> {
  late String? text = "";

  TimePickerCustomBloc() : super(TimePickerInitial());

  void changeValue(String value) {
    value != "false" ? text = value : text = "";
    if (value == "false") emit(const TimePickerChanged(null));
    if (value.isNotEmpty) emit(TimePickerChanged(value));
  }

  void setValue(String value) {
    text = value;
  }

  String? get getState => text;
}
