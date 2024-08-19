import 'package:flutter/material.dart';

ThemeData light({Color color = primaryColor}) => ThemeData(
  fontFamily: 'OpenSans',
  primaryColor: color,
  secondaryHeaderColor: const Color(0xFF000000),
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)), colorScheme: ColorScheme.light(primary: color, secondary: color, background: backgroundAppColor).copyWith(background: backgroundAppColor),
);

const backgroundAppColor = Color(0xFFFFFFFF);
const colorIconDisabled = Color(0xFF7C9094);
const colorSubBackground = Color(0xFFF7F9FA);
const primaryColor = Color(0xFF4AB5CD);