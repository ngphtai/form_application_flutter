import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '/common/logger/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropButtonBloc extends Cubit<CustomDropButtonState> {
  CustomDropButtonBloc() : super(CustomDropButtonInitial());

  String? isSelected;
  String? get getValue => isSelected;
  set values(String? value) => isSelected = value;

  void validate(String? value) {
    try {
      if (!isClosed) {
        if (value != null || value != "") {
          isSelected = value;
          emit(CustomDropButtonValid(
              isSelected: null)); // Reset trạng thái trước
          emit(CustomDropButtonValid(isSelected: value)); // Gửi trạng thái mới
        } else {
          emit(CustomDropButtonValid(isSelected: null));
        }
      }
    } catch (e) {
      AppLogger.instance.e('Error in custom drop button: ${e.toString()}');
    }
  }

  void isError() {
    emit(CustomDropButtonValid(isSelected: null));
  }
}

@immutable
abstract class CustomDropButtonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CustomDropButtonInitial extends CustomDropButtonState {}

class CustomDropButtonValid extends CustomDropButtonState {
  final String? isSelected;

  CustomDropButtonValid({required this.isSelected});
  @override
  List<Object?> get props => [isSelected];
}
