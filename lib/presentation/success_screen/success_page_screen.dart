import 'dart:io';

import '../../core/styles/app_text_style.dart';
import '/core/styles/app_icons.dart';
import '/shared/widget/share_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_path.dart';

import 'dart:async';

class SuccessPageScreen extends StatefulWidget {
  const SuccessPageScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<SuccessPageScreen> createState() => _SuccessPageScreenState();
}

class _SuccessPageScreenState extends State<SuccessPageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Define animation curve
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Delay 1 second before starting the animation
    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                Stack(
                  children: [
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Image.asset(AppIcons.tassel),
                    ),
                    Positioned(
                      left: 0.01.sw,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Image.asset(AppIcons.success),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Bạn đã hoàn thành!",
                        style: AppTextStyle.bold16,
                      ),
                      Text("Cảm ơn bạn đã dành thời gian điền form khảo sát.",
                          style: AppTextStyle.regular14
                              .copyWith(color: const Color(0xFF858585))),
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
    if (GoRouterState.of(context).name == Routers.formPage) {
      context.go(Routers.homePage);
    } else {
      context.go(Routers.historyPage);
    }
    return true;
  }
}
