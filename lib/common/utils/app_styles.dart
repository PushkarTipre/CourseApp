import 'package:course_app/common/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appThemeData = ThemeData(
    appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.primaryText)),
  );
}
