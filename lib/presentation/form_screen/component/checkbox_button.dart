import 'package:flutter/material.dart';

class CheckboxButton extends StatefulWidget {
  const CheckboxButton({
    super.key,
    required this.listCheckbox,
    required this.onChanged,
    required this.isError,
    this.isRequest = false,
  });
  final List<String> listCheckbox;
  final ValueChanged<List<String>> onChanged;
  final bool isError;
  final bool isRequest;
  @override
  _CheckboxButtonState createState() => _CheckboxButtonState();
}

class _CheckboxButtonState extends State<CheckboxButton> {
  final List<String> selectedCheckboxes = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff4f4f4),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.fromBorderSide(BorderSide(
            color: widget.isRequest == true
                ? !widget.isError
                    ? const Color(0xffe8e8e8)
                    : Colors.red
                : const Color(0xffe8e8e8),
            width: 1)),
      ),
      child: Column(
        children: widget.listCheckbox.map((options) {
          return CheckboxListTile(
            hoverColor: Colors.red,
            activeColor: Colors.red,
            overlayColor: WidgetStatePropertyAll(Colors.red[100]),
            value: selectedCheckboxes.contains(options),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedCheckboxes.add(options);
                } else {
                  selectedCheckboxes.remove(options);
                }
                widget.onChanged(selectedCheckboxes);
              });
            },
            title: Text(options.toString()),
          );
        }).toList(),
      ),
    );
  }
}