import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../core/styles/app_icons.dart';

class TimePickerCustom extends StatefulWidget {
  const TimePickerCustom({super.key, required this.title});

  @override
  _TimePickerCustomState createState() => _TimePickerCustomState();
  final String title;
}

class _TimePickerCustomState extends State<TimePickerCustom> {
  var hour = 0;
  var minute = 0;
  var timeFormat = "AM";
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isVisible ? isVisible = false : isVisible = true;
            });
          },
          child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0xfff4f4f4),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                border: Border.fromBorderSide(
                    BorderSide(color: Color(0xffe8e8e8), width: 1)),
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Image.asset(AppIcons.calendar, fit: BoxFit.fitHeight),
                  const Gap(5),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: hour != null && minute != null && timeFormat != null
                        ? Text(
                            " ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")} ${timeFormat}",
                          )
                        : const Text(
                            "Giờ",
                            style: TextStyle(
                              color: Color(0xff8C8C8C),
                            ),
                          ),
                  )
                ],
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        isVisible == true
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        });
                      },
                      textStyle:
                          const TextStyle(color: Colors.grey, fontSize: 20),
                      selectedTextStyle:
                          const TextStyle(color: Colors.black, fontSize: 30),
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
                        });
                      },
                      textStyle:
                          const TextStyle(color: Colors.grey, fontSize: 20),
                      selectedTextStyle:
                          const TextStyle(color: Colors.black, fontSize: 30),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            : const Gap(8),
      ],
    );
  }
}
