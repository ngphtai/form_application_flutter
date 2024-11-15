import 'package:dsoft_form_application/presentation/form_screen/component/bloc/radio_button_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) => widget.radioButtonBloc,
      child: BlocBuilder<RadioButtonBloc, RadioButtonState>(
          builder: (context, state) {
        if (widget.controller.text.isNotEmpty) {
          String value = widget.controller.text;
          context.read<RadioButtonBloc>().validate(value);
        }
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
                  ? (!widget.isError ? Colors.white : Colors.red)
                  : Colors.white,
              width: 1,
            )),
          ),
          child: Column(
            children: widget.listRadio.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: widget.controller.text.isEmpty
                    ? widget.selected
                    : widget.controller.text,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(() {
                    widget.selected = value;
                    context.read<RadioButtonBloc>().validate(value!);
                    print("valid update: ${state}");
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
