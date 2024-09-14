import 'package:flutter/material.dart';


class AppTheme {
  // Define light theme colors
  static const Color lightPrimary = Color(0xFFFFFFFF);  // White
  static const Color lightAccent = Color(0xFF0d7d13);  // Green
  static const Color lightSecondary = Color(0xFFE5E4E2); // Light Gray
  static const Color lightText = Color(0xFF000000);    // Black

  // Define dark theme colors
  static const Color darkPrimary = Color(0xFF0e1d3e);  // Dark Blue
  static const Color darkAccent = Color(0xFFE2F7E1);   // Soft Mint
  static const Color darkSecondary = Color(0xFF818589); // Grayish Blue
  static const Color darkText = Color(0xFFFFFFFF);     // White

  // Light Theme Configuration
  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: lightPrimary,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightAccent,
        surface: lightSecondary,
        onPrimary: lightText,
        onSecondary: lightText,
        onSurface: lightText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightPrimary,
        iconTheme: IconThemeData(color: lightText),
        titleTextStyle: TextStyle(
          color: lightText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: lightSecondary, // Change the cursor color here
          selectionColor: Colors.black.withOpacity(0.5), // Change the text selection color
          selectionHandleColor: Colors.black, // Change the selection handle color
        ),
      iconTheme: const IconThemeData(color: lightSecondary),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: lightAccent, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightText.withOpacity(0.3), width: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: darkPrimary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          color: lightText.withOpacity(0.7),
        ),
        hintStyle: TextStyle(
          fontSize: 12,
          color: lightText.withOpacity(0.5),
        ),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
          color: lightText,
          fontSize: 12,
        ),
        bodyMedium: TextStyle(
          color: lightText,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          color: lightText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: lightText,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: lightText,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: lightText,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Dark Theme Configuration
  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: darkPrimary,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkAccent,
        surface: darkSecondary,
        onPrimary: darkText,
        onSecondary: darkText,
        onSurface: darkText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkPrimary,
        iconTheme: IconThemeData(color: darkText),
        titleTextStyle: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(color: darkAccent),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: darkAccent, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkText.withOpacity(0.3), width: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: darkAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          color: darkText.withOpacity(0.7),
        ),
        hintStyle: TextStyle(
          fontSize: 12,
          color: darkText.withOpacity(0.5),
        ),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
          color: darkText,
          fontSize: 12,
        ),
        bodyMedium: TextStyle(
          color: darkText,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: darkText,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: darkText,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: darkText,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
