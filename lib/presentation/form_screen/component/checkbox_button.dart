import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/checkbox_button_bloc.dart';

// ignore: must_be_immutable
class CheckboxButton extends StatefulWidget {
  CheckboxButton(
      {Key? key,
      required this.listCheckbox,
      required this.isRequest,
      required this.checkboxButtonBloc,
      required this.controller})
      : super(key: key);
  final List<String> listCheckbox;
  bool isError = false;
  final bool isRequest;
  final CheckboxButtonBloc checkboxButtonBloc;
  final TextEditingController controller;
  @override
  _CheckboxButtonState createState() => _CheckboxButtonState();
}

class _CheckboxButtonState extends State<CheckboxButton>
    with AutomaticKeepAliveClientMixin {
  final List<String> selectedCheckboxes = [];
  bool isClose = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.controller.text.isNotEmpty && !isClose) {
      final items = widget.controller.text
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',');
      selectedCheckboxes.addAll(items.map((e) => e.trim()));
      context.read<CheckboxButtonBloc>().validate(selectedCheckboxes);
      isClose = true;
    }
    return BlocBuilder<CheckboxButtonBloc, CheckboxButtonState>(
        builder: (context, state) {
      if (state is CheckboxButtonInitial) {
        widget.isError = false;
      } else {
        bool isValid = context.read<CheckboxButtonBloc>().values.isNotEmpty;
        isValid ? widget.isError = false : widget.isError = true;
      }
      return Container(
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
                  print(selectedCheckboxes);
                  context
                      .read<CheckboxButtonBloc>()
                      .validate(selectedCheckboxes);
                  if (selectedCheckboxes.isEmpty) {
                    widget.isError = true;
                  } else {
                    widget.isError = false;
                  }
                });
              },
              title: Text(options.toString()),
            );
          }).toList(),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
