import 'dart:io';
import 'package:dsoft_form_application/core/styles/app_text_style.dart';
import 'package:dsoft_form_application/shared/widget/no_data_from_local.dart';
import '../../common/constant/constants.dart';
import '../../core/locators/locators.dart';
import '../../shared/widget/share_app_bar.dart';
import '/core/styles/app_icons.dart';
import '/presentation/form_screen/component/screen/loading_widget.dart';
import '/presentation/home_screen/bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/routing/route_path.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: Platform.isAndroid ? true : false,
      child: Scaffold(
        appBar: const SharedAppBar(),
        backgroundColor: const Color(0xFFF7F7F7),
        body: BlocBuilder<HomePageBloc, HomePageState>(
          bloc: context.read<HomePageBloc>()..add(GetPost()),
          builder: (context, state) {
            if (state is HomePageInitial) {
              return const LoadingWidget();
            }
            if (state is HomePageLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  if (post.enable) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            context.push(
                                '${Routers.homePage}/${Routers.detailPage}/${post.id}');

                            await diAnalytics.log(
                                LogEvents.tap_form_button, null);
                          },
                          child: Center(
                            child: Container(
                              width: 0.95.sw,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 10, 8, 10),
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(AppIcons.folder),
                                            const Gap(10),
                                            Expanded(
                                              child: Text(post.title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyle.bold14),
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                        Text(
                                          post.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle.regular12
                                              .copyWith(
                                                  color:
                                                      const Color(0xff6f6f6f)),
                                        ),
                                        const Gap(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Hết hạn: ${DateFormat('dd/MM/yyyy').format(post.expireAt)}",
                                                style: AppTextStyle.regular12
                                                    .copyWith(
                                                        color: const Color(
                                                            0xff6f6f6f))),
                                            DateTime.now().isAfter(
                                                        post.expireAt) ==
                                                    true
                                                ? Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xffffccd4),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  100)),
                                                    ),
                                                    child: Text("Đã hết hạn",
                                                        style: AppTextStyle
                                                            .bold12
                                                            .copyWith(
                                                                color: const Color(
                                                                    0xffdb1e39))))
                                                : const Text("")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                      ],
                    );
                  }
                  return null;
                },
              );
            }
            if (state is HomePageLoadFailed) {
              return const noDataFromLocal();
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
