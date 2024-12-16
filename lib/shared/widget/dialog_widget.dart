import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../core/styles/app_text_style.dart';
import '../../presentation/form_screen/component/screen/text_button.dart';

showDiaLogToExist(BuildContext originContext) {
  return showDialog<bool>(
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
                      style: AppTextStyle.bold20,
                    ),
                    const Gap(10),
                    Text(
                      "Mọi thay đổi sẽ không được lưu.",
                      style:
                          AppTextStyle.regular14.copyWith(color: Colors.grey),
                    ),
                    Text(
                      "Bạn có chắc muốn thoát không?",
                      style:
                          AppTextStyle.regular14.copyWith(color: Colors.grey),
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Container(
                            width: 0.3.sw,
                            height: 40.h,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFffffff),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              border: Border.all(
                                color: const Color(0xffdb1e39),
                                width: 1,
                              ),
                            ),
                            child: const Center(
                                child: TextButtonCustom(
                                    text: "Huỷ", color: Color(0xffdb1e39))),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            width: 0.3.sw,
                            height: 40.h,
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
                                    text: "Thoát", color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ));
}
