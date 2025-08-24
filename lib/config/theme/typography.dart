import 'package:flutter/material.dart';

final class AppFonts {
  AppFonts._();
  
  static const String? primary = null; // e.g., 'Inter'
  static const String? mono = null; // e.g., 'JetBrainsMono'
}

final class FontSizes {
  FontSizes._();
  static const double xs = 11;
  static const double sm = 12;
  static const double md = 14;
  static const double lg = 16;
  static const double xl = 20;
  static const double h6 = 22;
  static const double h5 = 24;
  static const double d1 = 32;
  static const double d2 = 40;
}

TextTheme buildTextTheme(ColorScheme scheme) {
  final base = Typography.material2021().black.apply(
    displayColor: scheme.onSurface,
    bodyColor: scheme.onSurface,
  );

  TextStyle fam(TextStyle? s, double size, FontWeight w, {bool mono = false}) =>
      (s ?? const TextStyle()).copyWith(
        fontFamily: mono ? AppFonts.mono : AppFonts.primary,
        fontSize: size,
        fontWeight: w,
      );

  return base.copyWith(
    displayLarge: fam(base.displayLarge, FontSizes.d2, FontWeight.w700),
    displayMedium: fam(base.displayMedium, 36, FontWeight.w700),
    displaySmall: fam(base.displaySmall, FontSizes.d1, FontWeight.w700),

    headlineLarge: fam(base.headlineLarge, FontSizes.h5, FontWeight.w700),
    headlineMedium: fam(base.headlineMedium, FontSizes.h6, FontWeight.w600),
    headlineSmall: fam(base.headlineSmall, FontSizes.xl, FontWeight.w600),

    titleLarge: fam(base.titleLarge, FontSizes.xl, FontWeight.w600),
    titleMedium: fam(base.titleMedium, FontSizes.lg, FontWeight.w600),
    titleSmall: fam(base.titleSmall, FontSizes.md, FontWeight.w600),

    bodyLarge: fam(base.bodyLarge, FontSizes.lg, FontWeight.w400),
    bodyMedium: fam(base.bodyMedium, FontSizes.md, FontWeight.w400),
    bodySmall: fam(base.bodySmall, FontSizes.sm, FontWeight.w400),

    labelLarge: fam(base.labelLarge, FontSizes.md, FontWeight.w600),
    labelMedium: fam(base.labelMedium, FontSizes.sm, FontWeight.w600),
    labelSmall: fam(base.labelSmall, FontSizes.xs, FontWeight.w600),
  );
}
