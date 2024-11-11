import 'package:dsoft_form_application/presentation/form_screen/component/bloc/checkbox_question_button_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CheckboxQuestionButton extends StatefulWidget {
  CheckboxQuestionButton(
      {super.key,
      required this.listCheckBox,
      this.isRequest = false,
      this.isError = false});

  @override
  _CheckboxQuestionButtonState createState() => _CheckboxQuestionButtonState();

  final List<String> listCheckBox;

  final bool? isRequest;
  bool isError;
}

class _CheckboxQuestionButtonState extends State<CheckboxQuestionButton> {
  final List<String> selectedCheckboxes = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckboxQuestionButtonBloc, CheckBoxQuestionButtonState>(
      builder: (context, state) {
        if (state is CheckBoxQuestionButtonInitial) {
          widget.isError = false;
        } else {
          List<String> value =
              context.read<CheckboxQuestionButtonBloc>().getValue;
          // print("value in checkbox is $value");
          if (value.isNotEmpty) {
            widget.isError = false;
          } else {
            widget.isError = true;
          }
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(
                color: widget.isRequest == true
                    ? !widget.isError
                        ? const Color(0xffe8e8e8)
                        : Colors.red
                    : const Color(0xffe8e8e8),
                width: 1),
          ),
          height: 225,
          child: ListView.builder(
            itemCount: widget.listCheckBox.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? const Color(0xFFf4f4f4f4)
                        : Colors.white),
                child: CheckboxListTile(
                  hoverColor: Colors.red,
                  activeColor: Colors.red,
                  overlayColor: WidgetStatePropertyAll(Colors.red[100]),
                  value:
                      selectedCheckboxes.contains(widget.listCheckBox[index]),
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        selectedCheckboxes.add(widget.listCheckBox[index]);
                      } else {
                        selectedCheckboxes.remove(widget.listCheckBox[index]);
                      }
                      context
                          .read<CheckboxQuestionButtonBloc>()
                          .validate(selectedCheckboxes);
                      print(selectedCheckboxes);
                      // widget.onChanged(selectedCheckboxes);
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
      },
    );
  }
}
