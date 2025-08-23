import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_theme_showcase/domain/entities/theme_entity.dart';
import 'package:flutter_theme_showcase/domain/value_objects/theme_colors.dart';
import 'package:flutter_theme_showcase/domain/value_objects/theme_typography.dart';

void main() {
  group('ThemeEntity', () {
    late ThemeEntity themeEntity;
    late ThemeColors lightColors;
    late ThemeColors darkColors;
    late ThemeTypography typography;

    setUp(() {
      lightColors = const ThemeColors.defaultLight();
      darkColors = const ThemeColors.defaultDark();
      typography = const ThemeTypography.defaultTypography();

      themeEntity = ThemeEntity(
        id: 'test_theme',
        name: 'Test Theme',
        description: 'A test theme for unit testing',
        lightColors: lightColors,
        darkColors: darkColors,
        typography: typography,
        tags: const ['test', 'unit'],
      );
    });

    test('should create theme entity with required properties', () {
      expect(themeEntity.id, equals('test_theme'));
      expect(themeEntity.name, equals('Test Theme'));
      expect(themeEntity.description, equals('A test theme for unit testing'));
      expect(themeEntity.lightColors, equals(lightColors));
      expect(themeEntity.darkColors, equals(darkColors));
      expect(themeEntity.typography, equals(typography));
      expect(themeEntity.isDefault, isFalse);
      expect(themeEntity.isCustom, isFalse);
      expect(themeEntity.tags, equals(['test', 'unit']));
    });

    test('should return light colors for light theme mode', () {
      final colors = themeEntity.getColors(ThemeMode.light, Brightness.dark);
      expect(colors, equals(lightColors));
    });

    test('should return dark colors for dark theme mode', () {
      final colors = themeEntity.getColors(ThemeMode.dark, Brightness.light);
      expect(colors, equals(darkColors));
    });

    test('should return dark colors for system mode with dark brightness', () {
      final colors = themeEntity.getColors(ThemeMode.system, Brightness.dark);
      expect(colors, equals(darkColors));
    });

    test('should return light colors for system mode with light brightness',
        () {
      final colors = themeEntity.getColors(ThemeMode.system, Brightness.light);
      expect(colors, equals(lightColors));
    });

    test('should create copy with modified properties', () {
      final copied = themeEntity.copyWith(
        name: 'Modified Theme',
        isCustom: true,
      );

      expect(copied.id, equals('test_theme')); // Unchanged
      expect(copied.name, equals('Modified Theme')); // Changed
      expect(copied.isCustom, isTrue); // Changed
      expect(
        copied.description,
        equals('A test theme for unit testing'),
      ); // Unchanged
    });

    test('should create default theme entity', () {
      const defaultTheme = ThemeEntity.createDefault();

      expect(defaultTheme.id, equals('default'));
      expect(defaultTheme.name, equals('Default'));
      expect(defaultTheme.isDefault, isTrue);
      expect(defaultTheme.isCustom, isFalse);
    });

    test('should validate as valid when all required properties are present',
        () {
      expect(themeEntity.isValid, isTrue);
    });

    test('should validate as invalid when required properties are empty', () {
      final invalidTheme = ThemeEntity(
        id: '',
        name: '',
        description: '',
        lightColors: lightColors,
        darkColors: darkColors,
        typography: typography,
      );

      expect(invalidTheme.isValid, isFalse);
    });

    test('should have proper equality comparison', () {
      final theme1 = ThemeEntity(
        id: 'theme1',
        name: 'Theme 1',
        description: 'Description',
        lightColors: lightColors,
        darkColors: darkColors,
        typography: typography,
      );

      final theme2 = ThemeEntity(
        id: 'theme1',
        name: 'Theme 1',
        description: 'Description',
        lightColors: lightColors,
        darkColors: darkColors,
        typography: typography,
      );

      final theme3 = ThemeEntity(
        id: 'theme2',
        name: 'Theme 2',
        description: 'Description',
        lightColors: lightColors,
        darkColors: darkColors,
        typography: typography,
      );

      expect(theme1, equals(theme2));
      expect(theme1, isNot(equals(theme3)));
    });

    test('should have proper toString representation', () {
      final toString = themeEntity.toString();
      expect(toString, contains('test_theme'));
      expect(toString, contains('Test Theme'));
      expect(toString, contains('false')); // isDefault
    });
  });
}
