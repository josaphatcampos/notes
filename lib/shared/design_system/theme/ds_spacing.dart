import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class DSSpacing extends ThemeExtension<DSSpacing> {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  const DSSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  @override
  DSSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return DSSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  ThemeExtension<DSSpacing> lerp(ThemeExtension<DSSpacing>? other, double t) {
    if (other is! DSSpacing) return this;
    return DSSpacing(
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
    );
  }

  static const light = DSSpacing(xs: 4, sm: 8, md: 16, lg: 24, xl: 32);
  static const dark = DSSpacing(xs: 4, sm: 8, md: 16, lg: 24, xl: 32);
}
