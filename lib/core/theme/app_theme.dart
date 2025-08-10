import 'package:flutter/material.dart';

class MarketiColors {
  // Primary Colors
  static const Color primary = Color(0xFFFE0017);
  static const Color primaryLight = Color(0xFFFF3F50);
  static const Color primaryDark = Color(0xFFBF0011);
  static const Color primaryExtraDark = Color(0xFF7F000B);

  // Secondary Colors (Blue)
  static const Color secondary = Color(0xFF3F80FF);
  static const Color secondaryLight = Color(0xFF659AFF);
  static const Color secondaryLighter = Color(0xFF8CB3FF);
  static const Color secondaryLightest = Color(0xFFD9E6FF);
  static const Color secondaryDark = Color(0xFF0056FE);
  static const Color secondaryExtraDark = Color(0xFF001640);

  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F8F8);
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);
}

class MarketiTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: MarketiColors.primary,
      scaffoldBackgroundColor: MarketiColors.offWhite,
      appBarTheme: const AppBarTheme(
        backgroundColor: MarketiColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: MarketiColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: MarketiColors.black),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: MarketiColors.black,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: MarketiColors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: MarketiColors.black,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: MarketiColors.black,
        ),
        headlineSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: MarketiColors.black,
        ),
        titleLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: MarketiColors.gray700,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: MarketiColors.gray800,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: MarketiColors.gray600,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: MarketiColors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MarketiColors.primary,
          foregroundColor: MarketiColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      // Add your dark theme configurations here
    );
  }
}
