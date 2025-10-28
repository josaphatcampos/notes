import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ds_colors.dart';

@immutable
class DSTypography extends ThemeExtension<DSTypography> {
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle caption;

  const DSTypography({
    required this.titleLarge,
    required this.titleMedium,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.caption,
  });

  @override
  DSTypography copyWith({
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? caption,
  }) {
    return DSTypography(
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      caption: caption ?? this.caption,
    );
  }

  @override
  ThemeExtension<DSTypography> lerp(
    ThemeExtension<DSTypography>? other,
    double t,
  ) {
    if (other is! DSTypography) return this;
    return DSTypography(
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
    );
  }

  static final light = DSTypography(
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: DSColors.textPrimary,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: DSColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.poppins(fontSize: 16, color: DSColors.textPrimary),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: DSColors.textSecondary,
    ),
    caption: GoogleFonts.poppins(fontSize: 12, color: DSColors.textSecondary),
  );

  static final dark = DSTypography(
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: DSColors.white,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: DSColors.white,
    ),
    bodyLarge: GoogleFonts.poppins(fontSize: 16, color: DSColors.white),
    bodyMedium: GoogleFonts.poppins(fontSize: 14, color: DSColors.gray),
    caption: GoogleFonts.poppins(fontSize: 12, color: DSColors.gray),
  );
}
