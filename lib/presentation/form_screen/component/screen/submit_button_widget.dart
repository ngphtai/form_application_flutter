import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'text_button.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      width: 0.9.sw,
      decoration: BoxDecoration(
        color: const Color(0xffdb1e39),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        border: Border.all(
          color: const Color(0xffdb1e39),
          width: 1,
        ),
      ),
      child: const Center(
        child: TextButtonCustom(text: "Gửi", color: Colors.white),
      ),
    );
  }
}
