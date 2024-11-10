import 'package:dsoft_form_application/presentation/form_screen/component/bloc/radio_button_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RadioButton extends StatefulWidget {
  final List<String> listRadio;
  final String nameGroup;
  String? selected;
  final bool? isRequest;
  final RadioButtonBloc radioButtonBloc;
  bool isError;
  RadioButton({
    Key? key,
    required this.listRadio,
    required this.nameGroup,
    this.isRequest = false,
    required this.radioButtonBloc,
    required this.isError,
  }) : super(key: key);

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<RadioButton>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => widget.radioButtonBloc,
      child: BlocBuilder<RadioButtonBloc, RadioButtonState>(
        builder: (context, state) {
          // Kiểm tra lỗi nếu không có giá trị
          if (state is RadioButtonInitial) {
            widget.isError = false;
          } else {
            bool value = context.read<RadioButtonBloc>().values == null;

            if (value) {
              widget.isError = true;
            } else {
              widget.isError = false;
            }
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
                  groupValue: widget.selected,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    if (value != "error") {
                      setState(() {
                        widget.selected = value;
                        context
                            .read<RadioButtonBloc>()
                            .validate(widget.selected!);
                        print("valid update: ${state}");
                      });
                    }
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
