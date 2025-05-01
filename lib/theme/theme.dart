import 'package:flutter/material.dart';

// Catppuccin Latte
const catppuccinLatteSurface = Color(0xFFEFF1F5);
const catppuccinLattePrimary = Color(0xFF6C7086);
const catppuccinLatteSecondary = Color(0xFF4C4F69);
const catppuccinLatteAccent = Color(0xFFD20F39);

// Catppuccin Mocha
const catppuccinMochaSurface = Color(0xFF1E1E2E);
const catppuccinMochaPrimary = Color(0xFFD9E0EE);
const catppuccinMochaSecondary = Color(0xFFA6ADC8);
const catppuccinMochaAccent = Color(0xFFF38BA8);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: catppuccinLatteSurface,
    primary: catppuccinLattePrimary,
    secondary: catppuccinLatteSecondary,
    primaryContainer: catppuccinLatteAccent,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: catppuccinLatteSurface,
    foregroundColor: catppuccinLattePrimary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: catppuccinLatteAccent,
    foregroundColor: catppuccinLatteSurface,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: catppuccinMochaSurface,
    primary: catppuccinMochaPrimary,
    secondary: catppuccinMochaSecondary,
    primaryContainer: catppuccinMochaAccent,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: catppuccinMochaSurface,
    foregroundColor: catppuccinMochaPrimary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: catppuccinMochaAccent,
    foregroundColor: catppuccinMochaSurface,
  ),
);
