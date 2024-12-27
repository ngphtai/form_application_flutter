import '/common/constant/app_errors/app_error.dart';
import '/core/locators/locators.dart';
import '/domain/models/post_model.dart';
import '/domain/repositories/posts_repository.dart';
import '/domain/usecases/usecase.dart';
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

class GetAnswerFromLocalUsecase extends UseCase<PostsModel?, String> {
  late final PostsRepository _postsRepository;
  GetAnswerFromLocalUsecase() {
    _postsRepository = diPostsRepository;
  }

  @override
  Future<Either<AppError, PostsModel?>> call(String params) {
    return _postsRepository.getAnswerFromLocal(params);
  }
}
