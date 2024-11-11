import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/bloc/date_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class DatePicker extends StatefulWidget {
  DatePicker({
    Key? key,
    this.isRequest = false,
    required this.isError,
    required this.datePickerBloc,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
  final bool? isRequest;
  final DatePickerBloc datePickerBloc;
  DateTime? datePicker;

  bool isError;
}

class _DatePickerState extends State<DatePicker>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<DatePickerBloc, DatePickerState>(
        builder: (context, state) {
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
              await _selectDate(context);

              context.read<DatePickerBloc>().validate(widget.datePicker);
              print("ontap ${widget.datePicker}");
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
                              ? Colors.red
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
                      child: widget.datePicker != null
                          ? Text(
                              "${widget.datePicker!.day}/${widget.datePicker!.month}/${widget.datePicker!.year}")
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: widget.datePicker ?? DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.red,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
            dialogBackgroundColor: Colors.white,
            datePickerTheme: DatePickerThemeData(
              dayStyle: const TextStyle(color: Colors.black),
              todayForegroundColor:
                  MaterialStateProperty.all(Color(0xffe8e8e8e8)),
              headerForegroundColor: Colors.red,
              yearStyle: TextStyle(color: Colors.black),
            ),
          ),
          child: child!,
        );
      },
    );

    if (widget.datePicker != selected) {
      setState(() {
        widget.datePicker = selected;
        context.read<DatePickerBloc>().validate(widget.datePicker);
      });
    }
    print("change date if not same old date $selected");
  }

  @override
  bool get wantKeepAlive => true;
}
