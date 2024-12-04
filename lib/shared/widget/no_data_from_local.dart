import '/core/styles/app_icons.dart';
import '/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class noDataFromLocal extends StatelessWidget {
  const noDataFromLocal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.emptyData,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          Text(
            "Không có dữ liệu",
            style: AppTextStyle.bold16,
          ),
          Text(
            "Chưa có form nào được hoàn thành",
            style:
                AppTextStyle.regular14.copyWith(color: const Color(0xff727272)),
          )
        ],
      ),
    );
  }
}
