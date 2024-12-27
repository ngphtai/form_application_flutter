import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldBloc extends Cubit<TextFieldState> {
  TextFieldBloc() : super(TextFieldInitial());
  String? text;
  String? get value => text;
  set value(String? value) => text = value;

  void validate(String value) {
    if (value.isNotEmpty) {
      text = value;
      emit(TextFieldValidate(isValid: true));
    } else if (value == "") {
      emit(TextFieldValidate(isValid: false));
    }
  }

  void setError() {
    emit(TextFieldValidate(isValid: false));
  }
}

abstract class TextFieldState extends Equatable {
  @override
  List<Object> get props => [];
}

class TextFieldInitial extends TextFieldState {}

class TextFieldValidate extends TextFieldState {
  final bool isValid;
  TextFieldValidate({required this.isValid});
  @override
  List<Object> get props => [isValid];
}
