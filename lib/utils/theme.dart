import 'package:flutter/material.dart';

class AppTheme {
  //  custom colors
  static const Color darkVoid = Color(0xFF151419);
  static const Color liquidLava = Color(0xFFF56E0F);
  static const Color gluonGrey = Color(0xFF1B1B1B);
  static const Color slateGrey = Color(0xFF262626);
  static const Color dustyGrey = Color(0xFF878787);
  static const Color snow = Color(0xFFFBFBFB);
  static const Color darkSnow = Color(0xFFE5E5E5);
  static const Color brightRed = Color(0xFFFF2C2C);
  static const Color lightBlue = Color(0xFF5FAEF8);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: liquidLava,
      onPrimary: snow,
      secondary: dustyGrey,
      onSecondary: snow,
      surface: darkSnow,
      onSurface: slateGrey,
      error: brightRed,
      onError: Colors.white,
    ),
    brightness: Brightness.light,
    primaryColor: liquidLava,
    scaffoldBackgroundColor: snow,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: snow,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: liquidLava,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(
      color: slateGrey,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: liquidLava,
      onPrimary: darkVoid,
      secondary: dustyGrey,
      onSecondary: darkVoid,
      surface: slateGrey,
      onSurface: snow,
      error: brightRed,
      onError: darkVoid,
    ),
    brightness: Brightness.dark,
    primaryColor: liquidLava,
    scaffoldBackgroundColor: gluonGrey,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: snow,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: liquidLava,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(
      color: snow,
    ),
  );
}
