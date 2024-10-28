import 'package:dsoft_form_application/core/routing/route_path.dart';
import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:dsoft_form_application/core/styles/app_images.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class DetailPageScreen extends StatelessWidget {
  const DetailPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const SharedAppBar(title: "Đăng kí tham gia giải bóng đá D-Soft"),
      backgroundColor: const Color(0xFFf7f7f7),
      body: Stack(
        children: [
          // Nội dung chi tiết
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(16, 16)),
                    ),
                    child: Image.asset(AppImages.banner),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: size.width * 0.95,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                      color: Colors.white,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Giới thiệu",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tham Gia Ngay Giải Bóng Đá D-soft! ⚽🏆",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        MarkdownBody(data: AppIcons.example)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),

          // Container button ở dưới cùng
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xFFffffff),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go(Routers.homePage);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            color: const Color(0xFFffffff),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Trở về",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/homePage/detailPage/formPage');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Điền form ngay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
