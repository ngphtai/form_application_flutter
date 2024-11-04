import 'package:flutter/material.dart';

class TextFieldCustoms extends StatefulWidget {
  const TextFieldCustoms(
      {Key? key,
      required this.MaxLine,
      required this.onChanged,
      required this.isError,
      this.isRequest = false})
      : super(key: key);

  @override
  _TextFieldCustomsState createState() => _TextFieldCustomsState();
  final int MaxLine;
  final ValueChanged onChanged;
  final bool isError;
  final bool isRequest;
}

class _TextFieldCustomsState extends State<TextFieldCustoms> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      decoration: BoxDecoration(
        color: const Color(0xfff4f4f4),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.fromBorderSide(BorderSide(
            color: widget.isRequest == true
                ? widget.isError
                    ? Colors.red
                    : const Color(0xffe8e8e8)
                : const Color(0xffe8e8e8),
            width: 1)),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Lựa chọn",
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 10),
        ),
        onChanged: widget.onChanged,
        maxLines: widget.MaxLine,
      ),
    );
  }
}
