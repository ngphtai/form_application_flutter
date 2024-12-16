import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar formAppBar(BuildContext context, String? currentRoute, onPop, title) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: SizedBox(
      height: 0.3.sh,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0.3.sw,
            child: GestureDetector(
              onTap: () async => onPop(context, currentRoute ?? ""),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.arrow_back_ios_new, size: 20.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: 0.55.sw,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                )),
          ),
        ],
      ),
    ),
  );
}
