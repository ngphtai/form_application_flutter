import '/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'bloc/custom_drop_button_bloc.dart';

class CustomDropButton extends StatefulWidget {
  const CustomDropButton({
    super.key,
    required this.listDropDown,
    this.isRequest = false,
    required this.customDropButtonBloc,
    required this.controller,
    required this.title,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropButtonState createState() => _CustomDropButtonState();
  final List<String> listDropDown;
  final bool? isRequest;
  final TextEditingController controller;
  final CustomDropButtonBloc customDropButtonBloc;
  final String title;
}

class _CustomDropButtonState extends State<CustomDropButton>
    with AutomaticKeepAliveClientMixin {
  String? selectedValue;
  bool isDropdownVisible = false;
  bool isClose = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
        create: (context) => widget.customDropButtonBloc,
        child: BlocBuilder<CustomDropButtonBloc, CustomDropButtonState>(
            builder: (context, state) {
          // handle get answer and set answer to default
          if (widget.controller.text.isNotEmpty && !isClose) {
            String value = widget.controller.text;
            context.read<CustomDropButtonBloc>().validate(value);
            selectedValue = value;
            isClose = true;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _showDropDownBottomSheet(context);
                  context.read<CustomDropButtonBloc>().validate("");
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: widget.isRequest == true
                                ? !state.isError
                                    ? const Color(0xffe8e8e8)
                                    : const Color(0xffdb1e39)
                                : const Color(0xffe8e8e8),
                            width: 1),
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedValue ?? 'Nhập câu trả lời',
                            style: TextStyle(
                                color: selectedValue == null
                                    ? const Color(0xff8C8C8C)
                                    : Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    state.isError
                        ? const Text(
                            "Câu hỏi này bắt buộc *",
                            style: TextStyle(color: Color(0xffdb1e39)),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        }));
  }

  void _showDropDownBottomSheet(BuildContext context) {
    final originContext = context;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      )),
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setBottomSheetState) {
          return Container(
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
                // cross bar
                Container(
                  width: 100.h,
                  height: 5,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                ),
                // title
                Text(
                  widget.title,
                  style: AppTextStyle.regular16.copyWith(color: Colors.grey),
                ),
                Gap(10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.listDropDown.map((item) {
                    final bool isSelected = item == selectedValue;
                    return GestureDetector(
                      onTap: () {
                        // Cập nhật UI cho BottomSheet
                        setBottomSheetState(() {
                          selectedValue = item;
                        });
                        // update ui widget
                        setState(() {
                          selectedValue = item;
                        });
                        originContext
                            .read<CustomDropButtonBloc>()
                            .validate(selectedValue!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFDEEEE)
                              : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xffdb1e39)
                                : const Color(0xffe8e8e8),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item,
                              style: TextStyle(
                                fontSize: 14,
                                color: isSelected
                                    ? const Color(0xffdb1e39)
                                    : Colors.black,
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xffdb1e39),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
