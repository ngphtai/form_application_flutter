import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioButtonBloc extends Cubit<RadioButtonState> {
  RadioButtonBloc() : super(RadioButtonInitial());
  String? select;
  String? get value => select;
  set value(String? value) => select = value;

  void validate(String value) {
    if (value.isNotEmpty) {
      select = value;
      emit(RadioButtonValidate(isValid: true, value: value));
    } else {
      select = null;
      emit(RadioButtonValidate(isValid: false, value: null));
    }
  }

  void setError() {
    emit(RadioButtonValidate(isValid: false, value: null));
  }
}

abstract class RadioButtonState extends Equatable {}

class RadioButtonInitial extends RadioButtonState {
  @override
  List<Object> get props => [];
}

class RadioButtonValidate extends RadioButtonState {
  final bool isValid;
  final String? value;

  RadioButtonValidate({required this.isValid, required this.value});

  @override
  List<Object?> get props => [isValid, value];
}
