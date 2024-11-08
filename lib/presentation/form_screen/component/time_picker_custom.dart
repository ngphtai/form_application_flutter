// ignore_for_file: must_be_immutable

import 'package:dsoft_form_application/presentation/form_screen/component/time_picker_customs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../core/styles/app_icons.dart';

class TimePickerCustom extends StatefulWidget {
  TimePickerCustom({
    super.key,
    required this.title,
    this.isRequest = false,
    required this.timePickerCustomBloc,
    required this.isError,
  });

  @override
  _TimePickerCustomState createState() => _TimePickerCustomState();
  final String title;
  bool isError;
  final bool isRequest;
  final TimePickerCustomBloc timePickerCustomBloc;
}

class _TimePickerCustomState extends State<TimePickerCustom>
    with AutomaticKeepAliveClientMixin {
  // ignore: prefer_typing_uninitialized_variables
  var hour = 0;
  // ignore: prefer_typing_uninitialized_variables
  var minute = 0;
  // ignore: prefer_typing_uninitialized_variables
  var timeFormat;
  bool isVisible = false;
  String formattedTime = "";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<TimePickerCustomBloc, TimePickerState>(
        builder: (context, state) {
      String value = context.read<TimePickerCustomBloc>().getState.toString();

      if (state is TimePickerInitial) {
        widget.isError == false;
      }
      if (state is TimePickerChanged) {
        if (value.isEmpty || (value.isNotEmpty && timeFormat == null)) {
          widget.isError = true;
        } else {
          widget.isError = false;
        }
      }
      print("update values is $value");

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isVisible ? isVisible = false : isVisible = true;
              });
            },
            child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: const Color(0xfff4f4f4),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                  border: Border.all(
                      color: true
                          ? !widget.isError
                              ? const Color(0xffe8e8e8)
                              : Colors.red
                          : const Color(0xffe8e8e8),
                      width: 1),
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
                        style: TextStyle(color: Colors.black),
                        keyboardType: null,
                        onTap: () {
                          setState(() {
                            isVisible ? isVisible = false : isVisible = true;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          isVisible == true
              ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xFFf4f4f4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              setState(() {
                                hour = value;
                                controller.text = timeFormat != null
                                    ? "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeFormat"
                                    : "Giờ";
                                if (controller.text.isNotEmpty ||
                                    controller.text != "Giờ") {
                                  context
                                      .read<TimePickerCustomBloc>()
                                      .changeValue(controller.text);
                                }
                              });
                            },
                            textStyle: const TextStyle(
                                color: Colors.grey, fontSize: 20),
                            selectedTextStyle: const TextStyle(
                                color: Colors.black, fontSize: 30),
                            decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                    color: Colors.white,
                                  ),
                                  bottom: BorderSide(color: Colors.white)),
                            ),
                          ),
                          NumberPicker(
                            minValue: 0,
                            maxValue: 59,
                            value: minute,
                            zeroPad: true,
                            infiniteLoop: true,
                            itemWidth: 80,
                            itemHeight: 60,
                            onChanged: (value) {
                              setState(() {
                                minute = value;
                                controller.text = timeFormat != null
                                    ? "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeFormat"
                                    : "Giờ";
                                if (controller.text.isNotEmpty ||
                                    controller.text != "Giờ") {
                                  context
                                      .read<TimePickerCustomBloc>()
                                      .changeValue(controller.text);
                                }
                              });
                            },
                            textStyle: const TextStyle(
                                color: Colors.grey, fontSize: 20),
                            selectedTextStyle: const TextStyle(
                                color: Colors.black, fontSize: 30),
                            decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                    color: Colors.white,
                                  ),
                                  bottom: BorderSide(color: Colors.white)),
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    timeFormat = "AM";
                                    controller.text = timeFormat != null
                                        ? "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeFormat"
                                        : "Giờ";
                                    if (controller.text.isNotEmpty ||
                                        controller.text != "Giờ") {
                                      context
                                          .read<TimePickerCustomBloc>()
                                          .changeValue(controller.text);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: timeFormat == "AM"
                                          ? Colors.grey.shade800
                                          : Color(0xFFc7c7c7),
                                      border: Border.all(
                                        color: timeFormat == "AM"
                                            ? Colors.grey
                                            : Color(0xFFc7c7c7),
                                      )),
                                  child: const Text(
                                    "AM",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    timeFormat = "PM";
                                    controller.text = timeFormat != null
                                        ? "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeFormat"
                                        : "Giờ";
                                    if (controller.text.isNotEmpty ||
                                        controller.text != "Giờ") {
                                      context
                                          .read<TimePickerCustomBloc>()
                                          .changeValue(controller.text);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: timeFormat == "PM"
                                        ? Colors.grey.shade800
                                        : Color(0xFFc7c7c7),
                                    border: Border.all(
                                      color: timeFormat == "PM"
                                          ? Colors.grey
                                          : Color(0xFFc7c7c7),
                                    ),
                                  ),
                                  child: const Text(
                                    "PM",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    // if (state is TimePickerInitial)
                    //   Text("Intinal")
                    // else if (state is TimePickerChanged)
                    //   Column(
                    //     children: [
                    //       Text('Slider Value: ${state.value}'),
                    //       Slider(
                    //         value: double.parse(state.value),
                    //         min: 0.0,
                    //         max: 100.0,
                    //         divisions: 10,
                    //         label: '$_sliderValue',
                    //         onChanged: (double value) {
                    //           context
                    //               .read<TimePickerCustomBloc>()
                    //               .changeValue(value.toString());
                    //         },
                    //       ),
                    //       Text("Changed: ${state.value}"),
                    //     ],
                    //   )
                  ],
                )
              : const Gap(8),
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
