import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:dsoft_form_application/core/styles/app_images.dart';
import 'package:dsoft_form_application/presentation/home_screen/bloc/home_page_bloc.dart';
import 'package:dsoft_form_application/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../core/routing/route_path.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const SharedAppBar(),
      backgroundColor: const Color(0xFFF7F7F7),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        bloc: context.read<HomePageBloc>()..add(GetPost()),
        builder: (context, state) {
          if (state is HomePageInitial) {
            return Center(
              child: Container(
                color: Colors.white,
                height: 50.w,
                width: 50.w,
                child: LoadingIndicator(
                  indicatorType: Indicator.circleStrokeSpin,
                  colors: const [Colors.red],
                  strokeWidth: 4.0,
                  pathBackgroundColor: Colors.red[200],
                  backgroundColor: Colors.white,
                ),
              ),
            );
          }
          if (state is HomePageLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              itemBuilder: (context, index) {
                final post = state.posts[index].metaData;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push(
                            '${Routers.homePage}/${Routers.detailPage}/$index');
                      },
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          width: size.width * 0.95,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color(0xFFededed),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(
                                  AppImages.banner,
                                  fit: BoxFit.fill,
                                  color: Colors.black45,
                                  colorBlendMode: BlendMode.darken,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 10, 8, 10),
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.title,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Image.asset(AppIcons.folder),
                                        const SizedBox(width: 10),
                                        const Text(
                                          "Mở từ 12:00 12/09/2024",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.grey,
                                          ),
                                        ),
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
              },
            );
          }
          if (state is HomePageLoadFailed) {
            return const Center(
              child: Text("Load API Failed"),
            );
          }
          return Center(
            child: Container(
              color: Colors.white,
              height: 50.w,
              width: 50.w,
              child: LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                colors: const [Colors.red],
                strokeWidth: 4.0,
                pathBackgroundColor: Colors.red[200],
                backgroundColor: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
