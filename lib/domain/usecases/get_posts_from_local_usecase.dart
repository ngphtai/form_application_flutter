import 'package:dsoft_form_application/common/constant/app_errors/app_error.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/domain/repositories/posts_repository.dart';
import 'package:dsoft_form_application/domain/usecases/usecase.dart';
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
