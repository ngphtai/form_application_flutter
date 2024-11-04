import 'package:dsoft_form_application/common/constant/app_errors/app_error.dart';
import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:either_dart/either.dart';

import '../models/post_model.dart';

class PostsServiceable {
  final _fetchPost = diFetchPostUseCase;
  final _getDetailPost = diGetDetailPostUseCase;
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

    AppLogger.instance.i("data in getDetail ${result.toString()}");

    return result.fold((_) {
      AppLogger.instance.e(_.toString());
      return Left(_);
    }, (postModel) {
      return Right(postModel);
    });
  }
}
