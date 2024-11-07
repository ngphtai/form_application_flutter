// ignore_for_file: must_be_immutable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class TextFieldBLoc extends Cubit<TextFieldState> {
  TextFieldBLoc() : super(TextFieldInit());

  String values = '';
  //for request = true
  void validate(String value, bool isRequest) {
    if (value.isNotEmpty) {
      values = value;
      emit(TextFieldValid(value));
    }
    if (value == "" && isRequest) {
      emit(TextFieldInValid());
    } else if (value == "" && !isRequest) {
      emit(NonValid());
    }
  }

  String? get Value => values;
}

class TextFieldState extends Equatable {
  String? state;
  TextFieldState(this.state);
  @override
  List<Object?> get props => [state];
}

class TextFieldInit extends TextFieldState {
  TextFieldInit() : super('');
}

class TextFieldValid extends TextFieldState {
  TextFieldValid(value) : super(value);
}

class TextFieldInValid extends TextFieldState {
  TextFieldInValid() : super(null);
}

class NonValid extends TextFieldState {
  NonValid() : super('');
}
