/// Application-wide constants for configuration
///
/// This class contains all magic values and configuration constants
/// to avoid hardcoding throughout the application.
class AppConstants {
  AppConstants._(); // Private constructor to prevent instantiation

  // ========== Theme Configuration ==========

  /// Default theme ID when no preference is saved
  static const String defaultThemeId = 'default';

  /// Key for storing theme ID in SharedPreferences
  static const String themeIdKey = 'theme_id';

  /// Key for storing theme mode in SharedPreferences
  static const String themeModeKey = 'theme_mode';

  // ========== Font Size Configuration ==========

  /// Default font size for body text (in logical pixels)
  static const double defaultFontSize = 14.0;

  /// Minimum allowed font size
  static const double minFontSize = 10.0;

  /// Maximum allowed font size
  static const double maxFontSize = 30.0;

  /// Step size for font size adjustments
  static const double fontSizeStep = 1.0;

  /// Key for storing font size in SharedPreferences
  static const String fontSizeKey = 'font_size';

  // ========== Font Family Configuration ==========

  /// Default font family
  static const String defaultFontFamily = 'Roboto';

  /// List of supported font families
  static const List<String> supportedFontFamilies = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Poppins',
    'Inter',
  ];

  /// Key for storing font family in SharedPreferences
  static const String fontFamilyKey = 'font_family';

  // ========== Localization Configuration ==========

  /// Default locale code
  static const String defaultLocaleCode = 'en';

  /// Key for storing locale in SharedPreferences
  static const String localeKey = 'locale';

  // ========== Validation Messages ==========

  /// Error message for invalid font size
  static String invalidFontSizeMessage(double size) =>
      'Font size must be between $minFontSize and $maxFontSize';

  /// Error message for unsupported font family
  static String unsupportedFontFamilyMessage(String family) =>
      'Font family "$family" is not supported. '
      'Supported families: ${supportedFontFamilies.join(", ")}';
}
