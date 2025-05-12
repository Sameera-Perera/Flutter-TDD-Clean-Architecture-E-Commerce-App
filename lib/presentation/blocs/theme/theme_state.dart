part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final bool isDarkMode;
  const ThemeState({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(isDarkMode: false);
}

class ThemeLoadedState extends ThemeState {
  const ThemeLoadedState({required bool isDarkMode}) : super(isDarkMode: isDarkMode);
} 