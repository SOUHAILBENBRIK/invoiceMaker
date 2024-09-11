import 'package:flutter/material.dart';
import 'package:quick_invoice/utils/constants_app.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: AppConstant.lightSecondary),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        hintStyle: TextStyle(
          fontSize: 12,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      textTheme: const TextTheme(
        
        bodySmall: TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        headlineSmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
        headlineLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        buttonColor: Colors.white,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
