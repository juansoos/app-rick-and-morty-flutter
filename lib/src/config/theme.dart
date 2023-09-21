import 'package:app_rick_and_morty_flutter/src/config/colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme._();

  static BottomNavigationBarThemeData get _bottomTheme {
    const selectedColor = CustomColors.primary600;
    const unselectedColor = CustomColors.primary50;

    return const BottomNavigationBarThemeData(
      backgroundColor: CustomColors.white,
      elevation: 10,
      selectedIconTheme: IconThemeData(color: selectedColor),
      unselectedIconTheme: IconThemeData(color: unselectedColor),
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      showUnselectedLabels: true,
      showSelectedLabels: true,
    );
  }

  static ThemeData light = ThemeData.from(
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: CustomColors.white,
      errorColor: CustomColors.error,
    ).copyWith(
      primary: CustomColors.primary600,
      secondary: CustomColors.primary300,
    ),
    useMaterial3: true,
  ).copyWith(
    bottomNavigationBarTheme: _bottomTheme,
  );
}
