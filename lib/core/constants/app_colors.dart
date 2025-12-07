import 'package:flutter/material.dart';

class AppColors {
  // Common colors - يعملوا في الاتنين
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryLight = Color(0xFF66BB6A);
  static const Color secondary = Color(0xFF388E3C);
  static const Color accent = Color(0xFFFFC107);
  static const Color correct = Color(0xFF4CAF50);
  static const Color incorrect = Color(0xFFF44336);

  // Light theme colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Colors.white;
  static const Color lightCardBackground = Colors.white;
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightBorder = Color(0xFFE0E0E0);

  // Dark theme colors - ألوان محسّنة للوضع الليلي
  static const Color darkBackground = Color(0xFF0A0E27);
  static const Color darkSurface = Color(0xFF151929);
  static const Color darkCardBackground = Color(0xFF1E2336);
  static const Color darkTextPrimary = Color(0xFFE8EAED);
  static const Color darkTextSecondary = Color(0xFFADB5BD);
  static const Color darkDivider = Color(0xFF2D3548);
  static const Color darkBorder = Color(0xFF2D3548);

  // Legacy support (deprecated - use theme-specific colors)
  @Deprecated('Use lightBackground or darkBackground instead')
  static const Color background = lightBackground;

  @Deprecated('Use lightCardBackground or darkCardBackground instead')
  static const Color cardBackground = lightCardBackground;

  @Deprecated('Use lightTextPrimary or darkTextPrimary instead')
  static const Color textPrimary = lightTextPrimary;

  @Deprecated('Use lightTextSecondary or darkTextSecondary instead')
  static const Color textSecondary = lightTextSecondary;

  @Deprecated('Use lightDivider or darkDivider instead')
  static const Color divider = lightDivider;

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
