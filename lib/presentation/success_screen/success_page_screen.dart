import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';

class SuccessPageScreen extends StatelessWidget {
  const SuccessPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SharedAppBar(title: "Đăng ký tham gia giải bóng đá D-Soft"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Stack(
              children: [
                Image.asset(AppIcons.tassel),
                Positioned(
                    left: size.width * 0.01,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Image.asset(AppIcons.success))
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Bạn đã hoàn thành!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Cảm ơn bạn đã dành thời gian điền form khảo sát.",
                    style: TextStyle(color: Color(0xFF858585), fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
