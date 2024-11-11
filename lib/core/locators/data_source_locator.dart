part of 'locators.dart';

final diPostsRemoteDataResource = di<PostRemoteDataResource>();

final diPostLocalDataResource = di<PostLocalDataSource>();

/// setup locator related to remote data source
void setUpRemoteDataSource() {
  di.registerSingletonWithDependencies<PostRemoteDataResource>(
      PostsRemoteDataResourceImpl.new,
      dependsOn: [CustomHttpClient]);
}

void setUpLocalDataResource() {
  di.registerSingletonWithDependencies<PostLocalDataSource>(
      PostLocalDataSourceImpl.new,
      dependsOn: [HiveUtils]);
}
