import 'package:flutter/material.dart';

import 'package:hessa/core/themes/colors/app_colors.dart';

ThemeData getDarkThemeData() {
  return ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColorDark,
      surfaceTintColor: AppColors.backgroundColorDark,
      iconTheme: IconThemeData(color: AppColors.primaryLight),
    ),
    fontFamily: "SF-Mono",
  );
}
