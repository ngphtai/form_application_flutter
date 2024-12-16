// ignore_for_file: must_be_immutable

import '/presentation/form_screen/component/bloc/time_picker_custom_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../core/styles/app_icons.dart';

class TimePickerCustom extends StatefulWidget {
  TimePickerCustom({
    super.key,
    required this.title,
    this.isRequest = false,
    required this.timePickerCustomBloc,
    required this.controller,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TimePickerCustomState createState() => _TimePickerCustomState();

  final String title;
  bool isError = false;
  final bool isRequest;
  final TimePickerCustomBloc timePickerCustomBloc;
  final TextEditingController controller;
}

class _TimePickerCustomState extends State<TimePickerCustom>
    with AutomaticKeepAliveClientMixin {
  int hour = 0;
  int minute = 0;
  String? timeFormat = "AM";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TimePickerCustomBloc, TimePickerState>(
      builder: (context, state) {
        // Handle getting the initial value
        if (widget.controller.text.isNotEmpty) {
          String value = widget.controller.text;
          context.read<TimePickerCustomBloc>().changeValue(value);
          controller.text = value;
        }

        String value = context.read<TimePickerCustomBloc>().getTime.toString();

        if (state is TimePickerInitial) {
          widget.isError = false;
        }
        if (state is TimePickerChanged) {
          if (value.isEmpty || (value.isNotEmpty && timeFormat == null)) {
            widget.isError = true;
          } else {
            widget.isError = false;
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _showTimePickerBottomSheet(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: const Color(0xfff4f4f4),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      border: Border.all(
                        color: widget.isRequest
                            ? !widget.isError
                                ? const Color(0xffe8e8e8)
                                : const Color(0xffdb1e39)
                            : const Color(0xffe8e8e8),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Image.asset(AppIcons.calendar, fit: BoxFit.fitHeight),
                        const Gap(10),
                        Expanded(
                          child: TextField(
                            controller: controller.text.isEmpty
                                ? TextEditingController(text: "Giờ")
                                : controller,
                            style: const TextStyle(color: Colors.black),
                            keyboardType: null,
                            onTap: () {
                              _showTimePickerBottomSheet(context);
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.isRequest
                      ? widget.isError
                          ? const Text(
                              "Câu hỏi này bắt buộc *",
                              style: TextStyle(color: Color(0xffdb1e39)),
                            )
                          : const SizedBox()
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTimePickerBottomSheet(BuildContext context) {
    // Parse current text to set initial values
    if (controller.text.isNotEmpty && controller.text != "Giờ") {
      List<String> parts = controller.text.split(" ");
      if (parts.length == 2) {
        List<String> timeParts = parts[0].split(":");
        if (timeParts.length == 2) {
          hour = int.tryParse(timeParts[0]) ?? hour;
          minute = int.tryParse(timeParts[1]) ?? minute;
        }
        timeFormat = parts[1];
      }
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setBottomSheetState) {
            return Container(
              height: 250.h,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100.w,
                    height: 5.h,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10))),
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NumberPicker(
                        minValue: 0,
                        maxValue: 12,
                        value: hour,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 60,
                        onChanged: (value) {
                          setBottomSheetState(() {
                            hour = value;
                            _updateControllerText();
                          });
                        },
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                        selectedTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      const Text(":",
                          style: TextStyle(
                            fontSize: 30,
                          )),
                      NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: minute,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 60,
                        onChanged: (value) {
                          setBottomSheetState(() {
                            minute = value;
                            _updateControllerText();
                          });
                        },
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                        selectedTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setBottomSheetState(() {
                                timeFormat = "AM";
                                _updateControllerText();
                              });
                            },
                            child: _timeFormatButton(
                              "AM",
                              isSelected: timeFormat == "AM",
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              setBottomSheetState(() {
                                timeFormat = "PM";
                                _updateControllerText();
                              });
                            },
                            child: _timeFormatButton(
                              "PM",
                              isSelected: timeFormat == "PM",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _timeFormatButton(String format, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xffdb1e39) : const Color(0xFFc7c7c7),
        border: Border.all(
          color: isSelected ? Colors.grey : const Color(0xFFc7c7c7),
        ),
      ),
      child: Text(
        format,
        style: const TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  void _updateControllerText() {
    controller.text = timeFormat != null
        ? "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeFormat"
        : "Giờ";
    context.read<TimePickerCustomBloc>().changeValue(controller.text);
  }

  @override
  bool get wantKeepAlive => true;
}
