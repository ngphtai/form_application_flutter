import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerBloc extends Cubit<DatePickerState> {
  DateTime? selected;

  DatePickerBloc() : super(DatePickerInitial());

  void validate(DateTime? value) {
    if (value != null) {
      selected = value;
      emit(DatePickerChangedValue(value));
    } else {
      selected = null;
      emit(const DatePickerChangedValue(null));
    }
  }

  DateTime? get getValue => selected;
  set getValue(DateTime? value) => selected = value;
}

@immutable
abstract class DatePickerState extends Equatable {
  const DatePickerState();

  @override
  List<Object> get props => [];
}

class DatePickerInitial extends DatePickerState {
  @override
  List<Object> get props => [];
}

class DatePickerChangedValue extends DatePickerState {
  final DateTime? value;

  const DatePickerChangedValue(this.value);
}
