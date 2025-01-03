import 'package:dio/dio.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import '/common/constant/app_errors/app_error.dart';
import '/core/locators/locators.dart';
import '/data/model/entities/post_model_entity.dart';
import '/domain/models/meta_data_model.dart';
import '/domain/repositories/repository.dart';

import 'package:either_dart/either.dart';

import '../models/post_model.dart';

abstract class PostsRepository extends Repository {
  //remote
  Future<Either<AppError, List<MetaDataModel>>> fetchPosts();
  Future<Either<AppError, PostsModel>> getDetailPost(String index);
  Future<Either<AppError, bool>> saveAnswerToGoogleSheet(PostsModel post);
  //local
  Future<Either<AppError, bool>> saveResultPostToLocal(PostModelEntity post);
  Future<Either<AppError, List<PostsModel>?>> getPostsFromLocal();
  Future<Either<AppError, PostsModel?>> getAnswerFromLocal(String id);
}

class PostRepositoryImpl extends PostsRepository {
  //remote
  final _fetchPosts = diPostsRemoteDataResource;
  @override
  Future<Either<AppError, List<MetaDataModel>>> fetchPosts() async {
    try {
      final metaDataModelDto = await _fetchPosts.getPosts();

      final List<MetaDataModel> result =
          metaDataModelDto.map((dto) => dto.toDomain()).toList();

      return Right(result);
    } on DioException catch (e) {
      AppLogger.instance.d(e.toString());
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

  @override
  Future<Either<AppError, bool>> saveAnswerToGoogleSheet(
      PostsModel post) async {
    final Either<AppError, bool> result =
        await _fetchPosts.saveAnswerToGoogleSheet(post);
    return result;
  }

  //Local

  final postLocal = diPostLocalDataResource;
  @override
  Future<Either<AppError, bool>> saveResultPostToLocal(
      PostModelEntity post) async {
    try {
      final result = await postLocal.savePost(post);
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, List<PostsModel>?>> getPostsFromLocal() async {
    try {
      final result = await postLocal.getPostsLocal();

      final List<PostsModel>? postsModel =
          result?.map((e) => e.toDomain()).toList();
      return Right(postsModel);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, PostsModel?>> getAnswerFromLocal(String id) async {
    try {
      final result = await postLocal.getAnswers(id);
      final PostsModel? post = result?.toDomain();

      return Right(post);
    } on AppError catch (e) {
      return Left(e);
    }
  }
}
