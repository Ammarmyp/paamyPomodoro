import 'package:flutter/material.dart';

class AppTheme {
  //  custom colors
  static const Color darkVoid = Color(0xFF151419);
  static const Color liquidLava = Color(0xFFF56E0F);
  static const Color gluonGrey = Color(0xFF1B1B1E);
  static const Color slateGrey = Color(0xFF262626);
  static const Color dustyGrey = Color(0xFF878787);
  static const Color snow = Color(0xFFFBFBFB);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: liquidLava,
      onPrimary: snow,
      secondary: dustyGrey,
      onSecondary: snow,
      surface: snow,
      onSurface: slateGrey,
      error: Colors.red.shade800,
      onError: Colors.white,
    ),
    brightness: Brightness.light,
    primaryColor: liquidLava,
    scaffoldBackgroundColor: snow,
    appBarTheme: const AppBarTheme(
      backgroundColor: liquidLava,
      foregroundColor: snow,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: liquidLava,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: liquidLava,
      onPrimary: darkVoid,
      secondary: dustyGrey,
      onSecondary: darkVoid,
      surface: slateGrey,
      onSurface: snow,
      error: Colors.red.shade300,
      onError: darkVoid,
    ),
    brightness: Brightness.dark,
    primaryColor: liquidLava,
    scaffoldBackgroundColor: gluonGrey,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkVoid,
      foregroundColor: snow,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: liquidLava,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
