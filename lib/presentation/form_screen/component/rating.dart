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
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => widget.ratingBloc,
      child: BlocBuilder<RatingBloc, RatingState>(
        builder: (context, state) {
          if (widget.controller.text.isNotEmpty &&
              widget.controller.text != "" &&
              widget.controller.text != "null") {
            int? value = int.parse(widget.controller.text);
            widget.star = value;
            context.read<RatingBloc>().validate(value);
          }

          if (state is RatingInitial) {
            widget.isError = false;
          } else {
            bool isNoEmpty = context.read<RatingBloc>().selected != null;
            isNoEmpty ? widget.isError = false : widget.isError = true;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: Border.fromBorderSide(BorderSide(
                    color: widget.isRequest == true
                        ? (!widget.isError
                            ? Colors.white
                            : const Color(0xffdb1e39))
                        : Colors.white,
                    width: 1,
                  )),
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
                                onPressed: () {
                                  if (index + 1 == widget.star) {
                                    setState(() {
                                      widget.star = 0;
                                    });
                                    context
                                        .read<RatingBloc>()
                                        .validate(widget.star);
                                  } else {
                                    setState(() {
                                      widget.star = index + 1;
                                    });
                                    context
                                        .read<RatingBloc>()
                                        .validate(widget.star);
                                  }
                                },
                              ),
                            ],
                          )).toList(),
                ),
              ),
              widget.isRequest == true
                  ? widget.isError
                      ? const Text(
                          "Câu hỏi này bắt buộc *",
                          style: TextStyle(color: Color(0xffdb1e39)),
                        )
                      : const SizedBox()
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }

  Image showStar(int index) {
    return index < widget.star
        ? Image.asset(AppIcons.star)
        : Image.asset(AppIcons.emptyStar);
  }

  @override
  bool get wantKeepAlive => true;
}
