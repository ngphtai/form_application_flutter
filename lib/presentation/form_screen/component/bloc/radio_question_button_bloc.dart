import 'package:flutter_bloc/flutter_bloc.dart';

class RadioQuestionButtonBloc extends Cubit<bool> {
  RadioQuestionButtonBloc() : super(true);

  void validate(Map<String, String> answers, List<String> questions) {
    emit(answers.length == questions.length);
  }
}
