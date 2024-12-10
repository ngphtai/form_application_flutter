import '/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => widget.radioButtonBloc,
      child: BlocBuilder<RadioButtonBloc, RadioButtonState>(
          builder: (context, state) {
        final bloc = context.read<RadioButtonBloc>();
        // handle get value from local database
        if (widget.controller.text.isNotEmpty && bloc.value == null) {
          String value = widget.controller.text;
          bloc.validate(value);
        }
        //handle error when init and validate
        if (state is RadioButtonInitial) {
          widget.isError = false;
        } else {
          bool isNoEmpty = bloc.value != null;
          isNoEmpty ? widget.isError = false : widget.isError = true;
        }
        String? selected = bloc.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: widget.isRequest == true
                        ? (!widget.isError
                            ? Colors.white
                            : const Color(0xffdb1e39))
                        : Colors.white,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: widget.listRadio.map((option) {
                  return GestureDetector(
                    onTap: () {
                      if (bloc.value == option) {
                        bloc.validate("");
                        widget.controller.text = "";
                      } else {
                        bloc.validate(option);
                        widget.controller.text = option;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        children: [
                          Gap(0.05.sw),
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: option == selected
                                    ? const Color(0xffdb1e39)
                                    : Colors.black,
                                width: 2,
                              ),
                              color: option == selected
                                  ? const Color(0xffdb1e39)
                                  : Colors.transparent,
                            ),
                            child: option == selected
                                ? const Center(
                                    child: Icon(
                                      Icons.check,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                          Text(
                            option,
                            style: AppTextStyle.regular14,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            widget.isRequest == true
                ? widget.isError
                    ? const Text(
                        "Câu hỏi này bắt buộc *",
                        style: TextStyle(color: Color(0xffdb1e39)),
                      )
                    : const SizedBox()
                : const SizedBox(),
          ],
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
