import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioButtonBloc extends Cubit<String> {
  RadioButtonBloc() : super('initial');
  // khong the de gia tri get la state vi khi widget reset thi gia tri quay ve init vi the nen dung 1 bien de chua cac gia tri
  // tranh tro lai gia tri inital
  late String select = '';
  void validate(String value) {
    print("Validate $value");
    if (value.isNotEmpty) select = value;

    emit(value);
  }

  String? get values => select != '' ? select : null;
}
