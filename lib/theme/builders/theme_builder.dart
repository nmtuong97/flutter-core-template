/// Standard theme builder with fluent interface.
/// This file intentionally uses the fluent/builder pattern where methods
/// return 'this' to enable method chaining, which is the core API design.
library;

// Ignoring avoid_returning_this because this is a fluent builder pattern
// where returning 'this' is essential for method chaining functionality
// ignore_for_file: avoid_returning_this

import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';
import '../extensions/app_theme_extension.dart';
import '../typography/theme_typography.dart';

/// Builder pattern for creating consistent ThemeData across all themes
/// Eliminates code duplication and ensures consistency
class ThemeBuilder {
  ThemeBuilder._();

  /// Create a new theme builder
  factory ThemeBuilder.create() => ThemeBuilder._();
  late ColorScheme _colorScheme;
  late String _fontFamily;
  late ThemeTypography _typography;
  late AppThemeExtension _extension;
  late Brightness _brightness;

  // Optional customizations
  Color? _primaryColor;
  Color? _scaffoldBackgroundColor;
  TextTheme? _customTextTheme;
  AppBarTheme? _customAppBarTheme;
  ElevatedButtonThemeData? _customElevatedButtonTheme;
  OutlinedButtonThemeData? _customOutlinedButtonTheme;
  TextButtonThemeData? _customTextButtonTheme;
  CardThemeData? _customCardTheme;
  IconThemeData? _customIconTheme;
  DividerThemeData? _customDividerTheme;

  /// Set the color scheme for the theme
  ThemeBuilder withColorScheme(ColorScheme colorScheme) {
    _colorScheme = colorScheme;
    _brightness = colorScheme.brightness;
    return this;
  }

  /// Set the font family for the theme
  ThemeBuilder withFontFamily(String fontFamily) {
    _fontFamily = fontFamily;
    return this;
  }

  /// Set the typography configuration
  ThemeBuilder withTypography(ThemeTypography typography) {
    _typography = typography;
    return this;
  }

  /// Set the theme extension
  ThemeBuilder withExtension(AppThemeExtension extension) {
    _extension = extension;
    return this;
  }

  /// Set custom primary color (overrides color scheme)
  ThemeBuilder withPrimaryColor(Color color) {
    _primaryColor = color;
    return this;
  }

  /// Set custom scaffold background color
  ThemeBuilder withScaffoldBackgroundColor(Color color) {
    _scaffoldBackgroundColor = color;
    return this;
  }

  /// Set custom text theme
  ThemeBuilder withTextTheme(TextTheme textTheme) {
    _customTextTheme = textTheme;
    return this;
  }

  /// Set custom app bar theme
  ThemeBuilder withAppBarTheme(AppBarTheme appBarTheme) {
    _customAppBarTheme = appBarTheme;
    return this;
  }

  /// Set custom elevated button theme
  ThemeBuilder withElevatedButtonTheme(ElevatedButtonThemeData buttonTheme) {
    _customElevatedButtonTheme = buttonTheme;
    return this;
  }

  /// Set custom outlined button theme
  ThemeBuilder withOutlinedButtonTheme(OutlinedButtonThemeData buttonTheme) {
    _customOutlinedButtonTheme = buttonTheme;
    return this;
  }

  /// Set custom text button theme
  ThemeBuilder withTextButtonTheme(TextButtonThemeData buttonTheme) {
    _customTextButtonTheme = buttonTheme;
    return this;
  }

  /// Set custom card theme
  ThemeBuilder withCardTheme(CardThemeData cardTheme) {
    _customCardTheme = cardTheme;
    return this;
  }

  /// Set custom icon theme
  ThemeBuilder withIconTheme(IconThemeData iconTheme) {
    _customIconTheme = iconTheme;
    return this;
  }

  /// Set custom divider theme
  ThemeBuilder withDividerTheme(DividerThemeData dividerTheme) {
    _customDividerTheme = dividerTheme;
    return this;
  }

  /// Build the final ThemeData
  ThemeData build() {
    // Validate required fields

    return ThemeData(
      useMaterial3: ThemeConstants.useMaterial3,
      brightness: _brightness,
      primaryColor: _primaryColor ?? _colorScheme.primary,
      scaffoldBackgroundColor: _scaffoldBackgroundColor ?? _colorScheme.surface,
      colorScheme: _colorScheme,

      // Text theme
      textTheme: _customTextTheme ?? _buildTextTheme(),

      // App bar theme
      appBarTheme: _customAppBarTheme ?? _buildAppBarTheme(),

      // Button themes
      elevatedButtonTheme:
          _customElevatedButtonTheme ?? _buildElevatedButtonTheme(),
      outlinedButtonTheme:
          _customOutlinedButtonTheme ?? _buildOutlinedButtonTheme(),
      textButtonTheme: _customTextButtonTheme ?? _buildTextButtonTheme(),

      // Component themes
      cardTheme: _customCardTheme ?? _buildCardTheme(),
      iconTheme: _customIconTheme ?? _buildIconTheme(),
      primaryIconTheme: _buildPrimaryIconTheme(),
      dividerTheme: _customDividerTheme ?? _buildDividerTheme(),

      // Extensions
      extensions: [_extension],

      // Animation duration
      pageTransitionsTheme: _buildPageTransitionsTheme(),
    );
  }

  /// Build default text theme
  TextTheme _buildTextTheme() {
    return _typography.getTextTheme(
      fontFamily: _fontFamily,
      primaryColor: _colorScheme.onSurface,
      secondaryColor: _colorScheme.onSurface
          .withValues(alpha: ThemeConstants.secondaryTextOpacity),
    );
  }

