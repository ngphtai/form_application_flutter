import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/material_date_range_picker_dialog.dart';
import 'package:gap/gap.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? datePicker = null;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: GestureDetector(
          onTap: () {
            // _selectDate(context);
            MaterialDateRangePickerDialog.showDatePicker(
              context,
              title: "Chọn ngày: ",
              selectDateActionCallback: (date) {
                setState(() {
                  datePicker = date;
                });
              },
              autoClose: true,
            );
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
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Image.asset(AppIcons.calendar, fit: BoxFit.fitHeight),
                  const Gap(5),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: datePicker != null
                        ? Text(
                            "${datePicker!.day}/${datePicker!.month}/${datePicker!.year}")
                        : const Text(
                            "Tháng, ngày, năm ",
                            style: TextStyle(
                              color: Color(0xff8C8C8C),
                            ),
                          ),
                  )
                ],
              ))),
    );
  }

  // _selectDate(BuildContext context) async {
  //   final DateTime? selected = await showDatePicker(
  //     context: context,
  //     initialDate: datePicker ?? DateTime.now(),
  //     firstDate: DateTime(2010),
  //     lastDate: DateTime(2025),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: Colors.red,
  //             onPrimary: Colors.white,
  //             onSurface: Colors.black,
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               foregroundColor: Colors.red, // Màu nút "OK" và "Cancel"
  //             ),
  //           ),
  //           dialogBackgroundColor: Colors.white, // Màu nền
  //           datePickerTheme: DatePickerThemeData(
  //             dayStyle: const TextStyle(
  //                 color: Colors.black), // Màu chữ của ngày trong lịch
  //             todayForegroundColor: MaterialStateProperty.all(
  //                 Colors.black), // Màu của ngày hôm nay

  //             headerForegroundColor: Colors.red, // Màu của tiêu đề (tháng, năm)
  //             yearStyle: TextStyle(color: Colors.black), // Màu chữ của năm
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (selected != null && selected != datePicker) {
  //     setState(() {
  //       datePicker = selected;
  //     });
  //   }
  // }
}
