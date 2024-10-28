import 'package:flutter/material.dart';

class CheckboxQuestionButton extends StatefulWidget {
  const CheckboxQuestionButton(
      {super.key, required this.listCheckBox, required this.onChanged});

  @override
  _CheckboxQuestionButtonState createState() => _CheckboxQuestionButtonState();

  final List<String> listCheckBox;
  final ValueChanged onChanged;
}

class _CheckboxQuestionButtonState extends State<CheckboxQuestionButton> {
  final List<String> selectedCheckboxes = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225,
      child: ListView.builder(
        itemCount: widget.listCheckBox.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: index % 2 == 0 ? Color(0xFFf4f4f4f4) : Colors.white),
            child: CheckboxListTile(
              hoverColor: Colors.red,
              activeColor: Colors.red,
              overlayColor: WidgetStatePropertyAll(Colors.red[100]),
              value: selectedCheckboxes.contains(widget.listCheckBox[index]),
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    selectedCheckboxes.add(widget.listCheckBox[index]);
                  } else {
                    selectedCheckboxes.remove(widget.listCheckBox[index]);
                  }
                  widget.onChanged(selectedCheckboxes);
                });
              },
              title: Text(
                widget.listCheckBox[index].toString(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }
}
