// config/app/app_theme.dart
import 'package:flutter/material.dart';
import 'package:strixcam/config/theme/colors.dart';
import 'package:strixcam/config/theme/typography.dart';

final class AppTheme {
  AppTheme._();

  static ThemeData light = _build(colorScheme: AppColors.lightScheme);
  static ThemeData dark = _build(colorScheme: AppColors.darkScheme);

  static ThemeData _build({required ColorScheme colorScheme}) {
    final text = AppTypography.build(colorScheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: text,

      navigationBarTheme: NavigationBarThemeData(
        height: 50,
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.14),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
          final sel = states.contains(WidgetState.selected);
          return IconThemeData(
            color: sel ? colorScheme.primary : colorScheme.onSurfaceVariant,
            size: 25,
          );
        }),
      ),
    );
  }
}
