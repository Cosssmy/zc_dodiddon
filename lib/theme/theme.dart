import 'package:flutter/material.dart';

class DoDidDoneTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF7704C4), // Основной цвет
      brightness: Brightness.light,
      primary: const Color(0xFF7704C4), // Основной цвет
      onPrimary: Colors.white,
      secondary: const Color(0xFFFF0E0E), // Второй цвет
      onSecondary: Colors.white,
      error: Colors.white,
      onError: Colors.white,
      background: const Color(0xFF7704C4), // Основной цвет
      onBackground: Colors.white,
      surface: const Color(0xFFFF0E0E), // Второй цвет
      onSurface: Colors.white,
    ),
    useMaterial3: true,
  );
}
