import 'dart:io';

import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/common/services/image_picker_service.dart';
import 'package:dsoft_form_application/core/styles/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  final List<String> listMediaPath = [];
  final List<String> listNameFile = [];
  final List<double> listSizeFile = []; //size by MB
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: Color(0xfff4f4f4),
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.fromBorderSide(
            BorderSide(color: Color(0xffe8e8e8), width: 1)),
      ),
      child: GestureDetector(
        onTap: () async {
          try {
            final imageFiles =
                await ImagePickerHelper.pickMultiFileFromGallery();

            //TODO  save to hive
            if (imageFiles.isEmpty) {
              print("error");
              return;
            } else {
              setState(() {
                isVisible = true;
                for (var file in imageFiles) {
                  listMediaPath.add(file!.path);
                  listNameFile.add(file.path.split('/').last);
                  double sizeFileMB =
                      (File(file.path).lengthSync()) / (1024 * 1024);
                  listSizeFile.add(double.parse(sizeFileMB.toStringAsFixed(2)));
                }

                AppLogger.instance.d(
                    "Check status: $listNameFile,$listNameFile,$listSizeFile ALo ALO ALO");
              });
              print("HAVE FILE IS: $imageFiles ");

              // handle save to hive
              //   print(imageFile);
              //   await ref
              //       .read(updateInfoProvider.notifier)
              //       .updateAvatar(
              //         empFace: imageFile,
              //         uid: userId.toString(),
              //       );
              //   print('update avatar success');
              //   return ref.refresh(
              //       userInfoModelProvider(userId.toString()));
            }
          } catch (e) {
            AppLogger.instance.e("Error: ${e.toString()}");
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                    visible: !isVisible,
                    child: Column(
                      children: [
                        Image.asset(AppIcons.documentUpload),
                        const Gap(8),
                        const Text(
                          "Tải tệp lên",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        const Gap(8),
                        const Text(
                          "Dung lượng tối đa 10MB",
                          style:
                              TextStyle(color: Color(0xff8C8C8C), fontSize: 12),
                        )
                      ],
                    )),
                Visibility(
                  visible: isVisible,
                  child: Column(
                    children: List.generate(listNameFile.length, (index) {
                      String fileName = listNameFile[index];
                      String displayName = fileName.length > 20
                          ? '${fileName.substring(0, 20)}...${fileName.substring(fileName.length - 4)}'
                          : fileName;

                      // Convert file size from bytes to MB
                      double fileSizeMB = listSizeFile[index] as double;
                      // double fileSizeMB = listSizeFile[index] / (1024 * 1024);
                      String fileSizeText = "${fileSizeMB.toString()} MB";

                      return Row(
                        children: [
                          Image.asset(
                            AppIcons.folder2,
                            height: 32,
                            width: 32,
                          ),
                          const Gap(8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                fileSizeText,
                                style: const TextStyle(
                                    color: Color(0xff8C8C8C), fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
