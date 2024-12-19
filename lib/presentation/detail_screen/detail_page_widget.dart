import 'dart:io';
import 'package:dsoft_form_application/core/styles/app_text_style.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../../shared/widget/share_app_bar.dart';
import '/core/routing/route_path.dart';
import '/presentation/detail_screen/bloc/detail_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../form_screen/component/screen/loading_widget.dart';
import 'widget/show_dialog.dart';

class DetailPageWidget extends StatefulWidget {
  const DetailPageWidget({
    super.key,
    required this.postId,
  });
  final String postId;

  @override
  State<DetailPageWidget> createState() => _DetailPageWidgetState();
}

class _DetailPageWidgetState extends State<DetailPageWidget> {
  @override
  Widget build(BuildContext context) {
    final currentRouter = GoRouterState.of(context).name;
    return SafeArea(
      top: false,
      bottom: Platform.isAndroid ? true : false,
      child: Scaffold(
        appBar: SharedAppBar(
          title: context.select<DetailPageBloc, String>((bloc) {
            final state = bloc.state;
            return state is DetailPageLoaded
                ? state.post.metaData.title
                : ". . .";
          }),
        ),
        backgroundColor: const Color(0xFFf7f7f7),
        body: BlocBuilder<DetailPageBloc, DetailPageState>(
          builder: (context, state) {
            if (state is DetailPageInitial) {
              final bloc = context.read<DetailPageBloc>();
              if (currentRouter == Routers.detailPage) {
                bloc.add(LoadDetailPost(widget.postId));
              } else if (currentRouter == Routers.reviewDetailPage) {
                bloc.add(LoadDetailPostLocal(widget.postId));
              }
              return const LoadingWidget();
            } else if (state is DetailPageLoading) {
              return const LoadingWidget();
            } else if (state is DetailPageLoaded) {
              return SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: 0.95.sw,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Giới thiệu",
                                    style: AppTextStyle.bold16,
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    state.post.metaData.title,
                                    style: AppTextStyle.bold14,
                                  ),
                                  Gap(10.h),
                                  Text(state.post.metaData.description,
                                      style: AppTextStyle.regular14),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),

                    //button
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: const Color(0xFFffffff),
                            child: Column(
                              children: [
                                // ReturnButtonWidget(size: size), // button return
                                GestureDetector(
                                  onTap: () async {
                                    if (state.post.metaData.expireAt
                                            .isBefore(DateTime.now()) &&
                                        currentRouter !=
                                            Routers.reviewDetailPage) {
                                      showDiaLog(context);
                                    } else {
                                      context.go(currentRouter ==
                                              Routers.reviewDetailPage
                                          ? '/historyPage/reviewDetailPage/${widget.postId}/formPage'
                                          : '/homePage/detailPage/${widget.postId}/formPage');
                                      await FirebaseAnalytics.instance.logEvent(
                                        name: currentRouter ==
                                                Routers.reviewDetailPage
                                            ? 'tap_fill_from_button'
                                            : 'tap_review_form_button',
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    width: 0.9.sw,
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
                                            currentRouter ==
                                                    Routers.reviewDetailPage
                                                ? "Xem lại"
                                                : "Điền form ngay",
                                            style: AppTextStyle.bold14.copyWith(
                                                color: Colors.white))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Có lỗi xảy ra",
                  style: AppTextStyle.bold14,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
