import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:dsoft_form_application/core/styles/app_images.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: size.width * 0.95,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(16, 16)),
          color: Color(0xFFededed),
        ),
        child: Column(
          children: [
            Image.asset(
              AppImages.banner,
              fit: BoxFit.cover,
              color: Colors.black45,
              colorBlendMode: BlendMode.darken,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Đăng kí tham gia giải bóng đá D-Soft",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Image.asset(AppIcons.folder),
                      const SizedBox(width: 10),
                      const Text(
                        "Mở từ 12:00 12/09/2024",
                        style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
