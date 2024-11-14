import 'package:bloc/bloc.dart';

class CheckboxButtonBloc extends Cubit<bool> {
  CheckboxButtonBloc() : super(true);

  List<String> values = [];

  void validate(List<String> value) {
    values = value;
    emit(value.isNotEmpty);
  }

  List<String> getValue() => values;
}

// class RadioButtonBloc extends Cubit<RadioButtonState> {
//   RadioButtonBloc() : super(RadioButtonInitial());

//   late String select = '';

//   void validate(String value) {
//     print("Radio button $value");
//     if (value.isNotEmpty) {
//       select = value;
//       print(" select $select");
//       emit(RadioButtonValid(isValid: true));
//     } else {
//       select = '';
//       emit(RadioButtonValid(isValid: false));
//     }
//   }

//   String get values => select;

//   set values(String value) => select = value;
// }
