import 'package:dsoft_form_application/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShareContainer extends StatelessWidget {
  const ShareContainer({
    super.key,
    required this.widget,
    this.textInputControl,
    required this.title,
    this.isRequest = false,
  });
  final Widget widget;
  final TextInputControl? textInputControl;
  // final GlobalKey globalKey;
  final String title;
  final bool isRequest;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: title,
                  style: AppTextStyle.bold14.copyWith(color: Colors.black),
                ),
                TextSpan(
                    text: isRequest ? " *" : "",
                    style: AppTextStyle.bold14
                        .copyWith(color: const Color(0xffdb1e39))),
              ]))),
          Container(
              margin: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
              ),
              child: widget),
        ],
      ),
    );
  }
}
