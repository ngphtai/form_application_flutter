// hiển thị thông báo gửi
import 'package:dsoft_form_application/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';

void showMessenger(BuildContext context, bool checkValidToSubmit) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        checkValidToSubmit
            ? "Đã lưu thành công"
            : "Vui lòng điền đầy đủ thông tin",
        style: AppTextStyle.regular14,
      ),
      backgroundColor:
          checkValidToSubmit ? Colors.green : const Color(0xffdb1e39),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
    ),
  );
}
