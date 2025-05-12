import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';
  final SharedPreferences _prefs;

  ThemeBloc(this._prefs) : super(const ThemeInitial()) {
    on<ThemeLoaded>(_onThemeLoaded);
    on<ThemeToggled>(_onThemeToggled);
  }

  void _onThemeLoaded(ThemeLoaded event, Emitter<ThemeState> emit) {
    final isDarkMode = _prefs.getBool(_themeKey) ?? false;
    emit(ThemeLoadedState(isDarkMode: isDarkMode));
  }

  void _onThemeToggled(ThemeToggled event, Emitter<ThemeState> emit) {
    final newThemeMode = !state.isDarkMode;
    _prefs.setBool(_themeKey, newThemeMode);
    emit(ThemeLoadedState(isDarkMode: newThemeMode));
  }
} 