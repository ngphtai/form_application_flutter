import 'package:dio/dio.dart';
import 'package:dsoft_form_application/common/constant/app_errors/app_error.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/domain/repositories/repository.dart';

import 'package:either_dart/either.dart';

import '../models/post_model.dart';

abstract class PostsRepository extends Repository {
  Future<Either<AppError, List<PostsModel>>> fetchPosts();
  Future<Either<AppError, PostsModel>> getDetailPost(int index);
}

class PostRepositoryImpl extends PostsRepository {
  final _fetchPosts = diPostsRemoteDataResource;
  @override
  Future<Either<AppError, List<PostsModel>>> fetchPosts() async {
    try {
      final postsModelDto = await _fetchPosts.getPosts();

      final List<PostsModel> result =
          postsModelDto.map((dto) => dto.toDomain()).toList();

      return Right(result);
    } on DioException catch (e) {
      return LeftAPI(e);
    }
  }

  @override
  Future<Either<AppError, PostsModel>> getDetailPost(index) async {
    try {
      final detailPost = await _fetchPosts.getDetailPost(index);

      final PostsModel result = detailPost.toDomain();

      return Right(result);
    } on DioException catch (e) {
      return LeftAPI(e);
    }
  }
}
