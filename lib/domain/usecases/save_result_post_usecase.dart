import 'package:dsoft_form_application/common/constant/app_errors/app_error.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/data/model/entities/post_model_entity.dart';

import 'package:dsoft_form_application/domain/repositories/posts_repository.dart';
import 'package:dsoft_form_application/domain/usecases/usecase.dart';
import 'package:either_dart/src/either.dart';

class SaveResultPostUsecase extends UseCase<dynamic, PostModelEntity> {
  late final PostsRepository _repository;

  SaveResultPostUsecase() {
    _repository = diPostsRepository;
  }
  @override
  Future<Either<AppError, bool>> call(dynamic params) {
    return _repository.saveResultPostToLocal(params);
  }
}
