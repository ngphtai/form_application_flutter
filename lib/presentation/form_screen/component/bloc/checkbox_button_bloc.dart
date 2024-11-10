import 'package:bloc/bloc.dart';

class CheckboxButtonBloc extends Cubit<bool> {
  CheckboxButtonBloc() : super(true);

  List<String> values = [];

  void validate(List<String> value) {
    values = value;
    emit(value.isNotEmpty);
  }

  //get value
  List<String> getValue() => values;
}
