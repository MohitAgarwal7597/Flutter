import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:po_smart_advisor/theme/app_color.dart';

class AppTheme {
  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColor.elevatedButtonblue, // Use your theme blue
    brightness: Brightness.light,
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
    textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: AppColor.blackText,
        displayColor: AppColor.blackText,
        fontFamily: GoogleFonts.inter().fontFamily),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.elevatedButtonblue,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      margin: const EdgeInsets.all(8),
    ),
  );
}
