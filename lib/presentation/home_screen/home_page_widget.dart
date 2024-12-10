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
      child: Scaffold(
        appBar: SharedAppBar(),
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
                          onTap: () {
                            context.push(
                                '${Routers.homePage}/${Routers.detailPage}/${post.id}');
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
                                              child: Text(
                                                post.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                        Text(
                                          post.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const Gap(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Hết hạn: ${DateFormat('dd/MM/yyyy').format(post.expireAt)}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.normal,
                                                color: Color(0xff6f6f6f),
                                              ),
                                            ),
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
                                                    child: const Text(
                                                      "Đã hết hạn",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffdb1e39)),
                                                    ))
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
              return const Text("error");
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
