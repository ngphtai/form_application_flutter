part of 'locators.dart';

final diFetchPostUseCase = di<FetchPostsUsecase>();
final diGetDetailPostUseCase = di<GetDetailPostUsecase>();
final diSaveAnswerToGoogleSheetUseCase = di<SaveAnswerToGoogleSheetUseCase>();
final diSaveResultPostUseCase = di<SaveResultPostUsecase>();
final diGetPostsFromLocalUseCase = di<GetPostsFromLocalUsecase>();
final diGetAnswerFromLocalUseCase = di<GetAnswerFromLocalUsecase>();

/// setup locator related to use cases
void setUpUseCasesLocator() {
  //remote
  di.registerSingletonWithDependencies(FetchPostsUsecase.new,
      dependsOn: [PostsRepository]);
  di.registerSingletonWithDependencies(GetDetailPostUsecase.new,
      dependsOn: [PostsRepository]);
  di.registerSingletonWithDependencies(SaveAnswerToGoogleSheetUseCase.new,
      dependsOn: [PostsRepository]);
  //local
  di.registerSingletonWithDependencies(SaveResultPostUsecase.new,
      dependsOn: [PostsRepository]);
  di.registerSingletonWithDependencies(GetPostsFromLocalUsecase.new,
      dependsOn: [PostsRepository]);
  di.registerSingletonWithDependencies(GetAnswerFromLocalUsecase.new,
      dependsOn: [PostsRepository]);
}
