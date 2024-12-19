import 'package:dsoft_form_application/core/styles/app_text_style.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/checkbox_button_bloc.dart';

// ignore: must_be_immutable
class CheckboxButton extends StatefulWidget {
  CheckboxButton(
      {super.key,
      required this.listCheckbox,
      required this.isRequest,
      required this.checkboxButtonBloc,
      required this.controller});
  final List<String> listCheckbox;
  bool isError = false;
  final bool isRequest;
  final CheckboxButtonBloc checkboxButtonBloc;
  final TextEditingController controller;
  @override
  // ignore: library_private_types_in_public_api
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
              border: Border.fromBorderSide(BorderSide(
                  color: widget.isRequest == true
                      ? widget.isError
                          ? const Color(0xffdb1e39)
                          : Colors.white
                      : Colors.white,
                  width: 1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.listCheckbox.map((options) {
                return CheckboxListTile(
                  hoverColor: const Color(0xffdb1e39),
                  activeColor: const Color(0xffdb1e39),
                  overlayColor: WidgetStatePropertyAll(Colors.red[100]),
                  value: selectedCheckboxes.contains(options),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) async {
                    await FirebaseAnalytics.instance.logEvent(
                      name: 'tap_checkbox',
                    );
                    setState(() {
                      if (value == true) {
                        selectedCheckboxes.add(options);
                      } else {
                        selectedCheckboxes.remove(options);
                      }
                      // print(selectedCheckboxes);
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
                  title: Text(options.toString(),
                      style: AppTextStyle.regular14
                          .copyWith(fontWeight: FontWeight.w400)),
                );
              }).toList(),
            ),
          ),
          widget.isRequest == true
              ? widget.isError
                  ? Text(
                      "Câu hỏi này bắt buộc *",
                      style: AppTextStyle.regular12
                          .copyWith(color: const Color(0xffdb1e39)),
                    )
                  : const SizedBox()
              : const SizedBox(),
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
