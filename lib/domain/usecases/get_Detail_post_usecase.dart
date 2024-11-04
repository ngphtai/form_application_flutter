import 'package:dsoft_form_application/common/constant/app_errors/app_error.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/domain/repositories/posts_repository.dart';
import 'package:dsoft_form_application/domain/usecases/usecase.dart';
import 'package:either_dart/src/either.dart';

import '../models/post_model.dart';

class GetDetailPostUsecase extends UseCase<PostsModel, int> {
  late final PostsRepository _repositry;

  GetDetailPostUsecase() {
    _repositry = diPostsRepository;
  }

  @override
  Future<Either<AppError, PostsModel>> call(int index) {
    return _repositry.getDetailPost(index);
  }
}
