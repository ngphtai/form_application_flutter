import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {Key? key, required this.listDropDown, required this.onChanged})
      : super(key: key);

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
  final List<String> listDropDown;
  final ValueChanged<List<String>> onChanged;
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        // focusNode:
        //     dropdownFocusNode, // Gán focusNode cho DropdownButton
        value: null,
        isExpanded: true,
        //HINT TEXT
        hint: const Text(
          "Lựa chọn",
          style: TextStyle(color: Colors.grey),
        ),

        iconStyleData:
            const IconStyleData(icon: Icon(Icons.keyboard_arrow_down)),
        dropdownStyleData: DropdownStyleData(
            width: size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff4f4f4f4),
            ),
            offset: const Offset(-12, -12), // Dời menu xuống 10px
            padding:
                const EdgeInsets.symmetric(horizontal: 12), // Căn đều 2 bên
            direction: DropdownDirection.textDirection),
        items:
            widget.listDropDown.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }).toList(),

        onChanged: (value) => widget.onChanged,
      ),
    );
  }
}
