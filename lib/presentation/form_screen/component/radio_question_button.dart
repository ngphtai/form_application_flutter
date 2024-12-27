import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/radio_question_button_bloc.dart';

// ignore: must_be_immutable
class RadioQuestionButton extends StatefulWidget {
  RadioQuestionButton({
    super.key,
    required this.listQuestion,
    required this.onChanged,
    this.isRequest = false,
    this.isError = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RadioQuestionButtonState createState() => _RadioQuestionButtonState();
  final List<String> listQuestion;
  // final ValueChanged<Map<String, String>> onChanged;
  final ValueChanged onChanged;
  final bool? isRequest;
  bool isError;
}

List<String> review = ["Xuất sắc", "Tốt", "Trung bình", "Kém"];

class _RadioQuestionButtonState extends State<RadioQuestionButton> {
  Map<String, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioQuestionButtonBloc, bool>(
      builder: (context, isValid) {
        widget.isError = isValid ? false : true;
        widget.onChanged(isValid);
        return Container(
          height: 700,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.all(
                color: widget.isRequest == true
                    ? !widget.isError
                        ? const Color(0xffe8e8e8)
                        : Colors.red
                    : const Color(0xffe8e8e8),
                width: 1),
          ),
          child: ListView.builder(
            itemCount: widget.listQuestion.length,
            itemBuilder: (context, index) {
              String question = widget.listQuestion[index];
              bool inEvenIndex = index % 2 == 0;
              return Container(
                decoration: BoxDecoration(
                  color: inEvenIndex ? const Color(0xfff4f4f4) : Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Text(
                        question,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...review.map((option) {
                      return RadioListTile<String>(
                        value: option,
                        title: Text(option),
                        hoverColor: Colors.red,
                        activeColor: Colors.red,
                        overlayColor: WidgetStatePropertyAll(Colors.red[100]),
                        groupValue: selectedAnswers[question],
                        onChanged: (value) {
                          setState(() {
                            selectedAnswers[question] = value!;
                            context
                                .read<RadioQuestionButtonBloc>()
                                .validate(selectedAnswers, widget.listQuestion);
                          });
                          // print(selectedAnswers);
                          // widget.onChanged(selectedAnswers);
                        },
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
