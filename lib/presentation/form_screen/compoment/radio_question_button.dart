import 'package:flutter/material.dart';

class RadioQuestionButton extends StatefulWidget {
  const RadioQuestionButton({
    Key? key,
    required this.listQuestion,
    required this.onChanged,
  }) : super(key: key);

  @override
  _RadioQuestionButtonState createState() => _RadioQuestionButtonState();
  final List<String> listQuestion;
  final ValueChanged<Map<String, String>> onChanged;
}

List<String> review = ["Xuất sắc", "Tốt", "Trung bình", "Kém"];

class _RadioQuestionButtonState extends State<RadioQuestionButton> {
  Map<String, String> selectedAnswers = {};

  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: ListView.builder(
        itemCount: widget.listQuestion.length,
        itemBuilder: (context, index) {
          String question = widget.listQuestion[index];
          bool inEvenIndex = index % 2 == 0;
          return Container(
            decoration: BoxDecoration(
                color: inEvenIndex ? Color(0xfff4f4f4) : Colors.white),
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
                      });
                      widget.onChanged(selectedAnswers);
                    },
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
