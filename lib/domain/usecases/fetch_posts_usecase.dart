import 'package:dsoft_form_application/common/constant/app_errors/app_error.dart';
import 'package:dsoft_form_application/core/locators/locators.dart';
import 'package:dsoft_form_application/domain/models/meta_data_model.dart';
import 'package:dsoft_form_application/domain/models/post_model.dart';
import 'package:dsoft_form_application/domain/repositories/posts_repository.dart';
import 'package:dsoft_form_application/domain/usecases/usecase.dart';
import 'package:either_dart/either.dart';

class FetchPostsUsecase extends UseCase<dynamic, PostsModel> {
  late final PostsRepository _repository;

  FetchPostsUsecase() {
    _repository = diPostsRepository;
  }

  @override
  Future<Either<AppError, List<MetaDataModel>>> call(dynamic params) async {
    return _repository.fetchPosts();
  }
}
