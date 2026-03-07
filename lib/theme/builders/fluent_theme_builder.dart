/// Theme builder with fluent interface.
/// This file intentionally uses the fluent/builder pattern where methods
/// return 'this' to enable method chaining, which is the core API design.
library;

// Ignoring avoid_returning_this because this is a fluent builder pattern
// where returning 'this' is essential for method chaining functionality
// ignore_for_file: avoid_returning_this

import 'package:flutter/material.dart';
import '../base/app_theme.dart';
import '../utilities/theme_standardization.dart';

/// Fluent builder pattern for creating themes with method chaining
/// Provides a more intuitive and flexible way to customize themes
class FluentThemeBuilder {
  FluentThemeBuilder(this._id, this._name);

  /// Factory constructor for quick theme creation
  factory FluentThemeBuilder.create(String id, String name) {
    return FluentThemeBuilder(id, name);
  }
  late String _id;
  late String _name;
  String? _description;
  bool _supportsLightMode = true;
  bool _supportsDarkMode = true;

  // Color configuration
  Color? _primaryColor;
  Color? _secondaryColor;
  Color? _surfaceColor;
  Color? _errorColor;

  // Text configuration
  String? _fontFamily;
  double? _baseFontSize;
  Color? _primaryTextColor;
  Color? _secondaryTextColor;

  // Component styling
  double? _borderRadius;
  EdgeInsets? _buttonPadding;
  double? _elevation;

  /// Set theme description
  FluentThemeBuilder withDescription(String description) {
    _description = description;
    return this;
  }

  /// Configure theme mode support
  FluentThemeBuilder withModeSupport({
    bool light = true,
    bool dark = true,
  }) {
    _supportsLightMode = light;
    _supportsDarkMode = dark;
    return this;
  }

  /// Set primary color scheme
  FluentThemeBuilder withPrimaryColors({
    required Color primary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? error,
  }) {
    _primaryColor = primary;
    _secondaryColor = secondary;
    _surfaceColor = surface;
    _errorColor = error;
    return this;
  }

  /// Set typography configuration
  FluentThemeBuilder withTypography({
    String? fontFamily,
    double? baseFontSize,
    Color? primaryTextColor,
    Color? secondaryTextColor,
  }) {
    _fontFamily = fontFamily;
    _baseFontSize = baseFontSize;
    _primaryTextColor = primaryTextColor;
    _secondaryTextColor = secondaryTextColor;
    return this;
  }

  /// Configure advanced text styling
  FluentThemeBuilder withTextStyling({
    double? letterSpacing,
  }) {
    // letterSpacing functionality preserved for method chaining
    return this;
  }

  /// Set component styling
  FluentThemeBuilder withComponentStyling({
    double? borderRadius,
    EdgeInsets? buttonPadding,
    double? elevation,
  }) {
    _borderRadius = borderRadius;
    _buttonPadding = buttonPadding;
    _elevation = elevation;
    return this;
  }

  /// Apply predefined color palette
  FluentThemeBuilder withColorPalette(ThemeColorPalette palette) {
    switch (palette) {
      case ThemeColorPalette.material:
        withPrimaryColors(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
          background: Colors.white,
          surface: Colors.grey[50],
          error: Colors.red,
        );
      case ThemeColorPalette.cupertino:
        withPrimaryColors(
          primary: Colors.blue,
          secondary: Colors.blue[300],
          background: Colors.white,
          surface: Colors.grey[100],
          error: Colors.red,
        );
      case ThemeColorPalette.dark:
        withPrimaryColors(
          primary: Colors.blue[300]!,
          secondary: Colors.blue[200],
          background: Colors.grey[900],
          surface: Colors.grey[800],
          error: Colors.red[300],
        );
      case ThemeColorPalette.monochrome:
        withPrimaryColors(
          primary: Colors.black,
          secondary: Colors.grey[600],
          background: Colors.white,
          surface: Colors.grey[50],
          error: Colors.red,
        );
    }
    return this;
  }

  /// Apply predefined typography style
  FluentThemeBuilder withTypographyStyle(TypographyStyle style) {
    switch (style) {
      case TypographyStyle.modern:
        withTypography(
          fontFamily: 'Roboto',
          baseFontSize: 14,
        );
        withTextStyling(
          letterSpacing: 0.25,
        );
      case TypographyStyle.classic:
        withTypography(
          fontFamily: 'Times New Roman',
          baseFontSize: 16,
        );
        withTextStyling(
          letterSpacing: 0,
        );
      case TypographyStyle.minimal:
        withTypography(
          fontFamily: 'Helvetica',
          baseFontSize: 13,
        );
        withTextStyling(
          letterSpacing: 0.5,
        );
      case TypographyStyle.playful:
        withTypography(
          fontFamily: 'Comic Sans MS',
          baseFontSize: 15,
        );
        withTextStyling(
          letterSpacing: 0.3,
        );
    }
    return this;
  }

