import 'package:flutter/material.dart';
import 'package:marketiapp/core/theme/app_size.dart';
import 'package:marketiapp/core/theme/app_colors.dart';

class AppTextStyles {
  // Display Styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: MarketiColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: MarketiColors.textPrimary,
    height: 1.25,
  );

  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: MarketiColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: MarketiColors.textPrimary,
    height: 1.35,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: MarketiColors.textPrimary,
    height: 1.4,
  );

  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: MarketiColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: MarketiColors.textPrimary,
    height: 1.45,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: MarketiColors.textPrimary,
    height: 1.5,
  );

  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: MarketiColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: MarketiColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: MarketiColors.textSecondary,
    height: 1.5,
  );

  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: MarketiColors.white,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: MarketiColors.white,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: MarketiColors.white,
    height: 1.4,
  );

  // Special Styles
  static const TextStyle priceLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: MarketiColors.primaryRed,
    height: 1.3,
  );

  static const TextStyle discountBadge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: MarketiColors.white,
    height: 1.2,
  );
}

class AppButtonStyles {
  // Primary Button
  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: MarketiColors.primaryRed,
    foregroundColor: MarketiColors.white,
    disabledBackgroundColor: MarketiColors.gray300,
    disabledForegroundColor: MarketiColors.gray500,
    minimumSize: const Size.fromHeight(AppSize.buttonHeight),
    padding: const EdgeInsets.symmetric(vertical: AppSize.paddingMedium),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.buttonRadius),
    ),
    elevation: AppSize.buttonElevation,
    textStyle: AppTextStyles.labelLarge,
  );

  // Secondary Button (now as OutlinedButton)
  static final ButtonStyle secondary = OutlinedButton.styleFrom(
    backgroundColor: MarketiColors.white,
    foregroundColor: MarketiColors.primaryRed,
    disabledBackgroundColor: MarketiColors.white,
    disabledForegroundColor: MarketiColors.gray300,
    minimumSize: const Size.fromHeight(AppSize.buttonHeight),
    padding: const EdgeInsets.symmetric(vertical: AppSize.paddingMedium),
    side: const BorderSide(color: MarketiColors.primaryRed),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.buttonRadius),
    ),
    textStyle: AppTextStyles.labelLarge.copyWith(color: MarketiColors.primaryRed),
  );

  // Text Button
  static final ButtonStyle text = TextButton.styleFrom(
    foregroundColor: MarketiColors.primaryRed,
    disabledForegroundColor: MarketiColors.gray300,
    padding: const EdgeInsets.symmetric(
      vertical: AppSize.paddingSmall,
      horizontal: AppSize.paddingMedium,
    ),
    textStyle: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
  );
}

class AppInputStyles {
  // Standard Text Field
  static InputDecoration textField({
    String? label,
    String? hint,
    String? errorText,
    Widget? prefix,
    Widget? suffix,
    bool hasError = false,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      errorText: errorText,
      prefixIcon: prefix,
      suffixIcon: suffix,
      filled: true,
      fillColor: MarketiColors.white,
      contentPadding: const EdgeInsets.all(AppSize.paddingMedium),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: BorderSide(
          color: hasError ? MarketiColors.error : MarketiColors.gray300,
          width: AppSize.inputFieldBorderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: const BorderSide(
          color: MarketiColors.gray300,
          width: AppSize.inputFieldBorderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: const BorderSide(
          color: MarketiColors.primaryRed,
          width: AppSize.inputFieldBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: const BorderSide(
          color: MarketiColors.error,
          width: AppSize.inputFieldBorderWidth,
        ),
      ),
      labelStyle: AppTextStyles.bodyMedium,
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: MarketiColors.gray500),
      errorStyle: AppTextStyles.bodySmall.copyWith(color: MarketiColors.error),
      floatingLabelStyle: AppTextStyles.bodyMedium.copyWith(
        color: MarketiColors.primaryRed,
      ),
    );
  }

  // Search Field
  static InputDecoration searchField = textField(
    hint: 'Search products...',
    prefix: const Icon(Icons.search, size: AppSize.iconMedium),
  ).copyWith(
    contentPadding: const EdgeInsets.symmetric(
      vertical: AppSize.paddingSmall,
      horizontal: AppSize.paddingMedium,
    ),
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: MarketiColors.primaryRed,
      colorScheme: const ColorScheme.light(
        primary: MarketiColors.primaryRed,
        secondary: MarketiColors.primaryBlue,
        surface: MarketiColors.white,
        background: MarketiColors.backgroundLight,
        error: MarketiColors.error,
      ),
      scaffoldBackgroundColor: MarketiColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: MarketiColors.white,
        elevation: AppSize.appBarElevation,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleLarge,
        iconTheme: IconThemeData(color: MarketiColors.textPrimary),
      ),
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: AppButtonStyles.primary),
      outlinedButtonTheme: OutlinedButtonThemeData(style: AppButtonStyles.secondary),
      textButtonTheme: TextButtonThemeData(style: AppButtonStyles.text),
    );
  }
}