import 'package:flutter/material.dart';

class AppTheme {
  static const Color greenDark = Color(0xFF6BCF9B);
  static const Color greenLight = Color(0xFFC8FFE2);
  static const Color redDark = Color(0xFFEF767A);
  static const Color blueDark = Color(0xFF6FA8DC);
  static const Color blueLight = Color(0xFFBBDFFF);
  static const Color neutralLight = Color(0xFFFAFAFA);
  static const Color neutralBg = Color(0xFFF1F3F5);
  static const Color yellow = Color(0xFFFFD166);
  static const Color yellowLight = Color(0xFFFFE7AF);
  static const Color dark = Color(0xFF2E2E2E);
  static const Color grayCustom = Color(0xFF6B7280);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: neutralBg,
    primaryColor: greenDark,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: dark,
    ),
  );
}
