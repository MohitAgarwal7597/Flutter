import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Colors.black;
  static const Color white = Color(0xFFFFFFFF);
  static const Color scaffoldColor = Color.fromARGB(255, 246, 226, 209);
  static const Color black = Color(0xFF1C1C1E); // Black
  static const Color lightGrey = Color(0xFFF5F5F5); // Light Grey
  static const Color darkGrey = Color(0xFFBDBDBD); // Dark Grey
  static const Color hintGrey = Color(0xFF9E9E9E); // Hint Grey
}

class AppTheme {
  static final lightTheme = ThemeData(
      useMaterial3: true,
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(color: AppColors.black),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          hintStyle: const TextStyle(color: AppColors.hintGrey),
        ),
        menuStyle: MenuStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.white),
          elevation: MaterialStateProperty.all(4),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.black,
        secondary: AppColors.white,
        onSecondary: AppColors.white,
        error: Colors.red,
        onError: AppColors.white,
        background: AppColors.white,
        onBackground: AppColors.black,
        surface: AppColors.lightGrey,
        onSurface: AppColors.black,
        tertiary: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 2,
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
        fillColor: AppColors.black,
        filled: true,
        hintStyle: const TextStyle(color: AppColors.hintGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.primary),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.white;
          },
        ),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: const BorderSide(color: AppColors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.white,
        elevation: 2,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.primary,
        elevation: 2,
        modalElevation: 2,
      ));

  static final darkTheme = ThemeData(
    useMaterial3: true,
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(color: AppColors.primary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.black,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        hintStyle: const TextStyle(color: AppColors.hintGrey),
      ),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.black),
        elevation: MaterialStateProperty.all(4),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.black,
        onSecondary: AppColors.primary,
        error: Colors.red,
        onError: AppColors.white,
        background: AppColors.black,
        onBackground: AppColors.black,
        surface: AppColors.darkGrey,
        onSurface: AppColors.white,
        tertiary: AppColors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 2,
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
        color: AppColors.black,
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
      hintStyle: const TextStyle(color: AppColors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.primary),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.black;
        },
      ),
      checkColor: WidgetStateProperty.all(AppColors.white),
      side: const BorderSide(color: AppColors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.black,
      elevation: 2,
    ),
  );
}
