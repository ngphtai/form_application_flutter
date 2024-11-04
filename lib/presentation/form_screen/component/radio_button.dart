import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RadioButton extends StatefulWidget {
  final List<String> listRadio;
  final String nameGroup;
  final ValueChanged<String?> onChanged;
  String? selected;
  final bool? isRequest;
  final bool isError;
  RadioButton({
    Key? key,
    required this.listRadio,
    required this.nameGroup,
    required this.onChanged,
    this.isRequest = false,
    this.isError = false,
  }) : super(key: key);

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.fromBorderSide(BorderSide(
            color: widget.isRequest == true
                ? !widget.isError
                    ? Colors.white
                    : Colors.red
                : Colors.white,
            width: 1)),
      ),
      child: Column(
        children: widget.listRadio.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: widget.selected,
            activeColor: Colors.red,
            overlayColor: WidgetStatePropertyAll(Colors.red[100]),
            onChanged: (value) {
              setState(() {
                widget.selected = value;
              });
              widget.onChanged(value);
            },
          );
        }).toList(),
      ),
    );
  }
}
