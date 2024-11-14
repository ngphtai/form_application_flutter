part of 'locators.dart';

final diFetchPostUseCase = di<FetchPostsUsecase>();
final diGetDetailPostUseCase = di<GetDetailPostUsecase>();
final diSaveResultPostUseCase = di<SaveResultPostUsecase>();
final diGetPostsFromLocalUseCase = di<GetPostsFromLocalUsecase>();
final diGetAnswerFromLocalUseCase = di<GetAnswerFromLocalUsecase>();

/// setup locator related to use cases
void setUpUseCasesLocator() {
  di.registerSingletonWithDependencies(FetchPostsUsecase.new,
      dependsOn: [PostsRepository]);
  di.registerSingletonWithDependencies(GetDetailPostUsecase.new,
      dependsOn: [PostsRepository]);
  di.registerSingletonWithDependencies(SaveResultPostUsecase.new,
      dependsOn: [PostsRepository]);
  di.registerSingletonWithDependencies(GetPostsFromLocalUsecase.new,
      dependsOn: [PostsRepository]);
  di.registerSingletonWithDependencies(GetAnswerFromLocalUsecase.new,
      dependsOn: [PostsRepository]);
}
