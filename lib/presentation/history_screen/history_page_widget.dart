import 'package:dsoft_form_application/core/styles/app_text_style.dart';

import '../../common/constant/constants.dart';
import '../../core/locators/locators.dart';
import '/shared/widget/no_data_from_local.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../common/logger/app_logger.dart';
import "../form_screen/component/screen/loading_widget.dart";
import 'bloc/history_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../core/routing/route_path.dart';
import '../../core/styles/app_icons.dart';

class HistoryPageWidget extends StatelessWidget {
  const HistoryPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryPageBloc, HistoryPageState>(
      bloc: context.read<HistoryPageBloc>()..add(LoadPostFromLocal()),
      builder: (context, state) {
        AppLogger.instance.d(state.toString());
        if (state is HistoryPageInitial || state is HistoryPageLoading) {
          return const LoadingWidget();
        } else if (state is HistoryPageLoaded) {
          if (state.posts?.isEmpty == true) {
            return RefreshIndicator(
                color: const Color(0xffdb1e39),
                onRefresh: () async {
                  final bloc = context.read<HistoryPageBloc>();
                  await Future.delayed(const Duration(seconds: 1));
                  bloc.add(LoadPostFromLocal());
                },
                child: const noDataFromLocal());
          }
          return RefreshIndicator(
            color: const Color(0xffdb1e39),
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
                      onTap: () async {
                        context.push(
                            '${Routers.historyPage}/${Routers.reviewDetailPage}/${post.id}');
                        await diAnalytics.log(
                            LogEvents.tap_review_fill_form_button,
                            {"id form": post.id});
                      },
                      child: Center(
                        child: Container(
                          width: 0.95.sw,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 10, 8, 10),
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(AppIcons.folder),
                                        const Gap(10),
                                        Expanded(
                                          child: Text(
                                            post!.title,
                                            style: AppTextStyle.bold14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(10),
                                    Text(
                                      post.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.regular12.copyWith(
                                          color: const Color(0xff6f6f6f)),
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
                                                  color:
                                                      const Color(0xff6f6f6f)),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffdcffe9),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                          ),
                                          child: Text(
                                            "Đã điền",
                                            style: AppTextStyle.bold12.copyWith(
                                                color: const Color(0xff008549)),
                                          ),
                                        )
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
