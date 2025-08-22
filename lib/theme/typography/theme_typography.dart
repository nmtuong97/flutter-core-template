import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/theme_constants.dart';
import 'font_configuration.dart';

/// ThemeTypography chịu trách nhiệm tạo TextStyle/TextTheme dựa trên cấu hình font
/// Includes caching for performance optimization
class ThemeTypography {
  const ThemeTypography(this.config);

  final FontConfiguration config;

  // Cache for TextStyle instances to improve performance
  static final Map<String, TextStyle> _textStyleCache = {};
  static final Map<String, TextTheme> _textThemeCache = {};

  /// Clear cache when memory usage is high
  static void clearCache() {
    _textStyleCache.clear();
    _textThemeCache.clear();
  }

  /// Clear old cache entries when cache is full
  static void _cleanupCache() {
    if (_textStyleCache.length >= ThemeConstants.maxCacheSize) {
      // Remove oldest 25% of entries
      final keysToRemove =
          _textStyleCache.keys.take(_textStyleCache.length ~/ 4).toList();
      for (final key in keysToRemove) {
        _textStyleCache.remove(key);
      }
    }

    if (_textThemeCache.length >= (ThemeConstants.maxCacheSize ~/ 2)) {
      // Remove oldest 25% of entries
      final keysToRemove =
          _textThemeCache.keys.take(_textThemeCache.length ~/ 4).toList();
      for (final key in keysToRemove) {
        _textThemeCache.remove(key);
      }
    }
  }

  /// Get cache size for monitoring
  static int get cacheSize => _textStyleCache.length + _textThemeCache.length;

  /// Get cache statistics for debugging
  static Map<String, int> get cacheStats => {
        'textStyles': _textStyleCache.length,
        'textThemes': _textThemeCache.length,
        'total': cacheSize,
      };

  /// Generate cache key for TextStyle
  static String _generateStyleCacheKey({
    required String fontFamily,
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    bool hasShadow = false,
  }) {
    return '${fontFamily}_${fontSize}_${fontWeight?.index ?? 3}_'
        '${color?.toARGB32() ?? 0}_${letterSpacing ?? 0}_'
        '${height ?? 0}_$hasShadow';
  }

  /// Generate cache key for TextTheme
  static String _generateThemeCacheKey({
    required String fontFamily,
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    return '${fontFamily}_${primaryColor.toARGB32()}_'
        '${secondaryColor.toARGB32()}';
  }

  /// Trả về TextStyle dựa trên tên fontFamily hiện tại của theme
  /// Sử dụng cache để tối ưu performance
  TextStyle getTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    bool hasShadow = false,
    Color? shadowColor,
    bool isResponsive = true,
  }) {
    final size = isResponsive ? fontSize.sp : fontSize;

    // Generate cache key
    final cacheKey = _generateStyleCacheKey(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      hasShadow: hasShadow,
    );

    // Return cached style if available
    if (_textStyleCache.containsKey(cacheKey)) {
      return _textStyleCache[cacheKey]!;
    }

    final fontType = _mapFamilyToType(fontFamily);

    var base = FontConfiguration.getGoogleFontStyle(
      config: config,
      fontType: fontType,
      fontSize: size,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
      letterSpacing: letterSpacing,
    );

    if (hasShadow && shadowColor != null) {
      base = base.copyWith(
        shadows: [
          Shadow(
            color: shadowColor.withValues(alpha: 0.7),
            blurRadius: 4,
          ),
        ],
      );
    }

    // Cache the style with automatic cleanup
    if (_textStyleCache.length >= ThemeConstants.maxCacheSize) {
      _cleanupCache();
    }
    _textStyleCache[cacheKey] = base;

    return base;
  }

  /// Create a complete TextTheme based on font configuration
  /// Sử dụng cache để tối ưu performance
  TextTheme getTextTheme({
    required String fontFamily,
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    // Generate cache key for TextTheme
    final cacheKey = _generateThemeCacheKey(
      fontFamily: fontFamily,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
    );

    // Return cached theme if available
    if (_textThemeCache.containsKey(cacheKey)) {
      return _textThemeCache[cacheKey]!;
    }

    // Create new TextTheme
    final textTheme = TextTheme(
      // Display styles
      displayLarge: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        color: primaryColor,
      ),
      displayMedium: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        color: primaryColor,
      ),
      displaySmall: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        color: primaryColor,
      ),

      // Headline styles
      headlineLarge: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      headlineMedium: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      headlineSmall: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),

      // Title styles
      titleLarge: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      titleMedium: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      titleSmall: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),

      // Body styles
      bodyLarge: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        color: primaryColor,
      ),
      bodyMedium: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        color: primaryColor,
      ),
      bodySmall: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        color: secondaryColor,
      ),

      // Label styles
      labelLarge: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      labelMedium: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      labelSmall: getTextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
    );

    // Cache the theme with automatic cleanup
    if (_textThemeCache.length >= (ThemeConstants.maxCacheSize ~/ 2)) {
      _cleanupCache();
    }
    _textThemeCache[cacheKey] = textTheme;

    return textTheme;
  }

  /// Helper: map tên font sang FontType
  /// (ví dụ 'Poppins', 'Merriweather', 'Roboto')
  FontType _mapFamilyToType(String fontFamily) {
    final normalized = fontFamily.toLowerCase();
    if (normalized == config.alternateFontFamily.toLowerCase()) {
      return FontType.alternateFont;
    }
    if (normalized == config.serifFontFamily.toLowerCase()) {
      return FontType.serifFont;
    }
    return FontType.defaultFont;
  }
}
