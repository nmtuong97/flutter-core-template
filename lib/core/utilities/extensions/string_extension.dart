/// Extension methods for String to provide useful utility functions
extension StringExtension on String {
  /// Capitalize the first letter of the string
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Convert string to title case (first letter of each word capitalized)
  String get titleCase {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isEmpty ? word : word.capitalized)
        .join(' ');
  }

  /// Convert camelCase or PascalCase to snake_case
  String get toSnakeCase {
    return replaceAllMapped(
      RegExp('([A-Z])'),
      (match) => '_${match.group(1)!.toLowerCase()}',
    ).replaceFirst(RegExp('^_'), '');
  }

  /// Convert snake_case to camelCase
  String get toCamelCase {
    final parts = split('_');
    if (parts.length <= 1) return this;

    return parts.first + parts.skip(1).map((part) => part.capitalized).join();
  }

  /// Convert string to kebab-case
  String get toKebabCase {
    return replaceAllMapped(
      RegExp('([A-Z])'),
      (match) => '-${match.group(1)!.toLowerCase()}',
    ).replaceFirst(RegExp('^-'), '');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string contains only numbers
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  /// Check if string is a valid URL
  bool get isValidUrl {
    try {
      final uri = Uri.parse(this);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } on FormatException {
      return false;
    }
  }

  /// Remove all whitespace from string
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Truncate string to specified length with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Get initials from a full name
  String get initials {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';

    if (words.length == 1) {
      return words.first.isNotEmpty ? words.first[0].toUpperCase() : '';
    }

    return words
        .take(2)
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join();
  }

  /// Replace multiple consecutive spaces with single space
  String get normalizeSpaces {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Check if string is null or empty
  bool get isNullOrEmpty {
    return isEmpty;
  }

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  /// Convert string to Color (for hex colors)
  int? get toColor {
    var hexColor = this;

    // Remove # if present
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    // Add alpha if not present
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    // Parse hex to int
    return int.tryParse(hexColor, radix: 16);
  }

  /// Mask string for sensitive data (e.g., email, phone)
  String mask({
    int visibleStart = 2,
    int visibleEnd = 2,
    String maskChar = '*',
  }) {
    if (length <= visibleStart + visibleEnd) {
      return this;
    }

    final start = substring(0, visibleStart);
    final end = substring(length - visibleEnd);
    final maskLength = length - visibleStart - visibleEnd;
    final mask = maskChar * maskLength;

    return '$start$mask$end';
  }

  /// Convert string to slug (URL-friendly format)
  String get toSlug {
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove special characters
        .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
        .replaceAll(RegExp('-+'), '-') // Replace multiple hyphens with single
        .replaceAll(RegExp(r'^-|-$'), ''); // Remove leading/trailing hyphens
  }

  /// Count words in string
  int get wordCount {
    if (trim().isEmpty) return 0;
    return trim().split(RegExp(r'\s+')).length;
  }

  /// Get the file extension from a filename/path
  String get fileExtension {
    final lastDot = lastIndexOf('.');
    if (lastDot == -1 || lastDot == length - 1) return '';
    return substring(lastDot + 1).toLowerCase();
  }

  /// Check if string represents a boolean value
  bool? get toBool {
    final lowerCase = toLowerCase();
    if (lowerCase == 'true' || lowerCase == '1' || lowerCase == 'yes') {
      return true;
    }
    if (lowerCase == 'false' || lowerCase == '0' || lowerCase == 'no') {
      return false;
    }
    return null;
  }
}

/// Extension for nullable strings
extension NullableStringExtension on String? {
  /// Check if string is null or empty
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  /// Get string value or default if null
  String orDefault(String defaultValue) {
    return this ?? defaultValue;
  }
}
