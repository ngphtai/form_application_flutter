import 'package:flutter_bloc/flutter_bloc.dart';

class RadioButtonBloc extends Cubit<bool> {
  RadioButtonBloc() : super(true);

  void Validate(String value) {
    emit(value.isNotEmpty);
  }
}
