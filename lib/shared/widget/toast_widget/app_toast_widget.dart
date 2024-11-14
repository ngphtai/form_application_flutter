import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/app_text_style.dart';

/// {@template app_toast_widget}
/// [AppToastWidget] returns a state less widget
///
/// [AppToastWidget] to show loading dialog in app (above all of screen)
/// {@endtemplate}
class AppToastWidget extends StatefulWidget {
  /// {@macro app_toast_widget}
  const AppToastWidget({
    super.key,
    required this.message,
    this.isPaddingBottom = true,
  });

  /// Message be showed in toast
  final String message;

  /// Is padding bottom
  final bool isPaddingBottom;

  @override
  State<AppToastWidget> createState() => _AppToastWidget();
}

class _AppToastWidget extends State<AppToastWidget> {
  @override
  Widget build(BuildContext context) {
    var marginToast = 12.h;
    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 1.sw,
        margin: EdgeInsets.only(
          left: marginToast,
          right: marginToast,
          bottom: ((widget.isPaddingBottom)
                  ? (kBottomNavigationBarHeight + 3.h)
                  : 0) +
              marginToast,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.w),
        child: Text(
          widget.message,
          style: AppTextStyle.regular13.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
