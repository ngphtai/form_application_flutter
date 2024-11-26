import 'package:dsoft_form_application/core/styles/app_text_style.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/screen/text_button.dart';
import 'package:flutter/material.dart';
import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_path.dart';

// ignore: must_be_immutable
class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  bool isForm;
  bool isReviewForm;
  SharedAppBar({
    super.key,
    this.title,
    this.isForm = false,
    this.isReviewForm = false,
  });

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false, // hide default back button
          leading: GestureDetector(
            onTap: () async {
              if (isForm) {
                !isReviewForm
                    ? await showDiaLog(context)
                    : context.pop(context);
              } else {
                context.pop(context);
              }
            },
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      size: 20.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: 0.102.sw,
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.white,
              height: 1.0,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: 0.55.sw,
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          title.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ));
    } else {
      //App bar for home Page
      return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.white,
            height: 1.0,
          ),
        ),
        leading: GoRouterState.of(context).name == Routers.historyPage
            ? GestureDetector(
                onTap: () {
                  if (GoRouterState.of(context).name == Routers.successPage) {
                    context.go(Routers.homePage);
                  } else if (GoRouterState.of(context).name ==
                      Routers.reviewSuccessPage) {
                    context.go(Routers.historyPage);
                  } else {
                    context.go(Routers.homePage);
                  }
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          size: 20.h,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GoRouterState.of(context).name == Routers.historyPage
                ? Gap(0.48.w)
                : Gap(0.11.sw),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                AppIcons.logo2,
                height: 100.w,
                width: 100.w,
              ),
            ),
            GoRouterState.of(context).name == Routers.historyPage
                ? Gap(20.w)
                : GestureDetector(
                    onTap: () {
                      context.go(Routers.historyPage);
                    },
                    child: const Text(
                      "Đã điền",
                      style: TextStyle(color: Color(0xffe03a52), fontSize: 14),
                    )),
          ],
        ),
      );
    }
  }

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
                        height: 60,
                        width: 60,
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
                              originContext.pop();
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(55, 10, 55, 10),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFffffff),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
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
                              Navigator.of(context).pop();
                              GoRouter.of(originContext).go(Routers.homePage);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(55, 10, 55, 10),
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

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 1); // AppBar height + bottom divider
}
