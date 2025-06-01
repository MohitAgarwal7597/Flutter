import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 255, 111, 0); // Orange
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color.fromARGB(255, 28, 28, 30);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF1E1E1E);
  static const Color hintGrey = Color(0xFFBDBDBD);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      onPrimaryFixed: AppColors.black,
      surface: AppColors.lightGrey,
      onSurface: AppColors.black,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      tertiary: AppColors.hintGrey.withOpacity(.2),
      error: Colors.redAccent,
      onError: AppColors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.black),
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(color: AppColors.black),
      displayMedium: GoogleFonts.poppins(color: AppColors.black),
      displaySmall: GoogleFonts.poppins(color: AppColors.black),
      headlineLarge: GoogleFonts.poppins(color: AppColors.black),
      headlineMedium: GoogleFonts.poppins(color: AppColors.black),
      headlineSmall: GoogleFonts.poppins(color: AppColors.black),
      titleLarge: GoogleFonts.poppins(color: AppColors.black),
      titleMedium: GoogleFonts.poppins(color: AppColors.black),
      titleSmall: GoogleFonts.poppins(color: AppColors.black),
      bodyLarge: GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.lato(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(color: AppColors.hintGrey),
      labelLarge: GoogleFonts.poppins(color: AppColors.black),
      labelMedium: GoogleFonts.poppins(color: AppColors.black),
      labelSmall: GoogleFonts.poppins(color: AppColors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.lightGrey,
      filled: true,
      hintStyle: TextStyle(color: AppColors.hintGrey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.lightGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.lightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.primary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
    cardColor: AppColors.lightGrey,
    cardTheme: CardTheme(
      color: AppColors.lightGrey,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.orange;
          }
          return Colors.white;
        },
      ),
      side: BorderSide(color: Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.black,
      contentTextStyle: TextStyle(color: AppColors.white),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.black,
      onPrimaryFixed: AppColors.black,
      surface: AppColors.darkGrey,
      onSurface: AppColors.white,
      secondary: AppColors.white,
      onSecondary: AppColors.black,
      error: Colors.redAccent,
      onError: AppColors.black,
      tertiary: AppColors.hintGrey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(color: AppColors.white),
      displayMedium: GoogleFonts.poppins(color: AppColors.white),
      displaySmall: GoogleFonts.poppins(color: AppColors.white),
      headlineLarge: GoogleFonts.poppins(color: AppColors.white),
      headlineMedium: GoogleFonts.poppins(color: AppColors.white),
      headlineSmall: GoogleFonts.poppins(color: AppColors.white),
      titleLarge: GoogleFonts.poppins(color: AppColors.white),
      titleMedium: GoogleFonts.poppins(color: AppColors.white),
      titleSmall: GoogleFonts.poppins(color: AppColors.white),
      bodyLarge: GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.lato(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(color: AppColors.hintGrey),
      labelLarge: GoogleFonts.poppins(color: AppColors.white),
      labelMedium: GoogleFonts.poppins(color: AppColors.white),
      labelSmall: GoogleFonts.poppins(color: AppColors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.darkGrey,
      filled: true,
      hintStyle: TextStyle(color: AppColors.hintGrey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.hintGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.hintGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.primary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
    cardColor: AppColors.darkGrey,
    cardTheme: CardTheme(
      color: AppColors.darkGrey,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(AppColors.black),
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.orange;
          }
          return Colors.white;
        },
      ),
      side: BorderSide(color: Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary,
      contentTextStyle: TextStyle(color: AppColors.white),
    ),
  );
}
