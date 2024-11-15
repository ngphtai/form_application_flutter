// ignore_for_file: must_be_immutable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class TextFieldBLoc2 extends Cubit<TextFieldState2> {
  TextFieldBLoc2() : super(TextFieldInit());

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

class TextFieldState2 extends Equatable {
  String? state;
  TextFieldState2(this.state);
  @override
  List<Object?> get props => [state];
}

class TextFieldInit extends TextFieldState2 {
  TextFieldInit() : super('');
}

class TextFieldValid extends TextFieldState2 {
  TextFieldValid(value) : super(value);
}

class TextFieldInValid extends TextFieldState2 {
  TextFieldInValid() : super(null);
}

class NonValid extends TextFieldState2 {
  NonValid() : super('');
}
