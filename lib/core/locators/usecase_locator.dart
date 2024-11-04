part of 'locators.dart';

final diFetchPostUseCase = di<FetchPostsUsecase>();
final diGetDetailPostUseCase = di<GetDetailPostUsecase>();

/// setup locator related to use cases
void setUpUseCasesLocator() {
  di.registerSingletonWithDependencies(FetchPostsUsecase.new,
      dependsOn: [PostsRepository]);
  di.registerSingletonWithDependencies(GetDetailPostUsecase.new,
      dependsOn: [PostsRepository]);
}