import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dsoft_form_application/common/constant/constants.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/data/model/DTO/posts_response_model_dto.dart';

abstract class PostsRemoteDataResource {
  Future<List<PostsResponseModelDto>> getPosts();
  Future<PostsResponseModelDto> getDetailPost(int index);
}

class PostsRemoteDataResourceImpl extends PostsRemoteDataResource {
  final customHttpClient = diCustomHttpClient;
  @override
  Future<List<PostsResponseModelDto>> getPosts() async {
    try {
      final response = await customHttpClient.get(APIConstants.methodPost);
      final List<PostsResponseModelDto> forms = (response as List)
          .map((e) => PostsResponseModelDto.fromJson(e))
          .toList();
      return forms;
    } on DioException catch (e) {
      final message = e.response?.data.message;
      AppLogger.instance.e('Error during getForms: $message');
      return Future.error(message);
    }
  }

  @override
  Future<PostsResponseModelDto> getDetailPost(index) async {
    try {
      String url = "${APIConstants.methodPost}/${index}";
      var response = await customHttpClient.get(url);
      print("Raw response is $response");

      // var response = response.data;

      response = response is String
          ? json.decode(response) as Map<String, dynamic>
          : response;

      final PostsResponseModelDto detailPost =
          PostsResponseModelDto.fromJson(response);
      return detailPost;
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'Unknown error';
      AppLogger.instance.e('Error during detail: $message');
      return Future.error(message);
    }
  }
}
