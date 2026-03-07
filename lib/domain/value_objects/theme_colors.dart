import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Value object representing theme colors
class ThemeColors extends Equatable {
  const ThemeColors({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.onBackground,
    required this.error,
    required this.onError,
    this.primaryContainer,
    this.onPrimaryContainer,
    this.secondaryContainer,
    this.onSecondaryContainer,
    this.tertiary,
    this.onTertiary,
    this.tertiaryContainer,
    this.onTertiaryContainer,
    this.surfaceVariant,
    this.onSurfaceVariant,
    this.outline,
    this.shadow,
    this.inverseSurface,
    this.onInverseSurface,
    this.inversePrimary,
  });

  /// Create default light theme colors
  const ThemeColors.defaultLight()
      : primary = const Color(0xFF6750A4),
        onPrimary = const Color(0xFFFFFFFF),
        secondary = const Color(0xFF625B71),
        onSecondary = const Color(0xFFFFFFFF),
        surface = const Color(0xFFFFFBFE),
        onSurface = const Color(0xFF1C1B1F),
        background = const Color(0xFFFFFBFE),
        onBackground = const Color(0xFF1C1B1F),
        error = const Color(0xFFBA1A1A),
        onError = const Color(0xFFFFFFFF),
        primaryContainer = const Color(0xFFEADDFF),
        onPrimaryContainer = const Color(0xFF21005D),
        secondaryContainer = const Color(0xFFE8DEF8),
        onSecondaryContainer = const Color(0xFF1D192B),
        tertiary = null,
        onTertiary = null,
        tertiaryContainer = null,
        onTertiaryContainer = null,
        surfaceVariant = const Color(0xFFE7E0EC),
        onSurfaceVariant = const Color(0xFF49454F),
        outline = const Color(0xFF79747E),
        shadow = null,
        inverseSurface = null,
        onInverseSurface = null,
        inversePrimary = null;

  /// Create default dark theme colors
  const ThemeColors.defaultDark()
      : primary = const Color(0xFFD0BCFF),
        onPrimary = const Color(0xFF381E72),
        secondary = const Color(0xFFCCC2DC),
        onSecondary = const Color(0xFF332D41),
        surface = const Color(0xFF1C1B1F),
        onSurface = const Color(0xFFE6E1E5),
        background = const Color(0xFF1C1B1F),
        onBackground = const Color(0xFFE6E1E5),
        error = const Color(0xFFFFB4AB),
        onError = const Color(0xFF690005),
        primaryContainer = const Color(0xFF4F378B),
        onPrimaryContainer = const Color(0xFFEADDFF),
        secondaryContainer = const Color(0xFF4A4458),
        onSecondaryContainer = const Color(0xFFE8DEF8),
        tertiary = null,
        onTertiary = null,
        tertiaryContainer = null,
        onTertiaryContainer = null,
        surfaceVariant = const Color(0xFF49454F),
        onSurfaceVariant = const Color(0xFFCAC4D0),
        outline = const Color(0xFF938F99),
        shadow = null,
        inverseSurface = null,
        onInverseSurface = null,
        inversePrimary = null;

  // Core colors (required)
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color surface;
  final Color onSurface;
  final Color background;
  final Color onBackground;
  final Color error;
  final Color onError;

  // Extended colors (optional)
  final Color? primaryContainer;
  final Color? onPrimaryContainer;
  final Color? secondaryContainer;
  final Color? onSecondaryContainer;
  final Color? tertiary;
  final Color? onTertiary;
  final Color? tertiaryContainer;
  final Color? onTertiaryContainer;
  final Color? surfaceVariant;
  final Color? onSurfaceVariant;
  final Color? outline;
  final Color? shadow;
  final Color? inverseSurface;
  final Color? onInverseSurface;
  final Color? inversePrimary;

  /// Convert to Flutter ColorScheme
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: _getBrightness(),
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      surface: surface,
      onSurface: onSurface,
      error: error,
      onError: onError,
      primaryContainer: primaryContainer ?? primary,
      onPrimaryContainer: onPrimaryContainer ?? onPrimary,
      secondaryContainer: secondaryContainer ?? secondary,
      onSecondaryContainer: onSecondaryContainer ?? onSecondary,
      tertiary: tertiary ?? secondary,
      onTertiary: onTertiary ?? onSecondary,
      tertiaryContainer: tertiaryContainer ?? tertiary ?? secondary,
      onTertiaryContainer: onTertiaryContainer ?? onTertiary ?? onSecondary,
      surfaceContainerHighest: surfaceVariant ?? surface,
      onSurfaceVariant: onSurfaceVariant ?? onSurface,
      outline: outline ?? onSurface.withValues(alpha: 0.38),
      shadow: shadow ?? Colors.black,
      inverseSurface: inverseSurface ?? onSurface,
      onInverseSurface: onInverseSurface ?? surface,
      inversePrimary: inversePrimary ?? onPrimary,
    );
  }

  /// Determine brightness based on background color
  Brightness _getBrightness() {
    final luminance = background.computeLuminance();
    return luminance > 0.5 ? Brightness.light : Brightness.dark;
  }

  /// Validate color scheme
  bool get isValid {
    // Check that all required colors are provided
    return true; // All colors are non-null in constructor
  }

  /// Create a copy with modified colors
  ThemeColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? surface,
    Color? onSurface,
    Color? background,
    Color? onBackground,
    Color? error,
    Color? onError,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? shadow,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
  }) {
    return ThemeColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      shadow: shadow ?? this.shadow,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
    );
  }

  @override
  List<Object?> get props => [
        primary,
        onPrimary,
        secondary,
        onSecondary,
        surface,
        onSurface,
        background,
        onBackground,
        error,
        onError,
        primaryContainer,
        onPrimaryContainer,
        secondaryContainer,
        onSecondaryContainer,
        tertiary,
        onTertiary,
        tertiaryContainer,
        onTertiaryContainer,
        surfaceVariant,
        onSurfaceVariant,
        outline,
        shadow,
        inverseSurface,
        onInverseSurface,
        inversePrimary,
      ];
}
