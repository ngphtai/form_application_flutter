import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxQuestionButtonBloc extends Cubit<bool> {
  CheckboxQuestionButtonBloc() : super(true);
  void validate(List<String> listOutput) {
    emit(listOutput.isNotEmpty);
  }
}
