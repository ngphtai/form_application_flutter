part of 'theme_cubit.dart';

@immutable
sealed class ThemeState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ThemeInitial extends ThemeState {
  @override
  List<Object?> get props => [];
}

final class ThemeComplete extends ThemeState {
  ThemeComplete({required this.themeData});

  final ThemeData? themeData;

  @override
  List<Object?> get props => [themeData];
}