  /// Build the final theme data
  ThemeData build({bool isDark = false}) {
    // Use standardized theme creation
    final colorScheme =
        isDark ? _buildDarkColorScheme() : _buildLightColorScheme();

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      fontFamily: _fontFamily ?? 'Roboto',
      textTheme: ThemeStandardization.standardTextTheme(
        fontFamily: _fontFamily ?? 'Roboto',
        baseFontSize: _baseFontSize ?? 14.0,
        primaryTextColor:
            _primaryTextColor ?? (isDark ? Colors.white : Colors.black),
        secondaryTextColor: _secondaryTextColor ??
            (isDark ? Colors.grey[300]! : Colors.grey[600]!),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: _elevation ?? 0,
        titleTextStyle: ThemeStandardization.standardTextStyle(
          fontFamily: _fontFamily ?? 'Roboto',
          fontSize: (_baseFontSize ?? 14.0) + 4,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: _buttonPadding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius ?? 8),
          ),
          elevation: _elevation ?? 2,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: _elevation ?? 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius ?? 12),
        ),
      ),
    );
  }

  /// Build a custom AppTheme instance
  CustomFluentTheme buildCustomTheme() {
    return CustomFluentTheme(
      id: _id,
      name: _name,
      description:
          _description ?? 'Custom theme created with FluentThemeBuilder',
      supportsLightMode: _supportsLightMode,
      supportsDarkMode: _supportsDarkMode,
      builder: this,
    );
  }

  ColorScheme _buildLightColorScheme() {
    return ColorScheme.light(
      primary: _primaryColor ?? Colors.blue,
      secondary: _secondaryColor ?? Colors.blueAccent,
      surface: _surfaceColor ?? Colors.grey[50]!,
      error: _errorColor ?? Colors.red,
    );
  }

  ColorScheme _buildDarkColorScheme() {
    return ColorScheme.dark(
      primary: _primaryColor ?? Colors.blue[300]!,
      secondary: _secondaryColor ?? Colors.blue[200]!,
      surface: _surfaceColor ?? Colors.grey[800]!,
      error: _errorColor ?? Colors.red[300]!,
    );
  }
}

/// Predefined color palettes for quick theme creation
enum ThemeColorPalette {
  material,
  cupertino,
  dark,
  monochrome,
}

/// Predefined typography styles
enum TypographyStyle {
  modern,
  classic,
  minimal,
  playful,
}

/// Custom theme implementation using FluentThemeBuilder
class CustomFluentTheme extends AppTheme {
  CustomFluentTheme({
    required String id,
    required String name,
    required String description,
    required bool supportsLightMode,
    required bool supportsDarkMode,
    required this.builder,
  })  : _id = id,
        _name = name,
        _description = description,
        _supportsLightMode = supportsLightMode,
        _supportsDarkMode = supportsDarkMode;
  final FluentThemeBuilder builder;
  final String _id;
  final String _name;
  final String _description;
  final bool _supportsLightMode;
  final bool _supportsDarkMode;

  @override
  String get id => _id;

  @override
  String get name => _name;

  @override
  String get description => _description;

  @override
  bool get supportsLightMode => _supportsLightMode;

  @override
  bool get supportsDarkMode => _supportsDarkMode;

  @override
  ThemeData get lightThemeData => builder.build();

  @override
  ThemeData get darkThemeData => builder.build(isDark: true);
}

/// Extension methods for additional fluent operations
extension FluentThemeBuilderExtensions on FluentThemeBuilder {
  /// Quick method to create a light theme variant
  FluentThemeBuilder asLightTheme() {
    withModeSupport(dark: false);
    return this;
  }

  /// Quick method to create a dark theme variant
  FluentThemeBuilder asDarkTheme() {
    withModeSupport(light: false);
    return this;
  }

  /// Apply Material Design 3 defaults
  FluentThemeBuilder withMaterial3Defaults() {
    withColorPalette(ThemeColorPalette.material);
    withTypographyStyle(TypographyStyle.modern);
    withComponentStyling(
      borderRadius: 12,
      elevation: 1,
    );
    return this;
  }

  /// Apply minimalist design principles
  FluentThemeBuilder withMinimalistDesign() {
    withTypographyStyle(TypographyStyle.minimal);
    withComponentStyling(
      borderRadius: 4,
      elevation: 0,
      buttonPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
    return this;
  }
}
