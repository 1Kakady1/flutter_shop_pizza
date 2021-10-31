import 'package:flutter/material.dart';
import 'package:pizza_time/styles/colors.dart';

//https://github.com/sanjibsinha/better_flutter_chapter_two/blob/main/lib/views/material_design_theme_control.dart
ThemeData customThemeLight() {
  final ThemeData base = ThemeData.light();
  return ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFE5E5E5),
    appBarTheme: AppBarTheme().copyWith(
        shadowColor: const Color(0xFFE5E5E5),
        iconTheme: IconThemeData().copyWith(color: const Color(0xFF000000)),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.black),
    textTheme: _customTextTheme(base.textTheme),
    backgroundColor: AppColors.backgroundColor,
    primaryTextTheme: _customTextTheme(base.primaryTextTheme),
    buttonTheme: _customButtonTheme(base.buttonTheme),
    inputDecorationTheme:
        _customInputDecorationTheme(base.inputDecorationTheme),
  );
}

InputDecorationTheme _customInputDecorationTheme(InputDecorationTheme base) {
  return base.copyWith(
      labelStyle: TextStyle(color: AppColors.black),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.black),
      ));
}

ButtonThemeData _customButtonTheme(ButtonThemeData base) {
  return base.copyWith(buttonColor: AppColors.red[200]);
}

TextTheme _customTextTheme(TextTheme base) {
  return base
      .copyWith(
          headline2: base.headline2!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: AppColors.black),
          headline3: base.headline3!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: AppColors.gray),
          headline1: base.headline1!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 30.0,
              color: AppColors.black),
          subtitle1: base.subtitle1!.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppColors.black),
          subtitle2: base.subtitle1!.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppColors.gray))
      .apply(
        fontFamily: 'Poppins',
      );
}
