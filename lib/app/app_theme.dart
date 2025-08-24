import 'package:flutter/material.dart';
import '../config/theme/colors.dart';
import '../config/theme/spacing.dart';
import '../config/theme/shapes.dart';
import '../config/theme/typography.dart';

final class AppTheme {
  AppTheme._();

  static ThemeData light = _build(brightness: Brightness.light);
  static ThemeData dark = _build(brightness: Brightness.dark);

  static ThemeData _build({required Brightness brightness}) {
    final scheme = brightness == Brightness.dark
        ? AppColors.darkScheme
        : AppColors.lightScheme;

    final text = buildTextTheme(scheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: text,
      visualDensity: VisualDensity.standard,

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
      ),

      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Corners.lg),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        height: 70,
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withOpacity(0.12),
        labelTextStyle: WidgetStatePropertyAll(text.labelMedium),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Corners.md),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.lg,
            vertical: Insets.sm,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Corners.md),
          ),
          side: BorderSide(color: scheme.outline),
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.lg,
            vertical: Insets.sm,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Corners.md),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.sm,
        ),
      ),

      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: Insets.lg,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: text.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Corners.md),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(Corners.sm),
        ),
        textStyle: text.labelSmall?.copyWith(color: scheme.onInverseSurface),
      ),
    );
  }
}
