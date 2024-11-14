import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/presentation/history_screen/bloc/history_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../core/routing/route_path.dart';
import '../../core/styles/app_icons.dart';
import '../../core/styles/app_images.dart';

class HistoryPageWidget extends StatelessWidget {
  const HistoryPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<HistoryPageBloc, HistoryPageState>(
      bloc: HistoryPageBloc()..add(LoadPostFromLocal()),
      builder: (context, state) {
        AppLogger.instance.d(state.toString());
        if (state is HistoryPageInitial) {
          return Center(
            child: SizedBox(
              height: 50.w,
              width: 50.w,
              child: LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                colors: const [Colors.red],
                strokeWidth: 4.0,
                pathBackgroundColor: Colors.red[200],
                backgroundColor: const Color(0xfff7f7f7),
              ),
            ),
          );
        } else if (state is HistoryPageLoaded) {
          if (state.posts?.isEmpty == true) {
            return const Center(
              child: Text('No data'),
            );
          }
          return RefreshIndicator(
            color: Colors.red,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              context.read<HistoryPageBloc>().add(LoadPostFromLocal());
            },
            child: ListView.builder(
              itemCount: state.posts?.length,
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              itemBuilder: (context, index) {
                final post = state.posts?[index].metaData;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push(
                            '${Routers.historyPage}/${Routers.detailPage}/$index');
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
                                      post?.title ?? "",
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
            ),
          );
        }
        return Container();
      },
    );
  }
}
