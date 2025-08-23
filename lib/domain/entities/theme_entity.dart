import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../value_objects/theme_colors.dart';
import '../value_objects/theme_typography.dart';

/// Domain entity representing a theme configuration
class ThemeEntity extends Equatable {
  const ThemeEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.lightColors,
    required this.darkColors,
    required this.typography,
    this.isDefault = false,
    this.isCustom = false,
    this.previewImagePath,
    this.tags = const [],
  });

  /// Create default theme entity
  const ThemeEntity.createDefault()
      : id = 'default',
        name = 'Default',
        description = 'Default application theme',
        lightColors = const ThemeColors.defaultLight(),
        darkColors = const ThemeColors.defaultDark(),
        typography = const ThemeTypography.defaultTypography(),
        isDefault = true,
        isCustom = false,
        previewImagePath = null,
        tags = const [];

  /// Unique identifier for the theme
  final String id;

  /// Display name of the theme
  final String name;

  /// Description of the theme
  final String description;

  /// Light mode color scheme
  final ThemeColors lightColors;

  /// Dark mode color scheme
  final ThemeColors darkColors;

  /// Typography configuration
  final ThemeTypography typography;

  /// Whether this is the default theme
  final bool isDefault;

  /// Whether this is a custom user-created theme
  final bool isCustom;

  /// Optional preview image path
  final String? previewImagePath;

  /// Tags for categorizing themes
  final List<String> tags;

  /// Get colors for specific theme mode
  ThemeColors getColors(ThemeMode mode, Brightness systemBrightness) {
    switch (mode) {
      case ThemeMode.light:
        return lightColors;
      case ThemeMode.dark:
        return darkColors;
      case ThemeMode.system:
        return systemBrightness == Brightness.dark ? darkColors : lightColors;
    }
  }

  /// Create a copy with modified properties
  ThemeEntity copyWith({
    String? id,
    String? name,
    String? description,
    ThemeColors? lightColors,
    ThemeColors? darkColors,
    ThemeTypography? typography,
    bool? isDefault,
    bool? isCustom,
    String? previewImagePath,
    List<String>? tags,
  }) {
    return ThemeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      lightColors: lightColors ?? this.lightColors,
      darkColors: darkColors ?? this.darkColors,
      typography: typography ?? this.typography,
      isDefault: isDefault ?? this.isDefault,
      isCustom: isCustom ?? this.isCustom,
      previewImagePath: previewImagePath ?? this.previewImagePath,
      tags: tags ?? this.tags,
    );
  }

  /// Validate theme entity
  bool get isValid {
    return id.isNotEmpty &&
        name.isNotEmpty &&
        description.isNotEmpty &&
        lightColors.isValid &&
        darkColors.isValid &&
        typography.isValid;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        lightColors,
        darkColors,
        typography,
        isDefault,
        isCustom,
        previewImagePath,
        tags,
      ];

  @override
  String toString() {
    return 'ThemeEntity(id: $id, name: $name, isDefault: $isDefault)';
  }
}
