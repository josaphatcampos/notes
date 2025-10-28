import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ds_colors.dart';
import 'ds_spacing.dart';
import 'ds_typography.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: DSColors.backgroundLight,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: DSColors.navy,
      onPrimary: DSColors.white,
      secondary: DSColors.orange,
      onSecondary: DSColors.white,
      error: DSColors.pink,
      onError: DSColors.white,
      background: DSColors.backgroundLight,
      onBackground: DSColors.textPrimary,
      surface: DSColors.white,
      onSurface: DSColors.textPrimary,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: DSColors.textPrimary,
      displayColor: DSColors.textPrimary,
    ),
    extensions: <ThemeExtension<dynamic>>[DSSpacing.light, DSTypography.light],
    useMaterial3: true,
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DSColors.backgroundDark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: DSColors.orange,
      onPrimary: DSColors.darkPurple,
      secondary: DSColors.pink,
      onSecondary: DSColors.white,
      error: DSColors.pink,
      onError: DSColors.white,
      background: DSColors.backgroundDark,
      onBackground: DSColors.white,
      surface: DSColors.darkPurple,
      onSurface: DSColors.white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ).apply(bodyColor: DSColors.white, displayColor: DSColors.white),
    extensions: <ThemeExtension<dynamic>>[DSSpacing.dark, DSTypography.dark],
    useMaterial3: true,
  );
}
