import 'package:dsoft_form_application/common/constant/constants.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';

import '../../../core/styles/app_text_style.dart';
import '/common/extensions/string_to_datetime.dart';
import '/common/logger/app_logger.dart';
import '/core/styles/app_icons.dart';
import '/presentation/form_screen/component/bloc/date_picker_bloc.dart';
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
        isClose = true;
        convertTextEditingToDateRange(
            widget.controller); // cover to DateRangePickerController
      }
      //check error
      if (state is DatePickerInitial) {
        widget.isError = false;
      } else if (state is DatePickerChangedValue) {
        DateTime? date = context.read<DatePickerBloc>().getValue;
        // AppLogger.instance.e("value date when run $date");
        widget.isError = date == null ? true : false;
      }
      return SizedBox(
        width: 1000.w,
        child: GestureDetector(
            onTap: () async {
              await diAnalytics.log(LogEvents.tap_date_picker, null);
              await _showBottomSheet();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                                "${dateRangePickerController.selectedDate!.day}/${dateRangePickerController.selectedDate!.month}/${dateRangePickerController.selectedDate!.year}",
                                style: AppTextStyle.regular14)
                            : Text("Tháng, ngày, năm ",
                                style: AppTextStyle.regular14.copyWith(
                                  color: const Color(0xff8C8C8C),
                                )),
                      )
                    ],
                  ),
                ),
                widget.isRequest == true
                    ? widget.isError
                        ? Text(
                            "Câu hỏi này bắt buộc *",
                            style: AppTextStyle.regular14
                                .copyWith(color: const Color(0xffdb1e39)),
                          )
                        : const SizedBox()
                    : const SizedBox(),
              ],
            )),
      );
    });
  }

  Future<void> _showBottomSheet() async {
    DateTime? selectedTempDate = context.read<DatePickerBloc>().getValue;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: widget.datePickerBloc,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setBottomSheetState) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        SfDateRangePicker(
                          view: DateRangePickerView.month,
                          showNavigationArrow: true,
                          selectionShape:
                              DateRangePickerSelectionShape.rectangle,
                          toggleDaySelection: true,
                          controller: dateRangePickerController,
                          todayHighlightColor: const Color(0xffdb1e39),
                          selectionColor: const Color(0xffdb1e39),
                          backgroundColor: Colors.white,
                          headerStyle: DateRangePickerHeaderStyle(
                            textAlign: TextAlign.center,
                            textStyle: AppTextStyle.bold20
                                .copyWith(color: const Color(0xffdb1e39)),
                          ),
                          monthViewSettings:
                              const DateRangePickerMonthViewSettings(
                            dayFormat: 'EEE',
                            firstDayOfWeek: 1,
                          ),
                          onSelectionChanged: (dateRange) async {
                            _updateDatePicker(
                              null,
                              preEmpty: false,
                            );

                            await diAnalytics.log(
                                LogEvents.tap_select_date_picker, null);
                          },
                        ),
                        Gap(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                              onPressed: () async {
                                _updateDatePicker(
                                  selectedTempDate,
                                  preEmpty:
                                      selectedTempDate.toString() == "null"
                                          ? true
                                          : false,
                                );
                                Navigator.pop(context);
                                await diAnalytics.log(
                                    LogEvents.tap_cancel_date_picker, null);
                              },
                              child: Text(
                                "Huỷ",
                                style: AppTextStyle.bold16.copyWith(
                                  color: const Color(0xffdb1e39),
                                ),
                              ),
                            ),
                            Gap(10.w),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffdb1e39),
                                minimumSize: Size(0.40.sw, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              onPressed: () async {
                                AppLogger.instance.i(dateRangePickerController
                                    .selectedDate
                                    .toString());
                                widget.controller.text =
                                    dateRangePickerController.selectedDate
                                        .toString();
                                _updateDatePicker(
                                  null,
                                  preEmpty: false,
                                );
                                Navigator.pop(context);
                                await diAnalytics.log(
                                    LogEvents.tap_ok_date_picker, null);
                              },
                              child: Text("OK",
                                  style: AppTextStyle.bold16.copyWith(
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _updateDatePicker(DateTime? selectedTempDate, {required bool preEmpty}) {
    final bloc = context.read<DatePickerBloc>();
    if (preEmpty) {
      //onCancel with previous of value is null
      bloc.validate(null);
      dateRangePickerController.selectedDate = null;
      widget.controller.text = "";
      setState(() => widget.isError = true);
    } else if (selectedTempDate == null) {
      // onChange
      final selectedDate = dateRangePickerController.selectedDate;
      bloc.validate(selectedDate);
      widget.controller.text = selectedDate.toString();
      setState(() => widget.isError = selectedDate == null);
    } else {
      // onCancel
      bloc.validate(preEmpty ? null : selectedTempDate);
      dateRangePickerController.selectedDate = selectedTempDate;
      widget.controller.text = selectedTempDate.toString();
      setState(() => widget.isError = true);
    }
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
      dateRangePickerController.selectedDate = parsedDateTime;
      return dateRangePickerController;
    }
    return dateRangePickerController;
  }

  @override
  bool get wantKeepAlive => true;
}
