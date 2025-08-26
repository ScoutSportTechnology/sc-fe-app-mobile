import 'package:flutter/material.dart';

/// Compact design tokens + builder in one place.
final class AppTypography {
  AppTypography._();

  // Fonts (hook up later via pubspec if you want custom families)
  static const String? primary = null; // e.g. 'Inter'
  static const String? mono = null; // e.g. 'JetBrainsMono'

  // Sizes
  static const double _xs = 11,
      _sm = 12,
      _md = 14,
      _lg = 16,
      _h3 = 18,
      _h2 = 20,
      _h1 = 22,
      _d1 = 24,
      _d2 = 26,
      _d3 = 28;

  static TextTheme build(ColorScheme scheme) {
    final base = Typography.material2021().black.apply(
      displayColor: scheme.onSurface,
      bodyColor: scheme.onSurface,
    );

    TextStyle _s(
      TextStyle? t,
      double sz,
      FontWeight w, {
      bool isMono = false,
    }) => (t ?? const TextStyle()).copyWith(
      fontFamily: isMono ? mono : primary,
      fontSize: sz,
      fontWeight: w,
    );

    return base.copyWith(
      // Display
      displayLarge: _s(base.displayLarge, _d3, FontWeight.w700),
      displayMedium: _s(base.displayMedium, _d2, FontWeight.w700),
      displaySmall: _s(base.displaySmall, _d1, FontWeight.w700),

      // Headlines
      headlineLarge: _s(base.headlineLarge, _h1, FontWeight.w700),
      headlineMedium: _s(base.headlineMedium, _h2, FontWeight.w600),
      headlineSmall: _s(base.headlineSmall, _h3, FontWeight.w600),

      // Titles
      titleLarge: _s(base.titleLarge, _lg, FontWeight.w600),
      titleMedium: _s(base.titleMedium, _md, FontWeight.w600),
      titleSmall: _s(base.titleSmall, _sm, FontWeight.w600),

      // Body
      bodyLarge: _s(base.bodyLarge, _lg, FontWeight.w400),
      bodyMedium: _s(base.bodyMedium, _md, FontWeight.w400),
      bodySmall: _s(base.bodySmall, _sm, FontWeight.w400),

      // Labels (kept a touch smaller for nav/buttons)
      labelLarge: _s(base.labelLarge, _md, FontWeight.w600),
      labelMedium: _s(base.labelMedium, _sm, FontWeight.w600),
      labelSmall: _s(base.labelSmall, _xs, FontWeight.w600),
    );
  }
}
