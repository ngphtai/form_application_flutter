import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:dsoft_form_application/core/styles/app_text_style.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/screen/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Future<dynamic> showDiaLogInterruptedInternet(BuildContext originContext) {
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
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                    ),
                    const Gap(10),
                    Text(
                      "Không có kết nối Internet",
                      style: AppTextStyle.bold20,
                    ),
                    const Gap(10),
                    Text(
                      "Vui lòng kiểm tra lại đường truyền",
                      style:
                          AppTextStyle.regular14.copyWith(color: Colors.grey),
                    ),
                    const Gap(20),
                    Center(
                      child: SizedBox(
                        width: 0.8.sw,
                        child: GestureDetector(
                          onTap: () {
                            //exit to app
                            SystemNavigator.pop();
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
                                    text: "OK", color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ));
}
