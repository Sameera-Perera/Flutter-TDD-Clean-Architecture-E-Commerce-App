import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const Color _baseColor = Color(0xFF3a3a3a);
  static const Color _highlightColor = Color(0xff5b5b5b);
  static const Color _lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color _lightSurfaceColor = Colors.white;
  static const Color _lightErrorColor = Color(0xFFB00020);

  static const Color _darkBackgroundColor = Color(0xFF121212);
  static const Color _darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color _darkErrorColor = Color(0xFFCF6679);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _baseColor,
    scaffoldBackgroundColor: _lightBackgroundColor,
    colorScheme: ColorScheme.light(
      primary: _baseColor,
      secondary: _highlightColor,
      surface: _lightSurfaceColor,
      background: _lightBackgroundColor,
      error: _lightErrorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _baseColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _baseColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _baseColor,
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: _lightSurfaceColor,
      elevation: 2,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _baseColor,
    scaffoldBackgroundColor: _darkBackgroundColor,
    colorScheme: ColorScheme.dark(
      primary: _baseColor,
      secondary: _highlightColor,
      surface: _darkSurfaceColor,
      background: _darkBackgroundColor,
      error: _darkErrorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkSurfaceColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _highlightColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _baseColor,
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: _darkSurfaceColor,
      elevation: 2,
    ),
  );
}








