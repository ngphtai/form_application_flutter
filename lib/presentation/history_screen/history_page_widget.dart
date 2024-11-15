import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/presentation/form_screen/component/screen/loading_widget.dart';
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
      bloc: context.read<HistoryPageBloc>()..add(LoadPostFromLocal()),
      builder: (context, state) {
        print("state hien tai  $state");
        AppLogger.instance.d(state.toString());
        if (state is HistoryPageInitial || state is HistoryPageLoading) {
          return const LoadingWidget();
        } else if (state is HistoryPageLoaded) {
          if (state.posts?.isEmpty == true) {
            return RefreshIndicator(
                color: Colors.red,
                onRefresh: () async {
                  final bloc = context.read<HistoryPageBloc>();
                  await Future.delayed(const Duration(seconds: 1));
                  bloc.add(LoadPostFromLocal());
                  print("state is ${context.read<HistoryPageBloc>().state}");
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No data'),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<HistoryPageBloc>()
                              .add(LoadPostFromLocal());
                          print(
                              "state is ${context.read<HistoryPageBloc>().state}");
                        },
                        child: const Text(
                          "Thử lại",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ));
          }
          return RefreshIndicator(
            color: Colors.red,
            onRefresh: () async {
              final bloc = context.read<HistoryPageBloc>();
              await Future.delayed(const Duration(seconds: 1));
              bloc.add(LoadPostFromLocal());
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
