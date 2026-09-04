import 'package:bekia_pay/app/theming/app_colors.dart';
import 'package:bekia_pay/core/utils/constants/font_constants.dart';
import 'package:flutter/material.dart';

class AppLightTheme {
  static ThemeData theme = ThemeData(
    fontFamily: FontConstants.usModern,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLightColor,
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size(300, 55),
        backgroundColor: AppColors.primaryLightColor,
        foregroundColor: AppColors.backgroundLightColor,
        shape: RoundedRectangleBorder(borderRadius: .circular(24)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: .symmetric(horizontal: 18, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: .circular(15),
        borderSide: BorderSide(color: AppColors.disableLightColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: .circular(15),
        borderSide: BorderSide(color: AppColors.disableLightColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: .circular(15),
        borderSide: BorderSide(color: AppColors.primaryLightColor, width: 1.7),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: .circular(15),
        borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: .circular(15),
        borderSide: BorderSide(color: AppColors.redColor, width: 1.7),
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(fontSize: 9, color: AppColors.textLightColor),
      titleSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
      titleMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textLightColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textLightColor,
      ),
      displaySmall: TextStyle(
        color: AppColors.textLightColor,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      displayLarge: TextStyle(
        color: AppColors.textLightColor,
        fontSize: 30,
        fontWeight: FontWeight.w900,
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: AppColors.textLightColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryLightColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryLightColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.disableLightColor,
      ),
    ),
  );
}
