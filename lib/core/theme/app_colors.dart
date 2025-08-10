import 'package:flutter/material.dart';

class MarketiColors {

  static const Color primaryRed = Color(0xFFFE0017);
  static const Color primaryRedLight = Color(0xFFFF3F50);
  static const Color primaryRedDark = Color(0xFFBF0011);
  static const Color primaryRedDarker = Color(0xFF7F000B);
  static const Color primaryRedDarkest = Color(0xFF400006);
  static const Color primaryBlue = Color(0xFF3F80FF);
  static const Color primaryBlueLight = Color(0xFF659AFF);
  static const Color primaryBlueLighter = Color(0xFF8CB3FF);
  static const Color primaryBlueLightest = Color(0xFFD9E6FF);
  static const Color primaryBlueDark = Color(0xFF0056FE);
  static const Color primaryBlueDarker = Color(0xFF0041BF);
  static const Color primaryBlueDarkest = Color(0xFF001640);

  static const Color blueVariant1 = Color(0xFF5286EC);
  static const Color blueVariant2 = Color(0xFF658DD9);
  static const Color blueVariant3 = Color(0xFF7993C5);
  static const Color blueVariant4 = Color(0xFF8C99B2);
  static const Color blueVariant5 = Color(0xFF51526C);

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


  
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);
  
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);


  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color backgroundGrey = Color(0xFFF5F5F5);


  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  
  
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF616161);
  static const Color textDisabled = Color(0xFF9E9E9E);
  static const Color textInverse = Color(0xFFFFFFFF);
  static const Color textError = Color(0xFFD32F2F);

  
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF424242);
  
  static const Color dividerLight = Color(0xFFEEEEEE);
  static const Color dividerDark = Color(0xFF333333);


  static const Color overlayLight = Color(0x33000000); 
  static const Color overlayDark = Color(0x33FFFFFF); 


  static const Color shadowLight = Color(0x1F000000); 
  static const Color shadowDark = Color(0x7F000000); 


  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryRed, primaryBlue],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryBlueLight, primaryBlue],
  );


}