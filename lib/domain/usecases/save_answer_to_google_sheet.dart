import '/common/constant/app_errors/app_error.dart';
import '/core/locators/locators.dart';
import '/domain/models/post_model.dart';
import '/domain/repositories/posts_repository.dart';
import '/domain/usecases/usecase.dart';
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

class SaveAnswerToGoogleSheetUseCase extends UseCase<bool, PostsModel> {
  late final PostsRepository _postRepository;

  SaveAnswerToGoogleSheetUseCase() {
    _postRepository = diPostsRepository;
  }

  @override
  Future<Either<AppError, bool>> call(PostsModel params) {
    return _postRepository.saveAnswerToGoogleSheet(params);
  }
}
