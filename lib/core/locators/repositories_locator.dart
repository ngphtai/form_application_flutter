part of 'locators.dart';

///creating [GetIt] for [HomeRepository]
final diPostsRepository = di<PostsRepository>();

/// setup locator related to repositories
void setUpRepositoriesLocator() {
  di.registerSingletonWithDependencies<PostsRepository>(PostRepositoryImpl.new,
      dependsOn: [PostRemoteDataResource, PostLocalDataSource]);
}
