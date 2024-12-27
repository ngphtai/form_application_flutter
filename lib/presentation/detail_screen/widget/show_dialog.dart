import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/styles/app_icons.dart';
import '../../../core/styles/app_text_style.dart';
import '../../form_screen/component/screen/text_button.dart';

Future<dynamic> showDiaLog(BuildContext originContext) {
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
                    const Gap(10),
                    Image.asset(
                      AppIcons.warning,
                      height: 80.w,
                      width: 80.w,
                      fit: BoxFit.fill,
                    ),
                    const Gap(10),
                    Text(
                      "Cảnh báo",
                      style: AppTextStyle.bold20
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const Gap(10),
                    Text(
                      "Form form này đã hết hạn!",
                      style:
                          AppTextStyle.regular14.copyWith(color: Colors.grey),
                    ),
                    const Gap(20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // GoRouter.of(originContext).go(Routers.homePage);
                          context.pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(55, 10, 55, 10),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xffdb1e39),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: const Color(0xffdb1e39),
                              width: 1,
                            ),
                          ),
                          child: const Center(
                              child: TextButtonCustom(
                                  text: "Ok", color: Colors.white)),
                        ),
                      ),
                    ),
                  ]),
            ),
          ));
}
