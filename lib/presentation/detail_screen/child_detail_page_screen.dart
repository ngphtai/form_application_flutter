import 'package:dsoft_form_application/core/routing/route_path.dart';
import 'package:dsoft_form_application/core/styles/app_images.dart';
import 'package:dsoft_form_application/presentation/detail_screen/bloc/detail_page_bloc.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../form_screen/component/screen/loading_widget.dart';
import '../form_screen/component/screen/return_button_widget.dart';
import '../form_screen/component/screen/text_button.dart';

class ChildDetailPageScreen extends StatefulWidget {
  const ChildDetailPageScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final String postId;

  @override
  State<ChildDetailPageScreen> createState() => _ChildDetailPageScreenState();
}

class _ChildDetailPageScreenState extends State<ChildDetailPageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            int? numericId;
            if (int.tryParse(widget.postId) != null) {
              numericId = int.parse(widget.postId);
            }
            // Pass numericId or postId as appropriate
            if (numericId != null) {
              context
                  .read<DetailPageBloc>()
                  .add(LoadDetailPost(int.parse(widget.postId)));
            } else if (GoRouterState.of(context).name ==
                Routers.reviewDetailPage) {
              context
                  .read<DetailPageBloc>()
                  .add(LoadDetailPostLocal(widget.postId));
            }
            return const LoadingWidget();
          } else if (state is DetailPageLoading) {
            return const LoadingWidget();
          } else if (state is DetailPageLoaded) {
            return SizedBox(
              height: 1000.h,
              width: 1000.w,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Image.asset(AppImages.banner),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: size.width * 0.95,
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
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color(0xFFffffff),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ReturnButtonWidget(size: size), // button return
                              GestureDetector(
                                onTap: () {
                                  if (GoRouterState.of(context).name ==
                                      Routers.reviewDetailPage) {
                                    context.go(
                                      '/historyPage/detailPage/${widget.postId}/formPage',
                                    );
                                  } else {
                                    context.go(
                                      '/homePage/detailPage/${widget.postId}/formPage',
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(5),
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                      child: GoRouterState.of(context).name ==
                                              Routers.reviewDetailPage
                                          ? const TextButtonCustom(
                                              text: "Xem lại",
                                              color: Colors.white)
                                          : const TextButtonCustom(
                                              text: "Điền form ngay",
                                              color: Colors.white)),
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
            return const Center(
              child: Text("Có lỗi xảy ra"),
            );
          }
        },
      ),
    );
  }
}
