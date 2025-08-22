import 'package:flutter/material.dart';

/// Base interface for all theme components
/// Follows Interface Segregation Principle (ISP)
@immutable
abstract class BaseTheme {
  /// Unique ID of the theme, used for storage and identification
  String get id;

  /// Display name of the theme
  String get name;

  /// Short description of the theme
  String get description;

  /// Check if this theme is the default theme
  bool get isDefault => false;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseTheme && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Interface for themes that support light mode
abstract class LightThemeProvider {
  /// Light theme data
  ThemeData get lightThemeData;

  /// Check if light theme is supported
  bool get supportsLightMode => true;
}

/// Interface for themes that support dark mode
abstract class DarkThemeProvider {
  /// Dark theme data
  ThemeData get darkThemeData;

  /// Check if dark theme is supported
  bool get supportsDarkMode => true;
}

/// Interface for themes that support adaptive colors
abstract class AdaptiveThemeProvider {
  /// Get theme data based on system brightness
  ThemeData getAdaptiveThemeData(Brightness brightness);

  /// Check if adaptive theme is supported
  bool get supportsAdaptiveMode => true;
}

/// Interface for themes with custom extensions
abstract class ExtensibleThemeProvider {
  /// Get custom theme extensions
  List<ThemeExtension> get themeExtensions;

  /// Check if theme has custom extensions
  bool get hasCustomExtensions => themeExtensions.isNotEmpty;
}

/// Interface for themes with animation support
abstract class AnimatedThemeProvider {
  /// Animation duration for theme transitions
  Duration get transitionDuration;

  /// Animation curve for theme transitions
  Curve get transitionCurve;

  /// Check if theme supports animations
  bool get supportsAnimations => true;
}

/// Interface for themes with accessibility features
abstract class AccessibleThemeProvider {
  /// High contrast version of the theme
  ThemeData get highContrastThemeData;

  /// Large text version of the theme
  ThemeData get largeTextThemeData;

  /// Check if theme supports accessibility features
  bool get supportsAccessibility => true;
}

/// Comprehensive theme interface that combines all capabilities
/// Themes can implement only the interfaces they need
abstract class AppTheme extends BaseTheme
    implements LightThemeProvider, DarkThemeProvider {
  // Base implementation remains the same for backward compatibility
}

/// Specialized theme for light-only themes
abstract class LightOnlyTheme extends BaseTheme implements LightThemeProvider {
  @override
  bool get supportsLightMode => true;
}

/// Specialized theme for dark-only themes
abstract class DarkOnlyTheme extends BaseTheme implements DarkThemeProvider {
  @override
  bool get supportsDarkMode => true;
}

/// Full-featured theme with all capabilities
abstract class AdvancedTheme extends BaseTheme
    implements
        LightThemeProvider,
        DarkThemeProvider,
        AdaptiveThemeProvider,
        ExtensibleThemeProvider,
        AnimatedThemeProvider,
        AccessibleThemeProvider {
  @override
  ThemeData getAdaptiveThemeData(Brightness brightness) {
    return brightness == Brightness.light ? lightThemeData : darkThemeData;
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Curve get transitionCurve => Curves.easeInOut;

  @override
  List<ThemeExtension> get themeExtensions => [];

  @override
  ThemeData get highContrastThemeData => lightThemeData;

  @override
  ThemeData get largeTextThemeData => lightThemeData;
}

/// Theme capability checker utility
class ThemeCapabilities {
  const ThemeCapabilities(this.theme);

  final BaseTheme theme;

  bool get canProvideLightTheme => theme is LightThemeProvider;
  bool get canProvideDarkTheme => theme is DarkThemeProvider;
  bool get canProvideAdaptiveTheme => theme is AdaptiveThemeProvider;
  bool get hasCustomExtensions => theme is ExtensibleThemeProvider;
  bool get supportsAnimations => theme is AnimatedThemeProvider;
  bool get supportsAccessibility => theme is AccessibleThemeProvider;

  /// Get available theme modes
  List<ThemeMode> get availableThemeModes {
    final modes = <ThemeMode>[];
    if (canProvideLightTheme) modes.add(ThemeMode.light);
    if (canProvideDarkTheme) modes.add(ThemeMode.dark);
    if (canProvideLightTheme && canProvideDarkTheme) {
      modes.add(ThemeMode.system);
    }
    return modes;
  }

  /// Check if theme supports specific mode
  bool supportsThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return canProvideLightTheme;
      case ThemeMode.dark:
        return canProvideDarkTheme;
      case ThemeMode.system:
        return canProvideLightTheme && canProvideDarkTheme;
    }
  }
}
