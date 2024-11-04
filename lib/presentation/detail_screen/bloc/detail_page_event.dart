part of 'detail_page_bloc.dart';

abstract class DetailPageEvent extends Equatable {
  const DetailPageEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailPost extends DetailPageEvent {
  int id;
  LoadDetailPost(this.id);
  @override
  List<Object> get props => [id];
}
