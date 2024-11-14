import 'package:dsoft_form_application/common/constant/app_errors/app_error.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:dsoft_form_application/domain/repositories/posts_repository.dart';
import 'package:dsoft_form_application/domain/usecases/usecase.dart';
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
