import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Domain entity representing a localization configuration
class LocalizationEntity extends Equatable {
  const LocalizationEntity({
    required this.locale,
    required this.languageName,
    required this.countryName,
    this.isDefault = false,
    this.isRtl = false,
  });

  /// Create English localization
  const LocalizationEntity.english()
      : locale = const Locale('en'),
        languageName = 'English',
        countryName = 'United States',
        isDefault = true,
        isRtl = false;

  /// Create Vietnamese localization
  const LocalizationEntity.vietnamese()
      : locale = const Locale('vi'),
        languageName = 'Tiếng Việt',
        countryName = 'Việt Nam',
        isDefault = false,
        isRtl = false;

  /// The locale identifier (e.g., 'en', 'vi', 'en_US')
  final Locale locale;

  /// Human-readable language name in the language itself
  final String languageName;

  /// Human-readable country name
  final String countryName;

  /// Whether this is the default locale
  final bool isDefault;

  /// Whether this is a right-to-left language
  final bool isRtl;

  /// Get language code
  String get languageCode => locale.languageCode;

  /// Get country code
  String? get countryCode => locale.countryCode;

  /// Get locale string representation
  String get localeString => locale.toString();

  /// Create a copy with modified properties
  LocalizationEntity copyWith({
    Locale? locale,
    String? languageName,
    String? countryName,
    bool? isDefault,
    bool? isRtl,
  }) {
    return LocalizationEntity(
      locale: locale ?? this.locale,
      languageName: languageName ?? this.languageName,
      countryName: countryName ?? this.countryName,
      isDefault: isDefault ?? this.isDefault,
      isRtl: isRtl ?? this.isRtl,
    );
  }

  /// Validate localization entity
  bool get isValid {
    return languageName.isNotEmpty && countryName.isNotEmpty;
  }

  @override
  List<Object?> get props => [
        locale,
        languageName,
        countryName,
        isDefault,
        isRtl,
      ];

  @override
  String toString() {
    return 'LocalizationEntity(locale: $locale, language: $languageName)';
  }
}
