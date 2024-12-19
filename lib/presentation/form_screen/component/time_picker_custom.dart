// ignore_for_file: must_be_immutable

import 'package:firebase_analytics/firebase_analytics.dart';

import '../../../core/styles/app_text_style.dart';
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
                            controller: controller,
                            style: const TextStyle(color: Colors.black),
                            //không cho phép nhập bằng bàn phím
                            enabled: false,
                            onTap: () async {
                              _showTimePickerBottomSheet(context);
                              await FirebaseAnalytics.instance
                                  .logEvent(name: "tap_time_picker");
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Giờ",
                                hintStyle: AppTextStyle.regular14),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel_outlined,
                              color: Color(0xff818688)),
                          onPressed: () {
                            context
                                .read<TimePickerCustomBloc>()
                                .changeValue("false");
                            widget.isError = true;
                            controller.text = "";
                          },
                        ),
                      ],
                    ),
                  ),
                  widget.isRequest
                      ? widget.isError
                          ? Text("Câu hỏi này bắt buộc *",
                              style: AppTextStyle.regular14.copyWith(
                                color: const Color(0xffdb1e39),
                              ))
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
    String? selectTime = context.read<TimePickerCustomBloc>().getTime;
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
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100.w,
                        height: 5.h,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumberPicker(
                            minValue: 0,
                            maxValue: 23,
                            value: hour,
                            zeroPad: true,
                            infiniteLoop: true,
                            itemWidth: 100,
                            itemHeight: 60,
                            onChanged: (value) {
                              setBottomSheetState(() {
                                hour = value;
                                _updateControllerText(null);
                              });
                            },
                            textStyle: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                            selectedTextStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(" : ",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          NumberPicker(
                            minValue: 0,
                            maxValue: 59,
                            value: minute,
                            zeroPad: true,
                            infiniteLoop: true,
                            itemWidth: 100,
                            itemHeight: 60,
                            onChanged: (value) {
                              setBottomSheetState(() {
                                minute = value;
                                _updateControllerText(null);
                              });
                            },
                            textStyle: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                            selectedTextStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () async {
                                _updateControllerText(selectTime ?? "");
                                Navigator.pop(context);
                                await FirebaseAnalytics.instance
                                    .logEvent(name: "tap_cancel_time_picker");
                              },
                              style: TextButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xffdb1e39)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.19.sw, vertical: 10.h),
                              ),
                              child: Text("Huỷ",
                                  style: AppTextStyle.bold16.copyWith(
                                      color: const Color(0xffdb1e39)))),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              _updateControllerText(null);
                              await FirebaseAnalytics.instance
                                  .logEvent(name: "tap_ok_time_picker");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffdb1e39),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.19.sw, vertical: 10.h),
                            ),
                            child: Text(
                              "OK",
                              style: AppTextStyle.bold16
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _updateControllerText(String? value) {
    controller.text = value ??
        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
    context.read<TimePickerCustomBloc>().changeValue(value ?? controller.text);
  }

  @override
  bool get wantKeepAlive => true;
}
