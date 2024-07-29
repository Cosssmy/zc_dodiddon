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
      background: const Color(0xFF212121), // Установите цвет фона на #212121
      onBackground: const Color(0xFFFFFFFF),
      surface: const Color(0xFFFF0E0E), // Второй цвет
      onSurface: Colors.white,
    ),
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFFFFFF), // Цвет фона кнопок
        ),
      ),
    ),
    // Добавляем тему для BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      backgroundColor: Color(
          0xFF212121), // Установите цвет фона на #212121 для нижней навигации
    ),
  );
}
