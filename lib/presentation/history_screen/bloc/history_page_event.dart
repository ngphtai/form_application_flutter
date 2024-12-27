part of 'history_page_bloc.dart';

sealed class HistoryPageEvent extends Equatable {
  const HistoryPageEvent();

  @override
  List<Object> get props => [];
}

class LoadPostFromLocal extends HistoryPageEvent {}
