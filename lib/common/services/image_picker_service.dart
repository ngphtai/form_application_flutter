import 'dart:io';

import '/common/extensions/to_file.dart';
import 'package:flutter/foundation.dart';

import 'package:image_picker/image_picker.dart';

@immutable
// ignore: must_be_immutable
class ImagePickerHelper {
  List<File> selectedImages = [];
  static final ImagePicker _imagePicker = ImagePicker();
  static Future<List<File?>> pickMultiImageFromGallery() async {
    List<XFile?> images = await _imagePicker.pickMultiImage();

    return images.map((xfile) => File(xfile!.path)).toList();
  }

  static Future<File?> pickImageFromGallery() =>
      _imagePicker.pickImage(source: ImageSource.gallery).toFile();

  static Future<File?> pickVideoFromGallery() =>
      _imagePicker.pickVideo(source: ImageSource.gallery).toFile();

  static Future<List<File?>> pickMultiFileFromGallery() async {
    List<XFile?> file = await _imagePicker.pickMultipleMedia();
    return file.map((xfile) => File(xfile!.path)).toList();
  }
}
