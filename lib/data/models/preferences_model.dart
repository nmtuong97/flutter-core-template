import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Data model for user preferences
class PreferencesModel extends Equatable {
  const PreferencesModel({
    required this.themeId,
    required this.themeMode,
    required this.fontSize,
    required this.fontFamily,
    required this.locale,
    this.lastUpdated,
  });

  /// Create default preferences
  factory PreferencesModel.defaultPreferences() {
    return PreferencesModel(
      themeId: 'default',
      themeMode: ThemeMode.system,
      fontSize: 14,
      fontFamily: 'Roboto',
      locale: 'en',
      lastUpdated: DateTime.now(),
    );
  }

  /// JSON serialization
  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    return PreferencesModel(
      themeId: json['themeId'] as String? ?? 'default',
      themeMode: _themeModeFromJson(json['themeMode'] as String? ?? 'system'),
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 14.0,
      fontFamily: json['fontFamily'] as String? ?? 'Roboto',
      locale: json['locale'] as String? ?? 'en',
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : null,
    );
  }

  final String themeId;
  final ThemeMode themeMode;
  final double fontSize;
  final String fontFamily;
  final String locale;
  final DateTime? lastUpdated;

  /// Create a copy with modified properties
  PreferencesModel copyWith({
    String? themeId,
    ThemeMode? themeMode,
    double? fontSize,
    String? fontFamily,
    String? locale,
    DateTime? lastUpdated,
  }) {
    return PreferencesModel(
      themeId: themeId ?? this.themeId,
      themeMode: themeMode ?? this.themeMode,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      locale: locale ?? this.locale,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Update last modified timestamp
  PreferencesModel touch() {
    return copyWith(lastUpdated: DateTime.now());
  }

  Map<String, dynamic> toJson() {
    return {
      'themeId': themeId,
      'themeMode': _themeModeToJson(themeMode),
      'fontSize': fontSize,
      'fontFamily': fontFamily,
      'locale': locale,
      if (lastUpdated != null) 'lastUpdated': lastUpdated!.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        themeId,
        themeMode,
        fontSize,
        fontFamily,
        locale,
        lastUpdated,
      ];
}

// ThemeMode JSON converters
ThemeMode _themeModeFromJson(String value) {
  switch (value) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    case 'system':
    default:
      return ThemeMode.system;
  }
}

String _themeModeToJson(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return 'light';
    case ThemeMode.dark:
      return 'dark';
    case ThemeMode.system:
      return 'system';
  }
}
