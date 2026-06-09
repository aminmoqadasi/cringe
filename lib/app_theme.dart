import 'package:flutter/material.dart';

class AppTheme {
  static const String fontFamily = 'Shabnam';
  static const String fontFamilyFD = 'ShabnamFD';
  static const String fontFamilyEmoji = 'NotoEmoji';

  static const List<String> fontFamilyFallback = ['NotoEmoji'];

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xff09090B),
      fontFamily: fontFamily,
      textTheme: _buildTextTheme(),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      displayMedium: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      displaySmall: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      headlineLarge: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      headlineMedium: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      headlineSmall: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      titleLarge: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      titleMedium: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      titleSmall: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      bodyLarge: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      bodyMedium: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      bodySmall: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      labelLarge: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      labelMedium: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
      labelSmall: TextStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback),
    );
  }
}