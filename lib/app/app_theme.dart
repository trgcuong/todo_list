import 'package:flutter/material.dart';
import 'package:todo_list/resources/colors.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
        primarySwatch: AppColors.blue,
        inputDecorationTheme: const DefaultInputTheme());
  }
}

class DefaultInputTheme extends InputDecorationTheme {
  const DefaultInputTheme()
      : super(
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: AppColors.primary)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.red)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: AppColors.primary)),
        );
}
