import 'package:flutter/material.dart';

class TextFieldCustomWithoutBloc extends StatefulWidget {
  TextFieldCustomWithoutBloc(
      {Key? key,
      required this.maxLine,
      required this.isError,
      required this.onChanged,
      required this.isRequest,
      required this.textController})
      : super(key: key);

  @override
  _TextFieldCustomWithoutBlocState createState() =>
      _TextFieldCustomWithoutBlocState();
  final int maxLine;
  final bool isError;
  final ValueChanged onChanged;
  final bool isRequest;
  final TextEditingController textController;
}

class _TextFieldCustomWithoutBlocState
    extends State<TextFieldCustomWithoutBloc> {
  Color getBorderColor() {
    Color color;
    if (widget.isRequest == true) {
      color = widget.isError ? Colors.red : const Color(0xffe8e8e8);
    } else {
      color = const Color(0xffe8e8e8);
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      decoration: BoxDecoration(
        color: const Color(0xfff4f4f4),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.fromBorderSide(
            BorderSide(color: getBorderColor(), width: 1)),
      ),
      child: TextField(
        controller: widget.textController,
        decoration: InputDecoration(
          hintText: "Lựa chọn",
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 10),
        ),
        onChanged: (value) {
          setState(() {});
        },
        maxLines: widget.maxLine,
      ),
    );
  }
}
