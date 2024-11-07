import 'package:dsoft_form_application/presentation/form_screen/component/checkbox_button_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxButton extends StatefulWidget {
  const CheckboxButton({
    super.key,
    required this.listCheckbox,
    this.isRequest = false,
    required this.checkboxButtonBloc,
  });
  final List<String> listCheckbox;

  final bool isRequest;
  final CheckboxButtonBloc checkboxButtonBloc;
  @override
  _CheckboxButtonState createState() => _CheckboxButtonState();
}

class _CheckboxButtonState extends State<CheckboxButton> {
  final List<String> selectedCheckboxes = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CheckboxButtonBloc(),
        child:
            BlocBuilder<CheckboxButtonBloc, bool>(builder: (context, isValid) {
          bool isError = isValid == '' ? true : false;
          if (isValid == "initial") isError = false; // khởi tạo thì error

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xfff4f4f4),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
              border: Border.fromBorderSide(BorderSide(
                  // color: widget.isRequest == true?
                  color: isError ? Colors.red : const Color(0xffe8e8e8),
                  // : const Color(0xffe8e8e8),
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
                      context
                          .read<CheckboxButtonBloc>()
                          .validate(value! ? selectedCheckboxes : []);
                    });
                  },
                  title: Text(options.toString()),
                );
              }).toList(),
            ),
          );
        }));
  }
}
