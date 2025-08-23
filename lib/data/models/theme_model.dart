import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/theme_entity.dart';
import '../../domain/value_objects/theme_colors.dart';
import '../../domain/value_objects/theme_typography.dart';

part 'theme_model.g.dart';

/// Data model for theme with JSON serialization
@JsonSerializable()
class ThemeModel extends Equatable {
  const ThemeModel({
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

  /// Convert from domain entity
  factory ThemeModel.fromEntity(ThemeEntity entity) {
    return ThemeModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      lightColors: ThemeColorsModel.fromValueObject(entity.lightColors),
      darkColors: ThemeColorsModel.fromValueObject(entity.darkColors),
      typography: ThemeTypographyModel.fromValueObject(entity.typography),
      isDefault: entity.isDefault,
      isCustom: entity.isCustom,
      previewImagePath: entity.previewImagePath,
      tags: entity.tags,
    );
  }

  /// JSON serialization
  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);

  final String id;
  final String name;
  final String description;
  final ThemeColorsModel lightColors;
  final ThemeColorsModel darkColors;
  final ThemeTypographyModel typography;
  final bool isDefault;
  final bool isCustom;
  final String? previewImagePath;
  final List<String> tags;

  /// Convert to domain entity
  ThemeEntity toEntity() {
    return ThemeEntity(
      id: id,
      name: name,
      description: description,
      lightColors: lightColors.toValueObject(),
      darkColors: darkColors.toValueObject(),
      typography: typography.toValueObject(),
      isDefault: isDefault,
      isCustom: isCustom,
      previewImagePath: previewImagePath,
      tags: tags,
    );
  }

  Map<String, dynamic> toJson() => _$ThemeModelToJson(this);

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
}

/// Data model for theme colors
@JsonSerializable()
class ThemeColorsModel extends Equatable {
  const ThemeColorsModel({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.onBackground,
    required this.error,
    required this.onError,
    this.primaryContainer,
    this.onPrimaryContainer,
    this.secondaryContainer,
    this.onSecondaryContainer,
    this.tertiary,
    this.onTertiary,
    this.tertiaryContainer,
    this.onTertiaryContainer,
    this.surfaceVariant,
    this.onSurfaceVariant,
    this.outline,
    this.shadow,
    this.inverseSurface,
    this.onInverseSurface,
    this.inversePrimary,
  });

  /// Convert from value object
  factory ThemeColorsModel.fromValueObject(ThemeColors colors) {
    return ThemeColorsModel(
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      surface: colors.surface,
      onSurface: colors.onSurface,
      background: colors.background,
      onBackground: colors.onBackground,
      error: colors.error,
      onError: colors.onError,
      primaryContainer: colors.primaryContainer,
      onPrimaryContainer: colors.onPrimaryContainer,
      secondaryContainer: colors.secondaryContainer,
      onSecondaryContainer: colors.onSecondaryContainer,
      tertiary: colors.tertiary,
      onTertiary: colors.onTertiary,
      tertiaryContainer: colors.tertiaryContainer,
      onTertiaryContainer: colors.onTertiaryContainer,
      surfaceVariant: colors.surfaceVariant,
      onSurfaceVariant: colors.onSurfaceVariant,
      outline: colors.outline,
      shadow: colors.shadow,
      inverseSurface: colors.inverseSurface,
      onInverseSurface: colors.onInverseSurface,
      inversePrimary: colors.inversePrimary,
    );
  }

  /// JSON serialization
  factory ThemeColorsModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeColorsModelFromJson(json);

  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color primary;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color onPrimary;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color secondary;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color onSecondary;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color surface;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color onSurface;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color background;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color onBackground;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color error;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color onError;

  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? primaryContainer;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? onPrimaryContainer;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? secondaryContainer;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? onSecondaryContainer;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? tertiary;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? onTertiary;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? tertiaryContainer;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? onTertiaryContainer;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? surfaceVariant;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? onSurfaceVariant;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? outline;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? shadow;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? inverseSurface;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? onInverseSurface;
  @JsonKey(fromJson: _colorFromJsonNullable, toJson: _colorToJsonNullable)
  final Color? inversePrimary;

