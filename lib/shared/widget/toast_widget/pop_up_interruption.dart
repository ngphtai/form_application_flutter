import 'package:go_router/go_router.dart';

import '/core/styles/app_icons.dart';
import '/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Future<dynamic> showDiaLogInterruptedInternet(BuildContext originContext) {
  return showDialog(
    context: originContext,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 0.9.sw,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(10),
            Image.asset(
              AppIcons.warning,
              height: 80.w,
              width: 80.w,
              fit: BoxFit.fill,
            ),
            const Gap(10),
            Text(
              "Không có kết nối Internet",
              style: AppTextStyle.bold20,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            Text(
              "Vui lòng kiểm tra lại đường truyền",
              style: AppTextStyle.regular14.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            Center(
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 55.w),
                  decoration: BoxDecoration(
                    color: const Color(0xffdb1e39),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: const Color(0xffdb1e39),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "OK",
                      style: AppTextStyle.bold14.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
