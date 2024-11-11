part of 'form_page_bloc.dart';

abstract class FormPageState extends Equatable {
  const FormPageState();

  @override
  List<Object> get props => [];
}

class FormPageInitial extends FormPageState {}

class FormPageSaveSuccess extends FormPageState {
  final PostModelEntity postsEntity;

  const FormPageSaveSuccess(this.postsEntity);

  @override
  List<Object> get props => [postsEntity];
}
