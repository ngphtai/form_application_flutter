import 'package:flutter/material.dart';

import '../../../../core/styles/app_text_style.dart';

class TextButtonCustom extends StatelessWidget {
  const TextButtonCustom({
    super.key,
    required this.text,
    required this.color,
  });
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyle.bold14.copyWith(color: color));
  }
}
