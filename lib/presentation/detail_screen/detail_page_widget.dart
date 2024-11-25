import 'package:dsoft_form_application/core/routing/route_path.dart';
import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:dsoft_form_application/core/styles/app_text_style.dart';
import 'package:dsoft_form_application/presentation/detail_screen/bloc/detail_page_bloc.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../form_screen/component/screen/loading_widget.dart';
import '../form_screen/component/screen/text_button.dart';

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
    return Scaffold(
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
                                const Text(
                                  "Giới thiệu",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.post.metaData.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Html(data: state.post.metaData.description),
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
                                onTap: () {
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
                                      child: currentRouter ==
                                              Routers.reviewDetailPage
                                          ? const TextButtonCustom(
                                              text: "Xem lại",
                                              color: Colors.white)
                                          : const TextButtonCustom(
                                              text: "Điền form ngay",
                                              color: Colors.white)),
                                ),
                              ),
                              Gap(10.h),
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
            return const Center(
              child: Text("Có lỗi xảy ra"),
            );
          }
        },
      ),
    );
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
}
