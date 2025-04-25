import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: kLightPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: kBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: kLightPrimaryColor,
      foregroundColor: kBackgroundColor,
      // elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: kLightSecondaryColor)),
    colorScheme: ColorScheme.light(secondary: kLightSecondaryColor)
        .copyWith(surface: kLightBackgroundColor),
  );
}
