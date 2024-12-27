part of 'detail_page_bloc.dart';

abstract class DetailPageEvent extends Equatable {
  const DetailPageEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class LoadDetailPost extends DetailPageEvent {
  String id;
  LoadDetailPost(this.id);
  @override
  List<Object> get props => [id];
}

// ignore: must_be_immutable
class LoadDetailPostLocal extends DetailPageEvent {
  String id;
  LoadDetailPostLocal(this.id);

  @override
  List<Object> get props => [];
}
