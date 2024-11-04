part of 'detail_page_bloc.dart';

abstract class DetailPageState extends Equatable {
  const DetailPageState();

  @override
  List<Object> get props => [];
}

class DetailPageInitial extends DetailPageState {}

class DetailPageLoading extends DetailPageState {}

class DetailPageLoaded extends DetailPageState {
  final PostsModel post;
  const DetailPageLoaded(this.post);
  @override
  List<Object> get props => [post];
}
