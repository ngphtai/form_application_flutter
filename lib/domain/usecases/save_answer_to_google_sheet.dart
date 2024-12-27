import 'package:dsoft_form_application/data/model/entities/post_model_entity.dart';

import '/common/constant/app_errors/app_error.dart';
import '/core/locators/locators.dart';
import '/domain/repositories/posts_repository.dart';
import '/domain/usecases/usecase.dart';
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

class SaveAnswerToGoogleSheetUseCase extends UseCase<bool, PostModelEntity> {
  late final PostsRepository _postRepository;

  SaveAnswerToGoogleSheetUseCase() {
    _postRepository = diPostsRepository;
  }

  @override
  Future<Either<AppError, bool>> call(PostModelEntity params) {
    return _postRepository.saveAnswerToGoogleSheet(params.toDomain());
  }
}
