part of 'locators.dart';

final diPostSeviceable = di<PostsServiceable>();

/// setup locator related to serviceable
void setUpServiceableLocator() {
  di.registerSingletonWithDependencies(PostsServiceable.new,
      dependsOn: [FetchPostsUsecase]);
}