  /// Build default app bar theme
  AppBarTheme _buildAppBarTheme() {
    return AppBarTheme(
      backgroundColor: _colorScheme.surface,
      foregroundColor: _colorScheme.onSurface,
      elevation: ThemeConstants.appBarElevation,
      centerTitle: true,
      titleTextStyle: _typography.getTextStyle(
        fontFamily: _fontFamily,
        fontSize: ThemeConstants.appBarTitleFontSize,
        fontWeight: FontWeight.w600,
        color: _colorScheme.onSurface,
      ),
      iconTheme: IconThemeData(
        color: _colorScheme.onSurface,
        size: ThemeConstants.defaultIconSize,
      ),
    );
  }

  /// Build default elevated button theme
  ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _colorScheme.primary,
        foregroundColor: _colorScheme.onPrimary,
        elevation: ThemeConstants.buttonElevation,
        padding: EdgeInsets.symmetric(
          horizontal: ThemeConstants.buttonPaddingHorizontal,
          vertical: ThemeConstants.buttonPaddingVertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(ThemeConstants.buttonBorderRadius),
        ),
        textStyle: _typography.getTextStyle(
          fontFamily: _fontFamily,
          fontSize: ThemeConstants.buttonFontSize,
          fontWeight: FontWeight.w600,
          color: _colorScheme.onPrimary,
        ),
      ),
    );
  }

  /// Build default outlined button theme
  OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _colorScheme.primary,
        side: BorderSide(
          color: _colorScheme.primary,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ThemeConstants.buttonPaddingHorizontal,
          vertical: ThemeConstants.buttonPaddingVertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(ThemeConstants.buttonBorderRadius),
        ),
        textStyle: _typography.getTextStyle(
          fontFamily: _fontFamily,
          fontSize: ThemeConstants.buttonFontSize,
          fontWeight: FontWeight.w600,
          color: _colorScheme.primary,
        ),
      ),
    );
  }

  /// Build default text button theme
  TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _colorScheme.primary,
        padding: EdgeInsets.symmetric(
          horizontal: ThemeConstants.buttonPaddingHorizontal,
          vertical: ThemeConstants.buttonPaddingVertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(ThemeConstants.buttonBorderRadius),
        ),
        textStyle: _typography.getTextStyle(
          fontFamily: _fontFamily,
          fontSize: ThemeConstants.buttonFontSize,
          fontWeight: FontWeight.w600,
          color: _colorScheme.primary,
        ),
      ),
    );
  }

  /// Build default card theme
  CardThemeData _buildCardTheme() {
    return CardThemeData(
      color: _colorScheme.surface,
      elevation: ThemeConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.cardBorderRadius),
      ),
      margin: EdgeInsets.all(ThemeConstants.cardMargin),
    );
  }

  /// Build default icon theme
  IconThemeData _buildIconTheme() {
    return IconThemeData(
      color: _colorScheme.onSurface,
      size: ThemeConstants.defaultIconSize,
    );
  }

  /// Build primary icon theme
  IconThemeData _buildPrimaryIconTheme() {
    return IconThemeData(
      color: _colorScheme.primary,
      size: ThemeConstants.defaultIconSize,
    );
  }

  /// Build default divider theme
  DividerThemeData _buildDividerTheme() {
    return DividerThemeData(
      color:
          _colorScheme.outline.withValues(alpha: ThemeConstants.dividerOpacity),
      thickness: ThemeConstants.dividerThickness,
      space: ThemeConstants.dividerSpace,
    );
  }

  /// Build page transitions theme
  PageTransitionsTheme _buildPageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      },
    );
  }
}

/// Specialized builders for common theme patterns
class LightThemeBuilder extends ThemeBuilder {
  LightThemeBuilder._() : super._();

  factory LightThemeBuilder.create() => LightThemeBuilder._();

  /// Create a light theme with standard Material 3 colors
  void withMaterial3Colors({
    Color? primaryColor,
    Color? surfaceColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor ?? Colors.blue,
      surface: surfaceColor,
    );
    withColorScheme(colorScheme);
  }
}

class DarkThemeBuilder extends ThemeBuilder {
  DarkThemeBuilder._() : super._();

  factory DarkThemeBuilder.create() => DarkThemeBuilder._();

  /// Create a dark theme with standard Material 3 colors
  void withMaterial3Colors({
    Color? primaryColor,
    Color? surfaceColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor ?? Colors.blue,
      brightness: Brightness.dark,
      surface: surfaceColor,
    );
    withColorScheme(colorScheme);
  }
}

/// Theme builder factory for creating common theme configurations
class ThemeBuilderFactory {
  const ThemeBuilderFactory._();

  /// Create a light theme builder with default configuration
  static LightThemeBuilder light({
    required String fontFamily,
    required ThemeTypography typography,
    Color? primaryColor,
  }) {
    final builder = LightThemeBuilder.create()
      ..withMaterial3Colors(primaryColor: primaryColor)
      ..withFontFamily(fontFamily)
      ..withTypography(typography)
      ..withExtension(AppThemeExtension.light());
    return builder;
  }

  /// Create a dark theme builder with default configuration
  static DarkThemeBuilder dark({
    required String fontFamily,
    required ThemeTypography typography,
    Color? primaryColor,
  }) {
    final builder = DarkThemeBuilder.create()
      ..withMaterial3Colors(primaryColor: primaryColor)
      ..withFontFamily(fontFamily)
      ..withTypography(typography)
      ..withExtension(AppThemeExtension.dark());
    return builder;
  }
}
