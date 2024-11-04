import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropButtonBloc extends Cubit<bool> {
  CustomDropButtonBloc() : super(true);
  void Validate(String value) {
    if (value != '')
      emit(true);
    else
      emit(false);
  }
}
