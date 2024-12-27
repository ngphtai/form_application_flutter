import 'package:dsoft_form_application/common/constant/constants.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import '/core/styles/app_icons.dart';
import '/core/styles/app_text_style.dart';
import '/presentation/form_screen/component/bloc/rating_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class Rating extends StatefulWidget {
  Rating({
    super.key,
    this.isRequest = false,
    this.isError = false,
    this.star = 0,
    required this.ratingBloc,
    required this.controller,
  });

  @override
  State<Rating> createState() => _RatingState();

  final bool? isRequest;
  bool isError;
  int star;
  final RatingBloc ratingBloc;
  final TextEditingController controller;
}

class _RatingState extends State<Rating> with AutomaticKeepAliveClientMixin {
  late int star = 0;
  late bool isError;

  @override
  void initState() {
    super.initState();
    star = widget.star;
    isError = widget.isError;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint("Rating widget is rebuilding");
    return BlocBuilder<RatingBloc, RatingState>(
      bloc: widget.ratingBloc,
      builder: (context, state) {
        // Update local state based on controller
        if (widget.controller.text.isNotEmpty &&
            widget.controller.text != "" &&
            widget.controller.text != "null") {
          final value = int.tryParse(widget.controller.text) ?? 0;
          if (value != star) {
            star = value;
            context.read<RatingBloc>().validate(value);
          }
        }

        // Handle error state
        if (state is RatingInitial) {
          isError = false;
        } else if (state is RatingValidate) {
          isError = state.isValid ? false : true;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: widget.isRequest == true
                        ? (!isError ? Colors.white : const Color(0xffdb1e39))
                        : Colors.white,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(10.h),
                      Text((index + 1).toString(),
                          style: AppTextStyle.regular14),
                      IconButton(
                        icon: showStar(index),
                        color: Colors.amber,
                        iconSize: 16.0,
                        onPressed: () async {
                          final newStar = (index + 1 == star) ? 0 : index + 1;
                          if (newStar != star) {
                            setState(() {
                              star = newStar;
                            });
                            context.read<RatingBloc>().validate(newStar);

                            await diAnalytics.log(LogEvents.tap_rating, null);
                          }
                        },
                      ),
                    ],
                  ),
                ).toList(),
              ),
            ),
            widget.isRequest == true
                ? isError
                    ? Text(
                        "Câu hỏi này bắt buộc *",
                        style: AppTextStyle.regular14.copyWith(
                          color: const Color(0xffdb1e39),
                        ),
                      )
                    : const SizedBox()
                : const SizedBox(),
          ],
        );
      },
    );
  }

  Image showStar(int index) {
    return index < star
        ? Image.asset(AppIcons.star)
        : Image.asset(AppIcons.emptyStar);
  }

  @override
  bool get wantKeepAlive => true;
}
