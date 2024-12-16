import 'dart:io';

import '/core/styles/app_icons.dart';
import '/shared/widget/share_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_path.dart';

class FailPageScreen extends StatefulWidget {
  const FailPageScreen({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  State<FailPageScreen> createState() => _FailPageScreenState();
}

class _FailPageScreenState extends State<FailPageScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      // ignore: deprecated_member_use
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          return;
        }
        handlePop(context);
      },
      child: SafeArea(
        top: false,
        bottom: Platform.isAndroid ? true : false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: SharedAppBar(title: widget.title),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.2.sh,
                ),
                Image.asset(
                  AppIcons.fail,
                  height: 90.w,
                  width: 90.w,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Form chưa được hoàn thành!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "Cảm ơn bạn đã dành thời gian điền form khảo sát.",
                        style:
                            TextStyle(color: Color(0xFF858585), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool handlePop(BuildContext context) {
    if (GoRouterState.of(context).name == Routers.failPage) {
      context.go(Routers.homePage);
    } else {
      context.go(Routers.historyPage);
    }
    return true;
  }
}
