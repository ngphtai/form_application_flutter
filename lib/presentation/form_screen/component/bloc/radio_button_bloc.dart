import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioButtonBloc extends Cubit<RadioButtonState> {
  RadioButtonBloc() : super(RadioButtonInitial());

  late String select = '';
  void validate(String value) {
    print("Validate $value");
    if (value.isNotEmpty) {
      select = value;
      emit(RadioButtonValid(isValid: true));
    } else {
      select = '';
      emit(RadioButtonValid(isValid: false));
    }
  }

  String? get values => select != '' ? select : null;
}

abstract class RadioButtonState extends Equatable {}

class RadioButtonInitial extends RadioButtonState {
  @override
  List<Object?> get props => [];
}

class RadioButtonValid extends RadioButtonState {
  bool isValid;
  RadioButtonValid({required this.isValid});
  @override
  List<Object?> get props => [isValid];
}
