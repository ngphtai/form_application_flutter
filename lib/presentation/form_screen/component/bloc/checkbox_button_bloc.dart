import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxButtonBloc extends Cubit<CheckboxButtonState> {
  List<String> selected = [];
  List<String> get values => selected;
  set values(List<String> value) => selected = value;

  CheckboxButtonBloc() : super(CheckboxButtonInitial());

  void validate(List<String> value) {
    if (value.isNotEmpty) {
      selected = value;
      emit(CheckboxButtonValidate(value: true));
    } else {
      selected = [];
      emit(CheckboxButtonValidate(value: false));
    }
  }

  void setError() {
    emit(CheckboxButtonValidate(value: false));
  }
}

abstract class CheckboxButtonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckboxButtonInitial extends CheckboxButtonState {}

class CheckboxButtonValidate extends CheckboxButtonState {
  final bool value;
  CheckboxButtonValidate({required this.value});

  @override
  List<Object?> get props => [value];
}
