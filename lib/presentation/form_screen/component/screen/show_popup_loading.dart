import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/styles/app_text_style.dart';

Future<dynamic> showDiaLogLoading(BuildContext originContext) {
  return showDialog(
      context: originContext,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
              width: 1.sw,
              height: 0.3.sh,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vui lòng đợi trong giây lát",
                      style: AppTextStyle.bold20
                          .copyWith(color: const Color(0xffdb1e39)),
                    ),
                    Gap(20.w),
                    Container(
                      color: Colors.white,
                      height: 100.w,
                      width: 100.w,
                      child: LoadingIndicator(
                          indicatorType: Indicator.circleStrokeSpin,
                          colors: const [Color(0xffdb1e39)],
                          strokeWidth: 4.0,
                          pathBackgroundColor: Colors.red[200],
                          backgroundColor: Colors.white),
                    ),
                  ]),
            ),
          ));
}
