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
      emit(RadioButtonValidate(isValid: true));
    } else {
      select = null;
      emit(RadioButtonValidate(isValid: false));
    }
  }

  void setError() {
    emit(RadioButtonValidate(isValid: false));
  }
}

abstract class RadioButtonState extends Equatable {}

class RadioButtonInitial extends RadioButtonState {
  @override
  List<Object> get props => [];
}

class RadioButtonValidate extends RadioButtonState {
  final bool isValid;

  RadioButtonValidate({required this.isValid});

  @override
  List<Object?> get props => [isValid];
}
