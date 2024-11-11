import 'package:dsoft_form_application/common/constant/app_errors/app_error.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/data/model/entities/post_model_entity.dart';
import 'package:either_dart/either.dart';

import '../models/post_model.dart';

class PostsServiceable {
  final _fetchPost = diFetchPostUseCase;
  final _getDetailPost = diGetDetailPostUseCase;
  final _saveResultPost = diSaveResultPostUseCase;
  PostsServiceable();

  Future<void> initialize() async {}

  Future<Either<AppError, List<PostsModel>>> fetchPostsToLocal() async {
    var result = await _fetchPost.call(dynamic);

    return result.fold(
      (error) {
        AppLogger.instance.e(error.toString());
        return Left(error);
      },
      (postsModel) {
        return Right(postsModel);
      },
    );
  }

  Future<Either<AppError, PostsModel>> getDetailPost(int index) async {
    var result = await _getDetailPost.call(index);

    return result.fold((context) {
      AppLogger.instance.e(context.toString());
      return Left(context);
    }, (postModel) {
      return Right(postModel);
    });
  }

  Future<Either<AppError, bool>> saveResultPostToLocal(
      PostModelEntity post) async {
    var result = await _saveResultPost.call(post);

    return result.fold((context) {
      AppLogger.instance.e(context.toString());
      return Left(context);
    }, (result) {
      return Right(result);
    });
  }
}
