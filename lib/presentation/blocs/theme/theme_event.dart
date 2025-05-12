part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}

class ThemeLoaded extends ThemeEvent {
  const ThemeLoaded();
} 