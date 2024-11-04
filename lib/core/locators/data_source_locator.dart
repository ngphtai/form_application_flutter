part of 'locators.dart';

final diPostsRemoteDataResource = di<PostsRemoteDataResource>();

/// setup locator related to remote data source
void setUpRemoteDataSource() {
  di.registerSingletonWithDependencies<PostsRemoteDataResource>(
      PostsRemoteDataResourceImpl.new,
      dependsOn: [CustomHttpClient]);
}
