part of 'time_picker_custom_bloc.dart';

@immutable
abstract class TimePickerState extends Equatable {
  const TimePickerState();
  @override
  List<Object?> get props => [];
}

class TimePickerInitial extends TimePickerState {}

class TimePickerChanged extends TimePickerState {
  final String? value;

  const TimePickerChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class TimePickerError extends TimePickerState {
  final String errorText;

  const TimePickerError(this.errorText);

  @override
  List<Object?> get props => [errorText];
}
