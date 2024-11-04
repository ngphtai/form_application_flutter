import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class TextFieldBLoc extends Cubit<TextFieldState> {
  TextFieldBLoc() : super(TextFieldInit());

  void validate(String value) {
    if (value.isNotEmpty) {
      emit(TextFieldValid());
    }
    if (value == "") {
      emit(TextFieldInValid());
    }
  }
}

class TextFieldState extends Equatable {
  late bool state;
  TextFieldState(this.state);
  @override
  List<Object?> get props => [state];
}

class TextFieldInit extends TextFieldState {
  TextFieldInit() : super(true);
}

class TextFieldValid extends TextFieldState {
  TextFieldValid() : super(true);
}

class TextFieldInValid extends TextFieldState {
  TextFieldInValid() : super(false);
}
