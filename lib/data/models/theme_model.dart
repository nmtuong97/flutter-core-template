import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/theme_entity.dart';
import '../../domain/value_objects/theme_colors.dart';
import '../../domain/value_objects/theme_typography.dart';

/// Data model for theme with JSON serialization
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
  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      lightColors: ThemeColorsModel.fromJson(
        json['lightColors'] as Map<String, dynamic>,
      ),
      darkColors: ThemeColorsModel.fromJson(
        json['darkColors'] as Map<String, dynamic>,
      ),
      typography: ThemeTypographyModel.fromJson(
        json['typography'] as Map<String, dynamic>,
      ),
      isDefault: json['isDefault'] as bool? ?? false,
      isCustom: json['isCustom'] as bool? ?? false,
      previewImagePath: json['previewImagePath'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? const [],
    );
  }

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'lightColors': lightColors.toJson(),
      'darkColors': darkColors.toJson(),
      'typography': typography.toJson(),
      'isDefault': isDefault,
      'isCustom': isCustom,
      if (previewImagePath != null) 'previewImagePath': previewImagePath,
      'tags': tags,
    };
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
}

/// Data model for theme colors
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
  factory ThemeColorsModel.fromJson(Map<String, dynamic> json) {
    return ThemeColorsModel(
      primary: _colorFromJson(json['primary'] as int),
      onPrimary: _colorFromJson(json['onPrimary'] as int),
      secondary: _colorFromJson(json['secondary'] as int),
      onSecondary: _colorFromJson(json['onSecondary'] as int),
      surface: _colorFromJson(json['surface'] as int),
      onSurface: _colorFromJson(json['onSurface'] as int),
      background: _colorFromJson(json['background'] as int),
      onBackground: _colorFromJson(json['onBackground'] as int),
      error: _colorFromJson(json['error'] as int),
      onError: _colorFromJson(json['onError'] as int),
      primaryContainer:
          _colorFromJsonNullable(json['primaryContainer'] as int?),
      onPrimaryContainer:
          _colorFromJsonNullable(json['onPrimaryContainer'] as int?),
      secondaryContainer:
          _colorFromJsonNullable(json['secondaryContainer'] as int?),
      onSecondaryContainer:
          _colorFromJsonNullable(json['onSecondaryContainer'] as int?),
      tertiary: _colorFromJsonNullable(json['tertiary'] as int?),
      onTertiary: _colorFromJsonNullable(json['onTertiary'] as int?),
      tertiaryContainer:
          _colorFromJsonNullable(json['tertiaryContainer'] as int?),
      onTertiaryContainer:
          _colorFromJsonNullable(json['onTertiaryContainer'] as int?),
      surfaceVariant: _colorFromJsonNullable(json['surfaceVariant'] as int?),
      onSurfaceVariant:
          _colorFromJsonNullable(json['onSurfaceVariant'] as int?),
      outline: _colorFromJsonNullable(json['outline'] as int?),
      shadow: _colorFromJsonNullable(json['shadow'] as int?),
      inverseSurface: _colorFromJsonNullable(json['inverseSurface'] as int?),
      onInverseSurface:
          _colorFromJsonNullable(json['onInverseSurface'] as int?),
      inversePrimary: _colorFromJsonNullable(json['inversePrimary'] as int?),
    );
  }

  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color surface;
  final Color onSurface;
  final Color background;
  final Color onBackground;
  final Color error;
  final Color onError;
  final Color? primaryContainer;
  final Color? onPrimaryContainer;
  final Color? secondaryContainer;
  final Color? onSecondaryContainer;
  final Color? tertiary;
  final Color? onTertiary;
  final Color? tertiaryContainer;
  final Color? onTertiaryContainer;
  final Color? surfaceVariant;
  final Color? onSurfaceVariant;
  final Color? outline;
  final Color? shadow;
  final Color? inverseSurface;
  final Color? onInverseSurface;
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

  Map<String, dynamic> toJson() {
    return {
      'primary': _colorToJson(primary),
      'onPrimary': _colorToJson(onPrimary),
      'secondary': _colorToJson(secondary),
      'onSecondary': _colorToJson(onSecondary),
      'surface': _colorToJson(surface),
      'onSurface': _colorToJson(onSurface),
      'background': _colorToJson(background),
      'onBackground': _colorToJson(onBackground),
      'error': _colorToJson(error),
      'onError': _colorToJson(onError),
      if (primaryContainer != null)
        'primaryContainer': _colorToJsonNullable(primaryContainer),
      if (onPrimaryContainer != null)
        'onPrimaryContainer': _colorToJsonNullable(onPrimaryContainer),
      if (secondaryContainer != null)
        'secondaryContainer': _colorToJsonNullable(secondaryContainer),
      if (onSecondaryContainer != null)
        'onSecondaryContainer': _colorToJsonNullable(onSecondaryContainer),
      if (tertiary != null) 'tertiary': _colorToJsonNullable(tertiary),
      if (onTertiary != null) 'onTertiary': _colorToJsonNullable(onTertiary),
      if (tertiaryContainer != null)
        'tertiaryContainer': _colorToJsonNullable(tertiaryContainer),
      if (onTertiaryContainer != null)
        'onTertiaryContainer': _colorToJsonNullable(onTertiaryContainer),
      if (surfaceVariant != null)
        'surfaceVariant': _colorToJsonNullable(surfaceVariant),
      if (onSurfaceVariant != null)
        'onSurfaceVariant': _colorToJsonNullable(onSurfaceVariant),
      if (outline != null) 'outline': _colorToJsonNullable(outline),
      if (shadow != null) 'shadow': _colorToJsonNullable(shadow),
      if (inverseSurface != null)
        'inverseSurface': _colorToJsonNullable(inverseSurface),
      if (onInverseSurface != null)
        'onInverseSurface': _colorToJsonNullable(onInverseSurface),
      if (inversePrimary != null)
        'inversePrimary': _colorToJsonNullable(inversePrimary),
    };
  }

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
  factory ThemeTypographyModel.fromJson(Map<String, dynamic> json) {
    return ThemeTypographyModel(
      fontFamily: json['fontFamily'] as String,
      displayLarge: _textStyleFromJson(
        json['displayLarge'] as Map<String, dynamic>,
      ),
      displayMedium: _textStyleFromJson(
        json['displayMedium'] as Map<String, dynamic>,
      ),
      displaySmall: _textStyleFromJson(
        json['displaySmall'] as Map<String, dynamic>,
      ),
      headlineLarge: _textStyleFromJson(
        json['headlineLarge'] as Map<String, dynamic>,
      ),
      headlineMedium: _textStyleFromJson(
        json['headlineMedium'] as Map<String, dynamic>,
      ),
      headlineSmall: _textStyleFromJson(
        json['headlineSmall'] as Map<String, dynamic>,
      ),
      titleLarge: _textStyleFromJson(
        json['titleLarge'] as Map<String, dynamic>,
      ),
      titleMedium: _textStyleFromJson(
        json['titleMedium'] as Map<String, dynamic>,
      ),
      titleSmall: _textStyleFromJson(
        json['titleSmall'] as Map<String, dynamic>,
      ),
      bodyLarge: _textStyleFromJson(
        json['bodyLarge'] as Map<String, dynamic>,
      ),
      bodyMedium: _textStyleFromJson(
        json['bodyMedium'] as Map<String, dynamic>,
      ),
      bodySmall: _textStyleFromJson(
        json['bodySmall'] as Map<String, dynamic>,
      ),
      labelLarge: _textStyleFromJson(
        json['labelLarge'] as Map<String, dynamic>,
      ),
      labelMedium: _textStyleFromJson(
        json['labelMedium'] as Map<String, dynamic>,
      ),
      labelSmall: _textStyleFromJson(
        json['labelSmall'] as Map<String, dynamic>,
      ),
    );
  }

  final String fontFamily;
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
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

  Map<String, dynamic> toJson() {
    return {
      'fontFamily': fontFamily,
      'displayLarge': _textStyleToJson(displayLarge),
      'displayMedium': _textStyleToJson(displayMedium),
      'displaySmall': _textStyleToJson(displaySmall),
      'headlineLarge': _textStyleToJson(headlineLarge),
      'headlineMedium': _textStyleToJson(headlineMedium),
      'headlineSmall': _textStyleToJson(headlineSmall),
      'titleLarge': _textStyleToJson(titleLarge),
      'titleMedium': _textStyleToJson(titleMedium),
      'titleSmall': _textStyleToJson(titleSmall),
      'bodyLarge': _textStyleToJson(bodyLarge),
      'bodyMedium': _textStyleToJson(bodyMedium),
      'bodySmall': _textStyleToJson(bodySmall),
      'labelLarge': _textStyleToJson(labelLarge),
      'labelMedium': _textStyleToJson(labelMedium),
      'labelSmall': _textStyleToJson(labelSmall),
    };
  }

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
    if (style.fontFamily != null) 'fontFamily': style.fontFamily,
    if (style.fontSize != null) 'fontSize': style.fontSize,
    if (style.fontWeight != null) 'fontWeight': style.fontWeight!.index,
    if (style.height != null) 'height': style.height,
  };
}
