import 'package:dsoft_form_application/common/constant/constants.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/core/styles/app_text_style.dart';
import '/presentation/form_screen/component/bloc/text_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class TextFieldCustomWithBloc extends StatefulWidget {
  TextFieldCustomWithBloc({
    super.key,
    required this.maxLine,
    required this.isRequest,
    required this.textController,
    required this.textFieldBloc,
  });

  final int maxLine;
  final bool isRequest;
  bool isError = false;
  final TextEditingController textController;
  final TextFieldBloc textFieldBloc;

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldCustomWithBlocState createState() =>
      _TextFieldCustomWithBlocState();
}

class _TextFieldCustomWithBlocState extends State<TextFieldCustomWithBloc> {
  @override
  void initState() {
    super.initState();

    // Thêm listener cho textController để cập nhật Bloc mỗi khi nội dung thay đổi
    widget.textController.addListener(() {
      widget.textFieldBloc.validate(widget.textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldBloc, TextFieldState>(
      bloc: widget.textFieldBloc,
      builder: (context, state) {
        if (state is TextFieldValidate) {
          widget.isError = !state.isValid;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              decoration: BoxDecoration(
                color: const Color(0xfff4f4f4),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.fromBorderSide(
                  BorderSide(
                      color: widget.isRequest == true
                          ? !widget.isError
                              ? const Color(0xffe8e8e8)
                              : const Color(0xffdb1e39)
                          : const Color(0xffe8e8e8),
                      width: 1),
                ),
              ),
              child: TextField(
                onTap: () async =>
                    await diAnalytics.log(LogEvents.tap_text_field, null),
                controller: widget.textController,
                decoration: InputDecoration(
                  hintText: "Nhập câu trả lời",
                  hintStyle:
                      AppTextStyle.regular14.copyWith(color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 10),
                ),
                maxLines: widget.maxLine,
              ),
            ),
            widget.isRequest
                ? widget.isError
                    ? Text(
                        "Câu hỏi này bắt buộc *",
                        style: AppTextStyle.regular14
                            .copyWith(color: const Color(0xffdb1e39)),
                      )
                    : const SizedBox()
                : const SizedBox(),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    widget.textController.removeListener(() {});
    super.dispose();
  }
}
