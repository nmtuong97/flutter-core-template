/// Application-wide constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  /// Application metadata
  static const String appName = 'Flutter Theme Showcase';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'A Flutter theme showcase app with Clean Architecture';

  /// Storage keys
  static const String themeIdKey = 'theme_id';
  static const String themeModeKey = 'theme_mode';
  static const String fontSizeKey = 'font_size';
  static const String fontFamilyKey = 'font_family';
  static const String localeKey = 'locale';

  /// Default values
  static const String defaultThemeId = 'default';
  static const String defaultLocale = 'en';
  static const double defaultFontSize = 14;
  static const String defaultFontFamily = 'Roboto';

  /// Theme mode values
  static const String lightThemeMode = 'light';
  static const String darkThemeMode = 'dark';
  static const String systemThemeMode = 'system';

  /// Font size presets
  static const double smallFontSize = 12;
  static const double normalFontSize = 14;
  static const double largeFontSize = 16;
  static const double extraLargeFontSize = 18;

  /// Animation durations
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  /// Theme transition durations
  static const Duration themeTransitionDuration = Duration(milliseconds: 200);

  /// Cache limits
  static const int maxThemeCacheSize = 5;
  static const Duration cacheExpiration = Duration(hours: 24);

  /// Validation limits
  static const int maxThemeIdLength = 50;
  static const int maxFontFamilyLength = 100;
  static const double minFontSize = 8;
  static const double maxFontSize = 72;

  /// Supported locales
  static const List<String> supportedLocales = ['en', 'vi'];

  /// Available theme IDs
  static const List<String> availableThemeIds = [
    'default',
    'cyberpunk',
    'glassmorphism',
    'neumorphism',
    'night_sky',
    'organic_natural',
    'retro_vintage',
    'exaggerated_minimalism',
  ];

  /// Available font families
  static const List<String> availableFontFamilies = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Source Sans Pro',
    'Raleway',
    'PT Sans',
    'Lora',
  ];

  /// Error messages
  static const String unknownError = 'An unknown error occurred';
  static const String networkError = 'Network connection error';
  static const String cacheError = 'Cache operation failed';
  static const String validationError = 'Validation failed';
  static const String themeNotFoundError = 'Theme not found';
  static const String localeNotSupportedError = 'Locale not supported';

  /// Success messages
  static const String themeChangedSuccess = 'Theme changed successfully';
  static const String localeChangedSuccess = 'Language changed successfully';
  static const String settingsSavedSuccess = 'Settings saved successfully';

  /// Feature flags
  static const bool enableThemePreloading = true;
  static const bool enablePerformanceMonitoring = true;
  static const bool enableDetailedLogging = true;
  static const bool enableThemeValidation = true;

  /// Performance thresholds
  static const Duration maxThemeSwitchDuration = Duration(milliseconds: 100);
  static const Duration maxAppStartupDuration = Duration(seconds: 2);
  static const int maxMemoryUsageMB = 50;

  /// API endpoints (for future use)
  static const String baseUrl = 'https://api.example.com';
  static const String themesEndpoint = '/themes';
  static const String localizationEndpoint = '/localization';

  /// File paths
  static const String themesPath = 'assets/themes/';
  static const String localizationPath = 'assets/l10n/';
  static const String fontsPath = 'assets/fonts/';
}
