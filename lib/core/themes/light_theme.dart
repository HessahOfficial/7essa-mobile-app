import 'package:flutter/material.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColorLight,
      surfaceTintColor: AppColors.backgroundColorLight,
      iconTheme: IconThemeData(color: AppColors.primaryLight),
    ),
    fontFamily: "SF-Mono",
  );
}
