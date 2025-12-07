import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  // Quick access to theme
  ThemeData get theme => Theme.of(this);

  // Quick access to color scheme
  ColorScheme get colors => Theme.of(this).colorScheme;

  // Quick access to text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Helper getters for common colors
  Color get primaryColor => colors.primary;
  Color get secondaryColor => colors.secondary;
  Color get surfaceColor => colors.surface;
  Color get backgroundColor => theme.scaffoldBackgroundColor;
  Color get textColor => colors.onSurface;
  Color get secondaryTextColor => colors.onSurface.withValues(alpha: 0.7);
  Color get cardColor => theme.cardTheme.color ?? colors.surface;
  Color get dividerColor => theme.dividerTheme.color ?? colors.onSurface.withValues(alpha: 0.12);

  // Check if dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;
}
