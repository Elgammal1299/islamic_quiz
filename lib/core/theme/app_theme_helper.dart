import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Helper class للحصول على الألوان المناسبة للـ theme الحالي
class AppThemeHelper {
  /// Get background color based on current theme
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
  }

  /// Get surface color based on current theme
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkSurface
        : AppColors.lightSurface;
  }

  /// Get card background color based on current theme
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkCardBackground
        : AppColors.lightCardBackground;
  }

  /// Get primary text color based on current theme
  static Color getTextPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
  }

  /// Get secondary text color based on current theme
  static Color getTextSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
  }

  /// Get divider color based on current theme
  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkDivider
        : AppColors.lightDivider;
  }

  /// Get border color based on current theme
  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkBorder
        : AppColors.lightBorder;
  }

  /// Check if dark mode is enabled
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Check if light mode is enabled
  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  /// Get gradient based on current theme
  static LinearGradient getPrimaryGradient(BuildContext context) {
    final isDark = isDarkMode(context);
    return isDark
        ? LinearGradient(
            colors: [
              AppColors.primaryLight.withValues(alpha: 0.3),
              AppColors.primary.withValues(alpha: 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : AppColors.primaryGradient;
  }
}
