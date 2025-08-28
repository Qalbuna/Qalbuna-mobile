import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.v1Primary500,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      // Headline styles
      displayLarge: AppTypography.h1Bold,
      displayMedium: AppTypography.h2Bold,
      displaySmall: AppTypography.h3Bold,
      headlineMedium: AppTypography.h4Bold,
      headlineSmall: AppTypography.h5Bold,

      // Body styles
      bodyLarge: AppTypography.lRegular,
      bodyMedium: AppTypography.mRegular,
      bodySmall: AppTypography.sRegular,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.v1Primary500,
      error: AppColors.v1Error500,
      onPrimary: Colors.white,
    ),
    // Add more theme configurations as needed
  );
}
