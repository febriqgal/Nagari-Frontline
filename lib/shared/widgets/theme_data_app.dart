import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeDataApp() {
  return ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      iconColor: Colors.blue,
      prefixIconColor: Colors.blue,
      fillColor: Colors.blue.withValues(alpha: 0.2),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(
            99,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  );
}
