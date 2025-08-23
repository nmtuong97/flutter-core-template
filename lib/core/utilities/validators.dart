/// Validation utilities for input validation across the application
class Validators {
  /// Validate that a string is not empty
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Validate that a string has a minimum length
  static bool hasMinLength(String? value, int minLength) {
    return value != null && value.length >= minLength;
  }

  /// Validate that a string has a maximum length
  static bool hasMaxLength(String? value, int maxLength) {
    return value != null && value.length <= maxLength;
  }

  /// Validate theme ID format
  static bool isValidThemeId(String? themeId) {
    if (!isNotEmpty(themeId)) return false;

    // Theme ID should be lowercase with underscores or hyphens
    final regex = RegExp(r'^[a-z][a-z0-9_-]*$');
    return regex.hasMatch(themeId!);
  }

  /// Validate locale format (e.g., 'en', 'vi', 'en_US')
  static bool isValidLocale(String? locale) {
    if (!isNotEmpty(locale)) return false;

    // Locale format: language code or language_country
    final regex = RegExp(r'^[a-z]{2}(_[A-Z]{2})?$');
    return regex.hasMatch(locale!);
  }

  /// Validate font size range
  static bool isValidFontSize(double? fontSize) {
    if (fontSize == null) return false;

    // Font size should be between 8 and 72
    return fontSize >= 8.0 && fontSize <= 72.0;
  }

  /// Validate font family name
  static bool isValidFontFamily(String? fontFamily) {
    if (!isNotEmpty(fontFamily)) return false;

    // Font family should not contain special characters except spaces and
    // hyphens
    final regex = RegExp(r'^[a-zA-Z0-9\s-]+$');
    return regex.hasMatch(fontFamily!);
  }

  /// Validate hex color format
  static bool isValidHexColor(String? color) {
    if (!isNotEmpty(color)) return false;

    // Hex color format: #RRGGBB or #AARRGGBB
    final regex = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
    return regex.hasMatch(color!);
  }

  /// Validate that a value is in a list of allowed values
  static bool isInList<T>(T? value, List<T> allowedValues) {
    return value != null && allowedValues.contains(value);
  }

  /// Validate JSON format
  static bool isValidJson(String? jsonString) {
    if (!isNotEmpty(jsonString)) return false;

    try {
      // Check basic JSON structure patterns
      final trimmed = jsonString!.trim();
      return trimmed.startsWith('{') && trimmed.endsWith('}') ||
          trimmed.startsWith('[') && trimmed.endsWith(']');
    } on FormatException {
      return false;
    }
  }

  /// Combine multiple validators with AND logic
  static bool combineAnd(List<bool> validations) {
    return validations.every((validation) => validation);
  }

  /// Combine multiple validators with OR logic
  static bool combineOr(List<bool> validations) {
    return validations.any((validation) => validation);
  }

  /// Get validation error message for theme ID
  static String? getThemeIdError(String? themeId) {
    if (!isNotEmpty(themeId)) {
      return 'Theme ID cannot be empty';
    }
    if (!isValidThemeId(themeId)) {
      return 'Theme ID must contain only lowercase letters, numbers, '
          'underscores, and hyphens';
    }
    return null;
  }

  /// Get validation error message for locale
  static String? getLocaleError(String? locale) {
    if (!isNotEmpty(locale)) {
      return 'Locale cannot be empty';
    }
    if (!isValidLocale(locale)) {
      return 'Locale must be in format "en" or "en_US"';
    }
    return null;
  }

  /// Get validation error message for font size
  static String? getFontSizeError(double? fontSize) {
    if (fontSize == null) {
      return 'Font size cannot be null';
    }
    if (!isValidFontSize(fontSize)) {
      return 'Font size must be between 8 and 72';
    }
    return null;
  }

  /// Get validation error message for font family
  static String? getFontFamilyError(String? fontFamily) {
    if (!isNotEmpty(fontFamily)) {
      return 'Font family cannot be empty';
    }
    if (!isValidFontFamily(fontFamily)) {
      return 'Font family contains invalid characters';
    }
    return null;
  }
}
