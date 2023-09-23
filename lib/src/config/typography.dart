import 'package:app_rick_and_morty_flutter/src/config/colors.dart';
import 'package:flutter/material.dart';

abstract class CustomFontWeight {
  static const regular = FontWeight.w400;

  static const medium = FontWeight.w500;

  static const bold = FontWeight.w700;
}

abstract class CustomTypography {
  static const _fontName = 'Lato';
  static const _color800 = CustomColors.primary800;
  static const _color600 = CustomColors.primary600;
  static const _color300 = CustomColors.primary300;

  static const title1 = TextStyle(
    fontFamily: _fontName,
    color: _color800,
    fontSize: 20,
    fontWeight: CustomFontWeight.bold,
    height: 1.45,
    letterSpacing: .3,
  );

  static const body1 = TextStyle(
    fontFamily: _fontName,
    color: _color600,
    fontSize: 18,
    fontWeight: CustomFontWeight.medium,
    height: 1.45,
    letterSpacing: 0,
  );

  static const caption1 = TextStyle(
    fontFamily: _fontName,
    color: _color300,
    fontSize: 12,
    fontWeight: CustomFontWeight.regular,
    height: 1,
    letterSpacing: .1,
  );
}
