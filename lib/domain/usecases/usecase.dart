// ignore_for_file: one_member_abstracts

import 'package:either_dart/either.dart';

import '../../common/constant/app_errors/app_error.dart';

/// Base for all use cases
/// [Type] is type of model be response from repository
/// [Params] is type of variable in call function.
abstract class UseCase<Type, Params> {
  /// Function called by use cases
  Future<Either<AppError, Type>> call(Params params);
}
