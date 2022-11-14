part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final int theme;
  const ThemeLoaded({required this.theme});

  @override
  List<Object> get props => [theme];
}
