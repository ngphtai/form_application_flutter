part of 'form_page_bloc.dart';

abstract class FormPageEvent extends Equatable {
  const FormPageEvent();

  @override
  List<Object> get props => [];
}

class SaveForm extends FormPageEvent {
  final PostModelEntity postsEntity;

  SaveForm(this.postsEntity);

  @override
  List<Object> get props => [postsEntity];
}

class SaveAnswerLocal extends FormPageEvent {
  final PostsModel post;

  SaveAnswerLocal(this.post);

  @override
  List<Object> get props => [post];
}

class LoadAnswerLocal extends FormPageEvent {
  final String id;
  LoadAnswerLocal(this.id);

  @override
  List<Object> get props => [];
}
