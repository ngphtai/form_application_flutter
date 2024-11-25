import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'text_button.dart';

class ReturnButtonWidget extends StatelessWidget {
  const ReturnButtonWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        width: size.width * 0.45,
        decoration: BoxDecoration(
          color: const Color(0xFFffffff),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(
            color: const Color(0xffdb1e39),
            width: 1,
          ),
        ),
        child: const Center(
            child: TextButtonCustom(text: "Trở về", color: Color(0xffdb1e39))),
      ),
    );
  }
}
