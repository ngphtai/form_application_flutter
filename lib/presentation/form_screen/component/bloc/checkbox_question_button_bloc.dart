import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxQuestionButtonBloc extends Cubit<CheckBoxQuestionButtonState> {
  List<String> values = [];

  List<String> get getValue => values;

  CheckboxQuestionButtonBloc() : super(CheckBoxQuestionButtonInitial());
  void validate(List<String> listOutput) {
    values = listOutput;
    emit(CheckBoxQuestionButtonValid(isValid: listOutput.isNotEmpty));
  }
}

abstract class CheckBoxQuestionButtonState extends Equatable {}

class CheckBoxQuestionButtonInitial extends CheckBoxQuestionButtonState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class CheckBoxQuestionButtonValid extends CheckBoxQuestionButtonState {
  bool isValid;
  CheckBoxQuestionButtonValid({required this.isValid});
  @override
  List<Object?> get props => [isValid];
}
