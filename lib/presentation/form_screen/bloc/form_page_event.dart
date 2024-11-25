part of 'form_page_bloc.dart';

abstract class FormPageEvent extends Equatable {
  const FormPageEvent();

  @override
  List<Object> get props => [];
}

class SaveForm extends FormPageEvent {
  final PostModelEntity postsEntity;

  const SaveForm(this.postsEntity);

  @override
  List<Object> get props => [postsEntity];
}

class SaveAnswerToGoogleSheet extends FormPageEvent {
  final PostsModel post;

  const SaveAnswerToGoogleSheet(this.post);

  @override
  List<Object> get props => [post];
}

class LoadAnswerLocal extends FormPageEvent {
  final String id;
  const LoadAnswerLocal(this.id);
  @override
  List<Object> get props => [];
}
