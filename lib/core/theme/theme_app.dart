import 'package:flutter/material.dart';
import 'package:pomodoro_app/core/consts/app_colors.dart';

class ThemeApp {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.terciaryColor,
      secondary: AppColors.secondColor,
      onSecondary: AppColors.quartyColor,
      error: AppColors.errorColor,
      onError: AppColors.errorSurfaceColor,
      surface: AppColors.quintoColor,
      onSurface: AppColors.primaryTextColor,
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColor),
  );
}