  /// Convert to value object
  ThemeColors toValueObject() {
    return ThemeColors(
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      surface: surface,
      onSurface: onSurface,
      background: background,
      onBackground: onBackground,
      error: error,
      onError: onError,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      shadow: shadow,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
    );
  }

  Map<String, dynamic> toJson() => _$ThemeColorsModelToJson(this);

  @override
  List<Object?> get props => [
        primary,
        onPrimary,
        secondary,
        onSecondary,
        surface,
        onSurface,
        background,
        onBackground,
        error,
        onError,
        primaryContainer,
        onPrimaryContainer,
        secondaryContainer,
        onSecondaryContainer,
        tertiary,
        onTertiary,
        tertiaryContainer,
        onTertiaryContainer,
        surfaceVariant,
        onSurfaceVariant,
        outline,
        shadow,
        inverseSurface,
        onInverseSurface,
        inversePrimary,
      ];
}

/// Data model for theme typography
@JsonSerializable()
class ThemeTypographyModel extends Equatable {
  const ThemeTypographyModel({
    required this.fontFamily,
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  /// Convert from value object
  factory ThemeTypographyModel.fromValueObject(ThemeTypography typography) {
    return ThemeTypographyModel(
      fontFamily: typography.fontFamily,
      displayLarge: typography.displayLarge,
      displayMedium: typography.displayMedium,
      displaySmall: typography.displaySmall,
      headlineLarge: typography.headlineLarge,
      headlineMedium: typography.headlineMedium,
      headlineSmall: typography.headlineSmall,
      titleLarge: typography.titleLarge,
      titleMedium: typography.titleMedium,
      titleSmall: typography.titleSmall,
      bodyLarge: typography.bodyLarge,
      bodyMedium: typography.bodyMedium,
      bodySmall: typography.bodySmall,
      labelLarge: typography.labelLarge,
      labelMedium: typography.labelMedium,
      labelSmall: typography.labelSmall,
    );
  }

  /// JSON serialization
  factory ThemeTypographyModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeTypographyModelFromJson(json);

  final String fontFamily;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle displayLarge;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle displayMedium;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle displaySmall;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle headlineLarge;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle headlineMedium;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle headlineSmall;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle titleLarge;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle titleMedium;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle titleSmall;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle bodyLarge;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle bodyMedium;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle bodySmall;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle labelLarge;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle labelMedium;
  @JsonKey(fromJson: _textStyleFromJson, toJson: _textStyleToJson)
  final TextStyle labelSmall;

  /// Convert to value object
  ThemeTypography toValueObject() {
    return ThemeTypography(
      fontFamily: fontFamily,
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  Map<String, dynamic> toJson() => _$ThemeTypographyModelToJson(this);

  @override
  List<Object?> get props => [
        fontFamily,
        displayLarge,
        displayMedium,
        displaySmall,
        headlineLarge,
        headlineMedium,
        headlineSmall,
        titleLarge,
        titleMedium,
        titleSmall,
        bodyLarge,
        bodyMedium,
        bodySmall,
        labelLarge,
        labelMedium,
        labelSmall,
      ];
}

// Color JSON converters
Color _colorFromJson(int value) => Color(value);
int _colorToJson(Color color) => color.toARGB32();

Color? _colorFromJsonNullable(int? value) =>
    value != null ? Color(value) : null;
int? _colorToJsonNullable(Color? color) => color?.toARGB32();

// TextStyle JSON converters
TextStyle _textStyleFromJson(Map<String, dynamic> json) {
  return TextStyle(
    fontFamily: json['fontFamily'] as String?,
    fontSize: (json['fontSize'] as num?)?.toDouble(),
    fontWeight: json['fontWeight'] != null
        ? FontWeight.values[json['fontWeight'] as int]
        : null,
    height: (json['height'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _textStyleToJson(TextStyle style) {
  return {
    'fontFamily': style.fontFamily,
    'fontSize': style.fontSize,
    'fontWeight': style.fontWeight?.index,
    'height': style.height,
  };
}
