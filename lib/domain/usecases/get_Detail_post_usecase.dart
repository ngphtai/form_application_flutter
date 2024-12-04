import '/common/constant/app_errors/app_error.dart';
import '/core/locators/locators.dart';
import '/domain/repositories/posts_repository.dart';
import '/domain/usecases/usecase.dart';
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

import '../models/post_model.dart';

class GetDetailPostUsecase extends UseCase<PostsModel, String> {
  late final PostsRepository _repository;

  GetDetailPostUsecase() {
    _repository = diPostsRepository;
  }

  @override
  Future<Either<AppError, PostsModel>> call(String params) {
    return _repository.getDetailPost(params);
  }
}
