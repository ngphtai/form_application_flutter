import '/common/constant/app_errors/app_error.dart';
import '/core/locators/locators.dart';
import '/data/model/entities/post_model_entity.dart';

import '/domain/repositories/posts_repository.dart';
import '/domain/usecases/usecase.dart';
// ignore: implementation_imports
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
