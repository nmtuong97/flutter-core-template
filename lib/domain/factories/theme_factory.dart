import 'package:flutter/material.dart';

import '../../theme/base/theme_factory.dart' as legacy;
import '../entities/theme_entity.dart';
import '../value_objects/theme_colors.dart';
import '../value_objects/theme_typography.dart';

/// Factory for creating theme entities from existing theme system
class DomainThemeFactory {
  /// Get all available themes as domain entities
  static List<ThemeEntity> getAvailableThemes() {
    final legacyThemes = legacy.ThemeFactory.availableThemes;

    return legacyThemes.map(_convertLegacyToDomain).toList();
  }

  /// Get theme by ID as domain entity
  static ThemeEntity? getThemeById(String themeId) {
    final legacyTheme = legacy.ThemeFactory.getThemeById(themeId);

    return _convertLegacyToDomain(legacyTheme);
  }

  /// Create default theme entity
  static ThemeEntity createDefault() {
    return const ThemeEntity(
      id: 'default',
      name: 'Default',
      description: 'Default application theme with Material Design 3',
      lightColors: ThemeColors.defaultLight(),
      darkColors: ThemeColors.defaultDark(),
      typography: ThemeTypography.defaultTypography(),
      isDefault: true,
      tags: ['material', 'default'],
    );
  }

  /// Create cyberpunk theme entity
  static ThemeEntity createCyberpunk() {
    return ThemeEntity(
      id: 'cyberpunk',
      name: 'Cyberpunk',
      description: 'Dark futuristic theme with neon colors',
      lightColors: _createCyberpunkLight(),
      darkColors: _createCyberpunkDark(),
      typography: ThemeTypography.withFontFamily('Orbitron'),
      tags: const ['dark', 'futuristic', 'neon'],
    );
  }

  /// Create glassmorphism theme entity
  static ThemeEntity createGlassmorphism() {
    return ThemeEntity(
      id: 'glassmorphism',
      name: 'Glassmorphism',
      description: 'Modern glass-like transparent design',
      lightColors: _createGlassmorphismLight(),
      darkColors: _createGlassmorphismDark(),
      typography: ThemeTypography.withFontFamily('Inter'),
      tags: const ['modern', 'glass', 'transparent'],
    );
  }

  /// Create neumorphism theme entity
  static ThemeEntity createNeumorphism() {
    return ThemeEntity(
      id: 'neumorphism',
      name: 'Neumorphism',
      description: 'Soft UI design with subtle shadows',
      lightColors: _createNeumorphismLight(),
      darkColors: _createNeumorphismDark(),
      typography: ThemeTypography.withFontFamily('SF Pro Display'),
      tags: const ['soft', 'minimal', 'shadows'],
    );
  }

  /// Get all built-in themes
  static List<ThemeEntity> getAllBuiltInThemes() {
    return [
      createDefault(),
      createCyberpunk(),
      createGlassmorphism(),
      createNeumorphism(),
    ];
  }

  /// Convert legacy theme to domain entity
  static ThemeEntity _convertLegacyToDomain(Object? legacyTheme) {
    if (legacyTheme == null) {
      return _createFallbackTheme();
    }

    // Type-safe extraction using getters or known interfaces
    var id = 'unknown';
    var name = 'Unknown Theme';
    ThemeData? lightTheme;
    ThemeData? darkTheme;

    try {
      // Check if it's a Map first (safest approach)
      if (legacyTheme is Map<String, dynamic>) {
        id = legacyTheme['id']?.toString() ?? 'unknown';
        name = legacyTheme['name']?.toString() ?? 'Unknown Theme';
        lightTheme = legacyTheme['lightThemeData'] as ThemeData?;
        darkTheme = legacyTheme['darkThemeData'] as ThemeData?;
      } else {
        // For other types, use reflection-like safe approach
        final reflection = legacyTheme.toString();
        if (reflection.isNotEmpty) {
          // Extract minimal info from string representation
          id = reflection.hashCode.toString();
          name = 'Legacy Theme';
        }
      }
    } on Exception {
      // If extraction fails, use defaults
      return _createFallbackTheme();
    }

    return ThemeEntity(
      id: id,
      name: name,
      description: 'Legacy theme: $name',
      lightColors: lightTheme != null
          ? _extractColorsFromThemeData(lightTheme)
          : const ThemeColors.defaultLight(),
      darkColors: darkTheme != null
          ? _extractColorsFromThemeData(darkTheme)
          : const ThemeColors.defaultDark(),
      typography: const ThemeTypography.defaultTypography(),
      tags: const ['legacy'],
    );
  }

  /// Create fallback theme when legacy conversion fails
  static ThemeEntity _createFallbackTheme() {
    return const ThemeEntity(
      id: 'fallback',
      name: 'Fallback Theme',
      description: 'Default fallback theme',
      lightColors: ThemeColors.defaultLight(),
      darkColors: ThemeColors.defaultDark(),
      typography: ThemeTypography.defaultTypography(),
      tags: ['fallback', 'default'],
    );
  }

