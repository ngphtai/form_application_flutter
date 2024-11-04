part of 'form_page_bloc.dart';

abstract class FormPageEvent extends Equatable {
  const FormPageEvent();

  @override
  List<Object> get props => [];
}

class LoadPost extends FormPageEvent {}
