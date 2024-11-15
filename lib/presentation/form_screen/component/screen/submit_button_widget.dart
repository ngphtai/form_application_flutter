import 'package:dsoft_form_application/presentation/form_screen/component/screen/text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_path.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      width: size.width * 0.45,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: Colors.red,
          width: 1,
        ),
      ),
      child: Center(
        child: GoRouterState.of(context).name == Routers.reviewFormPage
            ? const TextButtonCustom(text: "Gửi lại", color: Colors.white)
            : const TextButtonCustom(text: "Gửi", color: Colors.white),
      ),
    );
  }
}
