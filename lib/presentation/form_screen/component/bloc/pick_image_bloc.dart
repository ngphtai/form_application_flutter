import '/common/logger/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickImageBloc extends Cubit<bool> {
  PickImageBloc() : super(true);

  void validate(List<String> value) {
    AppLogger.instance.i("value in pick image is ${value.length}");
    emit(value.isNotEmpty);
  }
}
