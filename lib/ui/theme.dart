import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: Colors.blue,
    primaryVariant: Colors.blue,
    secondary: Colors.white,
    secondaryVariant: Colors.grey.shade200,
    surface: Colors.white,
    background: Colors.white,
    error: Colors.red.shade900,
    onPrimary: Colors.white,
    onSecondary: const Color(0xFF2B2D42),
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
  colorScheme: lightTheme.colorScheme.copyWith(
    secondary: const Color(0xFF2B2D42),
    secondaryVariant: const Color(0xFF393B54),
    surface: const Color(0xFF2B2D42),
    background: const Color(0xFF2B2D42),
    onSecondary: Colors.white
  ),
);
