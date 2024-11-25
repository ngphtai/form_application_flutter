import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingBloc extends Cubit<RatingState> {
  int? selected;
  int? get value => selected;
  set value(int? value) => selected = value;

  RatingBloc() : super(RatingInitial());

  void validate(int? value) {
    if (value != null) {
      selected = value;
      emit(RatingValidate(value: true));
    } else {
      selected = null;
      emit(RatingValidate(value: false));
    }
  }

  void setError() {
    emit(RatingValidate(value: false)); // for state init and submit
  }
}

abstract class RatingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RatingInitial extends RatingState {}

class RatingValidate extends RatingState {
  final bool value;
  RatingValidate({required this.value});

  @override
  List<Object?> get props => [value];
}
