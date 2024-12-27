import '/common/constant/app_errors/app_error.dart';
import '/core/locators/locators.dart';
import '/domain/repositories/posts_repository.dart';
import '/domain/usecases/usecase.dart';
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

class GetPostsFromLocalUsecase extends UseCase {
  late final PostsRepository _postsRepository;

  GetPostsFromLocalUsecase() {
    _postsRepository = diPostsRepository;
  }

  @override
  Future<Either<AppError, dynamic>> call(params) {
    return _postsRepository.getPostsFromLocal();
  }
}
