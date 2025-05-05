import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Catppuccin Latte
const catppuccinLatteSurface = Color(0xFFEFF1F5);
const catppuccinLattePrimary = Color(0xFF4c566a); // Slightly darker primary
const catppuccinLatteSecondary = Color(0xFF5e81ac); // Blue secondary
const catppuccinLatteTertiary = Color(0xFFa3be8c); // Green tertiary
const catppuccinLatteAccent = Color(0xFFd08770); // Coral Accent
const catppuccinLatteError = Color(0xFFb45b58); // Deep red error
const catppuccinLatteHighlight = Color(0xFFebcb8b); //Highlight color
const catppuccinLatteSubtext0 = Color(0xFF6c7086);
const catppuccinLatteSubtext1 = Color(0xFF5c6370);
const catppuccinLatteText = Color(0xFF4d4d4d);

// Catppuccin Mocha
const catppuccinMochaSurface = Color(0xFF1e1e2e);
const catppuccinMochaPrimary = Color(0xFFcdd6f4); //Lighter primary
const catppuccinMochaSecondary = Color(0xFF89b4fa); // Brighter Blue
const catppuccinMochaTertiary = Color(0xFF90ee90); // Light green
const catppuccinMochaAccent = Color(0xFFf5c2e7); // Pastel Pink accent
const catppuccinMochaError = Color(0xFFf34946); //Stronger red error
const catppuccinMochaHighlight = Color(0xFFeed49f); // Highlight color
const catppuccinMochaSubtext0 = Color(0xFFA6ADC8);
const catppuccinMochaSubtext1 = Color(0xFF939AB7);
const catppuccinMochaText = Color(0xFFFFFFFF);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: catppuccinLatteSurface,
    primary: catppuccinLattePrimary,
    secondary: catppuccinLatteSecondary,
    tertiary: catppuccinLatteTertiary,
    onTertiary: catppuccinLatteHighlight,
    primaryContainer: catppuccinLatteAccent,
    error: catppuccinLatteError,
    onPrimary: catppuccinLatteSurface,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: catppuccinLatteSurface,
    foregroundColor: catppuccinLattePrimary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: catppuccinLatteAccent,
    foregroundColor: catppuccinLatteSurface,
  ),
  textTheme: GoogleFonts.lexendTextTheme().apply(
    bodyColor: catppuccinLatteText,
    displayColor: catppuccinLatteSubtext0,
  ),
  iconTheme: const IconThemeData(color: catppuccinLattePrimary),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: catppuccinMochaSurface,
    primary: catppuccinMochaPrimary,
    secondary: catppuccinMochaSecondary,
    tertiary: catppuccinMochaTertiary,
    onTertiary: catppuccinMochaHighlight,
    primaryContainer: catppuccinMochaAccent,
    error: catppuccinMochaError,
    onPrimary: catppuccinLatteSubtext1,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: catppuccinMochaSurface,
    foregroundColor: catppuccinMochaPrimary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: catppuccinMochaAccent,
    foregroundColor: catppuccinMochaSurface,
  ),
  textTheme: GoogleFonts.lexendTextTheme().apply(
    bodyColor: catppuccinMochaText,
    displayColor: catppuccinMochaSubtext0,
  ),
  iconTheme: const IconThemeData(color: Colors.red),
);
