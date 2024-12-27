part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoadFailed extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<MetaDataModel> posts;

  const HomePageLoaded(this.posts);

  @override
  List<Object> get props => [];
}
