import 'package:flutter/material.dart';

// Note: AppLocalizations import will be added when we restructure the
// l10n layer

/// Extension methods for BuildContext to provide easy access to theme and
/// localization
extension BuildContextExtension on BuildContext {
  /// Get the current theme data
  ThemeData get theme => Theme.of(this);

  /// Get the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get the current text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get the current app localizations
  // TODO(l10n): Uncomment when l10n is properly structured
  // AppLocalizations get l10n => AppLocalizations.of(this);

  /// Get the current locale
  Locale get locale => Localizations.localeOf(this);

  /// Get the current media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get the current screen size
  Size get screenSize => mediaQuery.size;

  /// Get the current screen width
  double get screenWidth => screenSize.width;

  /// Get the current screen height
  double get screenHeight => screenSize.height;

  /// Check if the current orientation is portrait
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Check if the current orientation is landscape
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Check if the current theme is dark
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Check if the current theme is light
  bool get isLightMode => theme.brightness == Brightness.light;

  /// Get the system brightness
  Brightness get systemBrightness => mediaQuery.platformBrightness;

  /// Check if the system is in dark mode
  bool get isSystemDarkMode => systemBrightness == Brightness.dark;

  /// Get the current navigator
  NavigatorState get navigator => Navigator.of(this);

  /// Get the current scaffold messenger
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Get the current focus scope
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Show a snackbar with the given message
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    Color? textColor,
  }) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Show an error snackbar
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
    );
  }

  /// Show a success snackbar
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.primary,
      textColor: colorScheme.onPrimary,
    );
  }

  /// Get padding for safe areas
  EdgeInsets get safePadding => mediaQuery.padding;

  /// Get the top safe area padding
  double get topSafePadding => safePadding.top;

  /// Get the bottom safe area padding
  double get bottomSafePadding => safePadding.bottom;

  /// Get responsive font size based on screen width
  double getResponsiveFontSize(double baseFontSize) {
    // Scale font size based on screen width
    final scaleFactor = screenWidth / 375; // Base width (iPhone SE)
    return baseFontSize * scaleFactor.clamp(0.8, 1.2);
  }

  /// Get responsive spacing based on screen size
  double getResponsiveSpacing(double baseSpacing) {
    // Scale spacing based on screen width
    final scaleFactor = screenWidth / 375; // Base width
    return baseSpacing * scaleFactor.clamp(0.8, 1.2);
  }

  /// Check if the screen is small (width < 600)
  bool get isSmallScreen => screenWidth < 600;

  /// Check if the screen is medium (600 <= width < 1024)
  bool get isMediumScreen => screenWidth >= 600 && screenWidth < 1024;

  /// Check if the screen is large (width >= 1024)
  bool get isLargeScreen => screenWidth >= 1024;

  /// Get the appropriate number of columns for a grid based on screen size
  int getGridColumns({
    int smallScreenColumns = 1,
    int mediumScreenColumns = 2,
    int largeScreenColumns = 3,
  }) {
    if (isSmallScreen) return smallScreenColumns;
    if (isMediumScreen) return mediumScreenColumns;
    return largeScreenColumns;
  }
}
