import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'text_field_bloc.dart';

class TextFieldCustoms extends StatefulWidget {
  TextFieldCustoms(
      {Key? key,
      required this.maxLine,
      this.isRequest = false,
      required this.textFieldBLoc})
      : super(key: key);

  @override
  _TextFieldCustomsState createState() => _TextFieldCustomsState();
  final int maxLine;

  final bool isRequest;
  final TextEditingController textController = TextEditingController();

  final TextFieldBLoc textFieldBLoc;
}

class _TextFieldCustomsState extends State<TextFieldCustoms> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => widget.textFieldBLoc,
        child: BlocBuilder<TextFieldBLoc, TextFieldState>(
          builder: (context, isValid) {
            print(isValid);
            print(widget.textController.text);
            bool isError = false;
            if (isValid.state != null && isValid.state!.isNotEmpty) {
              isError = false;
            } else if (isValid is NonValid || isValid is TextFieldInValid) {
              isError = true;
            }

            return Container(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              decoration: BoxDecoration(
                color: const Color(0xfff4f4f4),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
                border: Border.fromBorderSide(BorderSide(
                    color: widget.isRequest == true
                        ? isError
                            ? Colors.red
                            : const Color(0xffe8e8e8)
                        : const Color(0xffe8e8e8),
                    width: 1)),
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
                  BlocProvider.of<TextFieldBLoc>(context)
                      .validate(value, widget.isRequest);
                },
                maxLines: widget.maxLine,
              ),
            );
          },
        ));
  }
}
