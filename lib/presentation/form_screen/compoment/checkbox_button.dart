import 'package:flutter/material.dart';

class CheckboxButton extends StatefulWidget {
  const CheckboxButton({
    super.key,
    required this.listCheckbox,
    required this.onChanged,
  });
  final List<String> listCheckbox;
  final ValueChanged<List<String>> onChanged;
  @override
  _CheckboxButtonState createState() => _CheckboxButtonState();
}

class _CheckboxButtonState extends State<CheckboxButton> {
  final List<String> selectedCheckboxes = [];
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
