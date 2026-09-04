import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData appThemeData = ThemeData(
    primaryColor: Colors.black87,
    fontFamily: 'Quicksand',
    textTheme: TextTheme(
      // content
      bodySmall: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 2,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        height: 2,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        height: 2,
        color: Colors.black87,
      ),
      labelSmall: TextStyle(
        fontSize: 20,
        color: Colors.black87,
        height: 2,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        height: 2,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        fontSize: 20,
        color: Colors.black87,
        height: 2,
        fontWeight: FontWeight.w500,
      ),

      // titles
      displaySmall: TextStyle(
        fontSize: 20,
        height: 1.2,
        color: Colors.black87,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        height: 1.2,
        color: Colors.black87,
      ),
      displayLarge: TextStyle(
        fontSize: 28,
        height: 1.2,
        color: Colors.black87,
      ),
      titleSmall: TextStyle(
        fontSize: 20,
        color: Colors.black87,
        height: 1.2,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontSize: 25,
        color: Colors.black87,
        height: 1.2,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontSize: 230,
        color: Colors.black87,
        height: 1.2,
        fontWeight: FontWeight.w500,
      ),

      // large texts
      headlineSmall: TextStyle(
        fontSize: 40,
        height: 1.25,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontSize: 60,
        height: 1.25,
        color: Colors.black87,
      ),
      headlineLarge: TextStyle(
        fontSize: 80,
        height: 1.25,
        color: Colors.black87,
      ),
    ),
  );
}