  /// Extract colors from ThemeData
  static ThemeColors _extractColorsFromThemeData(ThemeData themeData) {
    final colorScheme = themeData.colorScheme;

    return ThemeColors(
      primary: colorScheme.primary,
      onPrimary: colorScheme.onPrimary,
      secondary: colorScheme.secondary,
      onSecondary: colorScheme.onSecondary,
      surface: colorScheme.surface,
      onSurface: colorScheme.onSurface,
      background:
          colorScheme.surface, // Use surface as background is deprecated
      onBackground: colorScheme.onSurface,
      error: colorScheme.error,
      onError: colorScheme.onError,
      primaryContainer: colorScheme.primaryContainer,
      onPrimaryContainer: colorScheme.onPrimaryContainer,
      secondaryContainer: colorScheme.secondaryContainer,
      onSecondaryContainer: colorScheme.onSecondaryContainer,
      tertiary: colorScheme.tertiary,
      onTertiary: colorScheme.onTertiary,
      tertiaryContainer: colorScheme.tertiaryContainer,
      onTertiaryContainer: colorScheme.onTertiaryContainer,
      outline: colorScheme.outline,
      shadow: colorScheme.shadow,
      inverseSurface: colorScheme.inverseSurface,
      onInverseSurface: colorScheme.onInverseSurface,
      inversePrimary: colorScheme.inversePrimary,
    );
  }

  /// Create cyberpunk light colors
  static ThemeColors _createCyberpunkLight() {
    return const ThemeColors(
      primary: Color(0xFF00FFFF),
      onPrimary: Color(0xFF000000),
      secondary: Color(0xFFFF00FF),
      onSecondary: Color(0xFF000000),
      surface: Color(0xFFF0F0F0),
      onSurface: Color(0xFF000000),
      background: Color(0xFFF0F0F0),
      onBackground: Color(0xFF000000),
      error: Color(0xFFFF0040),
      onError: Color(0xFFFFFFFF),
    );
  }

  /// Create cyberpunk dark colors
  static ThemeColors _createCyberpunkDark() {
    return const ThemeColors(
      primary: Color(0xFF00FFFF),
      onPrimary: Color(0xFF000000),
      secondary: Color(0xFFFF00FF),
      onSecondary: Color(0xFF000000),
      surface: Color(0xFF121212),
      onSurface: Color(0xFF00FFFF),
      background: Color(0xFF000000),
      onBackground: Color(0xFF00FFFF),
      error: Color(0xFFFF0040),
      onError: Color(0xFFFFFFFF),
    );
  }

  /// Create glassmorphism light colors
  static ThemeColors _createGlassmorphismLight() {
    return const ThemeColors(
      primary: Color(0xFF6366F1),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF8B5CF6),
      onSecondary: Color(0xFFFFFFFF),
      surface: Color(0xFFFAFAFA),
      onSurface: Color(0xFF1F2937),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF1F2937),
      error: Color(0xFFEF4444),
      onError: Color(0xFFFFFFFF),
    );
  }

  /// Create glassmorphism dark colors
  static ThemeColors _createGlassmorphismDark() {
    return const ThemeColors(
      primary: Color(0xFF818CF8),
      onPrimary: Color(0xFF1E1B4B),
      secondary: Color(0xFFA78BFA),
      onSecondary: Color(0xFF581C87),
      surface: Color(0xFF1F2937),
      onSurface: Color(0xFFF9FAFB),
      background: Color(0xFF111827),
      onBackground: Color(0xFFF9FAFB),
      error: Color(0xFFF87171),
      onError: Color(0xFF7F1D1D),
    );
  }

  /// Create neumorphism light colors
  static ThemeColors _createNeumorphismLight() {
    return const ThemeColors(
      primary: Color(0xFF667EEA),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF764BA2),
      onSecondary: Color(0xFFFFFFFF),
      surface: Color(0xFFE0E5EC),
      onSurface: Color(0xFF2D3748),
      background: Color(0xFFE0E5EC),
      onBackground: Color(0xFF2D3748),
      error: Color(0xFFE53E3E),
      onError: Color(0xFFFFFFFF),
    );
  }

  /// Create neumorphism dark colors
  static ThemeColors _createNeumorphismDark() {
    return const ThemeColors(
      primary: Color(0xFF667EEA),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF764BA2),
      onSecondary: Color(0xFFFFFFFF),
      surface: Color(0xFF2D3748),
      onSurface: Color(0xFFE2E8F0),
      background: Color(0xFF1A202C),
      onBackground: Color(0xFFE2E8F0),
      error: Color(0xFFFC8181),
      onError: Color(0xFF742A2A),
    );
  }
}
