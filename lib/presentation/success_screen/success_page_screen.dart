import 'package:dsoft_form_application/core/routing/app_router.dart';
import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:dsoft_form_application/domain/models/meta_data_model.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_path.dart';

class SuccessPageScreen extends StatelessWidget {
  const SuccessPageScreen({
    super.key,
    required this.title,
    required this.title2,
    required this.content,
  });
  final String title;
  final String title2;
  final String content;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        context.go(Routers.homePage);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: SharedAppBar(title: title),
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      title2,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      content,
                      style: TextStyle(color: Color(0xFF858585), fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
