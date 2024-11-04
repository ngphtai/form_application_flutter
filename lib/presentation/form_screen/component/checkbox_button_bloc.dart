import 'package:bloc/bloc.dart';

class CheckboxButtonBloc extends Cubit<bool> {
  CheckboxButtonBloc() : super(true);

  void validate(List<String> value) {
    emit(value.isNotEmpty);
  }
}
