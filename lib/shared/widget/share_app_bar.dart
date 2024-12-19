import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/routing/route_path.dart';
import '../../core/styles/app_icons.dart';
import '../../core/styles/app_text_style.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SharedAppBar({
    super.key,
    this.title,
  });
  final String? title;

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
                  top: 0.3.sw,
                  child: currentPage == Routers.homePage
                      ? GestureDetector(
                          onTap: () async {
                            context.go(Routers.historyPage);
                            await FirebaseAnalytics.instance.logEvent(
                              name: 'tap_filled_button',
                            );
                          },
                          child: Text("Đã điền",
                              style: AppTextStyle.bold14
                                  .copyWith(color: const Color(0xffe03a52))),
                        )
                      : const SizedBox(),
                ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: title != null
                  ? SizedBox(
                      width: 0.55.sw,
                      child: Text(title ?? "",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bold14),
                    )
                  : Center(
                      widthFactor: 100.w,
                      child: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Image.asset(
                          AppIcons.logo,
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
      top: 0.3.sw,
      child: GestureDetector(
        onTap: () async {
          switch (currentPage) {
            case Routers.historyPage:
              context.go(Routers.homePage); // Điều hướng đến trang home
              break;
            default:
              context.pop(context); // Quay lại trang trước
          }
          await FirebaseAnalytics.instance.logEvent(
            name: 'tap_back_icon',
          );
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
}
