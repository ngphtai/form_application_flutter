import 'package:dsoft_form_application/common/extensions/string_to_datetime.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/date_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: must_be_immutable
class DatePicker extends StatefulWidget {
  DatePicker({
    super.key,
    this.isRequest = false,
    required this.isError,
    required this.datePickerBloc,
    required this.controller,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DatePickerState createState() => _DatePickerState();
  final bool? isRequest;
  final DatePickerBloc datePickerBloc;
  DateTime? datePicker;
  final TextEditingController controller;
  bool isError;
}

class _DatePickerState extends State<DatePicker>
    with AutomaticKeepAliveClientMixin {
  bool isClose = false;
  DateRangePickerController dateRangePickerController =
      DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<DatePickerBloc, DatePickerState>(
        builder: (context, state) {
      if (widget.controller.text.isNotEmpty && !isClose) {
        String value = widget.controller.text;
        AppLogger.instance.f(value);
        context.read<DatePickerBloc>().validate(value.toDateTime());
        widget.datePicker = value.toDateTime();
        isClose = true;
        convertTextEditingToDateRange(
            widget.controller); // cover to DateRangePickerController
      }
      //check error
      if (state is DatePickerInitial) {
        widget.isError = false;
      } else if (state is DatePickerChangedValue) {
        DateTime? date = context.read<DatePickerBloc>().getValue;
        // print("value date $date");
        if (date == null) {
          widget.isError = true;
        } else {
          widget.isError = false;
        }
      }
      return SizedBox(
        width: 1000.w,
        child: GestureDetector(
            onTap: () async {
              _showBottomSheet();
              // ignore: use_build_context_synchronously
              context.read<DatePickerBloc>().validate(widget.datePicker);
              // print("onTap ${widget.datePicker}");
            },
            child: Container(
                width: 1000.w,
                decoration: BoxDecoration(
                  color: const Color(0xfff4f4f4),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                  border: Border.all(
                      color: widget.isRequest == true
                          ? widget.isError
                              ? const Color(0xffdb1e39)
                              : const Color(0xffe8e8e8)
                          : const Color(0xffe8e8e8),
                      width: 1),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Image.asset(AppIcons.calendar, fit: BoxFit.fitHeight),
                    const Gap(5),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: dateRangePickerController.selectedDate != null
                          ? Text(
                              "${dateRangePickerController.selectedDate!.day}/${dateRangePickerController.selectedDate!.month}/${dateRangePickerController.selectedDate!.year}")
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
    });
  }

  void _showBottomSheet() {
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
              height: 450.h,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  // Thanh ngang bo tròn ở trên
                  Container(
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  const SizedBox(height: 10),
                  // Widget SfDateRangePicker
                  Expanded(
                    child: SfDateRangePicker(
                      view: DateRangePickerView.month,
                      showNavigationArrow: true,
                      selectionShape: DateRangePickerSelectionShape.rectangle,
                      toggleDaySelection: true,
                      controller: dateRangePickerController,
                      todayHighlightColor: const Color(0xffdb1e39),
                      selectionColor: const Color(0xffdb1e39),
                      backgroundColor: Colors.white,
                      headerStyle: const DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          color: Color(0xffdb1e39),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                        dayFormat: 'EEE',
                        firstDayOfWeek: 1,
                      ),
                    ),
                  ),
                  // Nút "Huỷ" và "OK"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Button "Huỷ"
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size(0.40.sw, 50),
                          side: const BorderSide(
                              color: Color(0xffdb1e39), width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Huỷ",
                          style: TextStyle(
                            color: Color(0xffdb1e39),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(10.w),
                      // Button "OK"
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffdb1e39),
                          minimumSize: Size(0.40.sw, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          AppLogger.instance.i(dateRangePickerController
                              .selectedDate
                              .toString());
                          widget.controller.text =
                              dateRangePickerController.selectedDate.toString();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.white, // Chữ màu trắng
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20), // Khoảng cách cuối
                ],
              ),
            );
          },
        );
      },
    );
  }

  DateRangePickerController convertTextEditingToDateRange(
      TextEditingController textController) {
    // Tách chuỗi theo dấu cách
    List<String> parts = textController.text.split(" ");
    if (parts.length >= 2) {
      // Chuyển đổi phần ngày giờ thành DateTime
      String datePart = parts[0]; // "11/14/2024"
      String timePart = parts[1]; // "12:00:09"

      DateTime parsedDateTime =
          DateFormat("yyyy-MM-dd HH:mm:ss").parse("$datePart $timePart");

      // Cập nhật DateRangePickerController
      dateRangePickerController.selectedDate = parsedDateTime;
      return dateRangePickerController;
    }
    return dateRangePickerController;
  }

  @override
  bool get wantKeepAlive => true;
}
