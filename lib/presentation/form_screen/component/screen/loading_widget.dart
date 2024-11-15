import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        height: 50.w,
        width: 50.w,
        child: LoadingIndicator(
          indicatorType: Indicator.circleStrokeSpin,
          colors: const [Colors.red],
          strokeWidth: 4.0,
          pathBackgroundColor: Colors.red[200],
          backgroundColor: Color(0xfff4f4f4),
        ),
      ),
    );
  }
}
