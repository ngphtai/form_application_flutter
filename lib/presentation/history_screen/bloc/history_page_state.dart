part of 'history_page_bloc.dart';

sealed class HistoryPageState extends Equatable {
  const HistoryPageState();
}

final class HistoryPageInitial extends HistoryPageState {
  @override
  List<Object> get props => [];
}

final class HistoryPageLoading extends HistoryPageState {
  const HistoryPageLoading();

  @override
  List<Object> get props => [];
}

final class HistoryPageLoaded extends HistoryPageState {
  final List<PostsModel>? posts;

  const HistoryPageLoaded(this.posts);

  @override
  List<Object> get props => [posts ?? []];
}
