import 'package:flutter_bloc/flutter_bloc.dart';

class PickImageBloc extends Cubit<bool> {
  PickImageBloc() : super(true);

  void validate(List<String> value) {
    print(value.length);
    emit(value.isNotEmpty);
  }
}
