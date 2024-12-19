import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingBloc extends Cubit<RatingState> {
  int? selected;
  int? get value => selected;
  set value(int? value) => selected = value;

  RatingBloc() : super(RatingInitial());

  void validate(int value) {
    if (value != 0) {
      selected = value;
      emit(RatingValidate(isValid: true, star: value));
    } else {
      selected = null;
      emit(RatingValidate(isValid: false, star: null));
    }
  }

  void setError() {
    emit(RatingValidate(
        isValid: false, star: null)); // for state init and submit
  }
}

abstract class RatingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RatingInitial extends RatingState {
  @override
  List<Object> get props => [];
}

class RatingValidate extends RatingState {
  final bool isValid;
  final int? star;

  RatingValidate({required this.isValid, required this.star});

  @override
  List<Object?> get props => [isValid, star];
}
