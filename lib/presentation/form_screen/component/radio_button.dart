import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/radio_button_bloc.dart';

// ignore: must_be_immutable
class RadioButton extends StatefulWidget {
  RadioButton({
    super.key,
    required this.listRadio,
    required this.nameGroup,
    this.isRequest,
    required this.radioButtonBloc,
    required this.controller,
  });
  final List<String> listRadio;
  final String nameGroup;
  String? selected;
  final bool? isRequest;
  final RadioButtonBloc radioButtonBloc;
  bool isError = false;
  final TextEditingController controller;
  @override
  // ignore: library_private_types_in_public_api
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton>
    with AutomaticKeepAliveClientMixin {
  bool isClose = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => widget.radioButtonBloc,
      child: BlocBuilder<RadioButtonBloc, RadioButtonState>(
          builder: (context, state) {
        // handle get value from local database
        if (widget.controller.text.isNotEmpty && isClose == false) {
          String value = widget.controller.text;
          widget.selected = value;
          context.read<RadioButtonBloc>().validate(value);
          isClose = true;
        }
        //handle error when init and validate
        if (state is RadioButtonInitial) {
          widget.isError = false;
        } else {
          bool isNoEmpty = context.read<RadioButtonBloc>().value != null;
          isNoEmpty ? widget.isError = false : widget.isError = true;
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.fromBorderSide(BorderSide(
              color: widget.isRequest == true
                  ? (!widget.isError ? Colors.white : const Color(0xffdb1e39))
                  : Colors.white,
              width: 1,
            )),
          ),
          child: Column(
            children: widget.listRadio.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: widget.selected,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(() {
                    widget.selected = value;
                    context.read<RadioButtonBloc>().validate(value!);
                  });
                },
              );
            }).toList(),
          ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
