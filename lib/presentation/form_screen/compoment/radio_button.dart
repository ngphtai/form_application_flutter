import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final List<String> listRadio;
  final String nameGroup;
  final ValueChanged<String?> onChanged;

  const RadioButton({
    Key? key,
    required this.listRadio,
    required this.nameGroup,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.listRadio.map((option) {
        return RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: widget.nameGroup,
          onChanged: widget.onChanged,
        );
      }).toList(),
    );
  }
}
