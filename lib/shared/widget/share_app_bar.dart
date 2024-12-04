import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_path.dart';
import '../../core/styles/app_icons.dart';
import '../../core/styles/app_text_style.dart';
import '../../presentation/form_screen/component/screen/text_button.dart';

// ignore: must_be_immutable
class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  SharedAppBar(
      {super.key, this.title, this.isForm = false, this.isReviewForm = false});
  final String? title;
  bool isForm;
  bool isReviewForm;
  @override
  Widget build(BuildContext context) {
    final currentRouter = GoRouterState.of(context).name ?? "";
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: _buildTitle(context, currentRouter),
    );
  }

  Widget _buildTitle(BuildContext context, String? currentPage) {
    return SizedBox(
      height: 0.3.sh,
      width: double.infinity,
      child: Stack(
        children: [
          currentPage != Routers.homePage
              ? _buttonBack(context, currentPage)
              : Positioned(
                  right: 0,
                  top: 0.25.sw,
                  child: currentPage == Routers.homePage
                      ? GestureDetector(
                          onTap: () {
                            context.go(Routers.historyPage);
                          },
                          child: const Text(
                            "Đã điền",
                            style: TextStyle(
                              color: Color(0xffe03a52),
                              fontSize: 14,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: title != null
                  ? SizedBox(
                      width: 0.55.sw,
                      child: Text(
                        title ?? "",
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : Center(
                      widthFactor: 100.w,
                      child: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Image.asset(
                          AppIcons.logo2,
                          height: 100.w,
                          width: 100.w,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonBack(BuildContext context, String? currentPage) {
    return Positioned(
      left: 0,
      top: 0.23.sw,
      child: GestureDetector(
        onTap: () async {
          if (title != null && isForm) {
            !isReviewForm ? await showDiaLog(context) : context.pop(context);
          } else if (currentPage == Routers.historyPage) {
            context.go(Routers.homePage);
          } else {
            context.pop(context);
          }
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_back_ios_new, size: 20.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
}
