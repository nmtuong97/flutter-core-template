import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../base/app_theme.dart';
import '../typography/font_configuration.dart';
import '../typography/font_sizes.dart';

/// Liquid Glass Theme Implementation
///
/// A modern glassmorphism theme focusing on:
/// - Multi-layer transparency with depth
/// - Dynamic light diffusion through specular highlights
/// - Material simulation via blur and gradient effects
/// - Subtle micro-motion feedback
/// - Context-adaptive colors for optimal readability
///
/// Based on design specification in design.md
class LiquidGlassTheme extends AppTheme {
  @override
  bool get supportsLightMode => true;

  @override
  bool get supportsDarkMode => true;

  @override
  String get id => 'liquid_glass';

  @override
  String get name => 'Liquid Glass';

  @override
  String get description =>
      'Modern glassmorphism with layered transparency and '
      'dynamic light diffusion';

  @override
  bool get isDefault => false;

  // ========================================================================
  // LIGHT MODE COLOR PALETTE
  // ========================================================================

  static const Color _backgroundLightColor1 = Color(0xFFEFF6FF);
  // Kept for potential gradient backgrounds
  // ignore: unused_field
  static const Color _backgroundLightColor2 = Color(0xFFF8FBFF);

  // Primary: Vibrant blue with glass-like properties
  static const Color _primaryLightColor = Color(0xFF2196F3);
  static const Color _primaryLightVariant = Color(0xFF1976D2);

  // Secondary: Complementary teal
  // Reserved for future secondary actions/components
  // ignore: unused_field
  static const Color _secondaryLightColor = Color(0xFF03DAC6);
  static const Color _secondaryLightVariant = Color(0xFF018786);

  // Surface: Frosted glass effect with iOS 16-like translucency
  // Using 80% opacity for glass effect (similar to iOS 16 materials)
  // Text contrast maintained via darker text colors
  static const Color _surfaceLightColor = Color(0xCCFFFFFF);

  // Border: Subtle dark edge for definition on light backgrounds
  // Using semi-transparent black for visible borders
  static const Color _borderLightColor = Color(0x40000000);

  // Tint overlay for glass effect
  // ignore: unused_field, for consistency with dark theme
  static const Color _tintLightColor = Color(0x26FFFFFF);

  // Text colors with optimal contrast (>4.5:1 per spec)
  static const Color _textPrimaryLightColor = Color(0xFF1A1A1A);
  static const Color _textSecondaryLightColor = Color(0xFF666666);
  // Reserved for disabled text states
  // ignore: unused_field
  static const Color _textDisabledLightColor = Color(0xFFAAAAAA);

  // Specular highlight for light diffusion simulation
  // Reserved for advanced glass effects
  // ignore: unused_field
  static const Color _specularHighlightLight = Color(0x40FFFFFF);

  // Shadow color for elevation (opacity: 0.05-0.1 per spec)
  static const Color _shadowLightColor = Color(0x1A000000);

  // ========================================================================
  // DARK MODE COLOR PALETTE
  // ========================================================================

  static const Color _backgroundDarkColor1 = Color(0xFF0D1117);
  // Kept for potential gradient backgrounds
  // ignore: unused_field
  static const Color _backgroundDarkColor2 = Color(0xFF161B22);

  // Primary: Lighter blue for dark backgrounds
  static const Color _primaryDarkColor = Color(0xFF64B5F6);
  static const Color _primaryDarkVariant = Color(0xFF42A5F5);

  // Secondary: Lighter teal
  static const Color _secondaryDarkColor = Color(0xFF80CBC4);
  static const Color _secondaryDarkVariant = Color(0xFF4DB6AC);

  // Surface: Dark frosted glass with iOS 16-like translucency
  // Using 75% opacity for glass effect (similar to iOS 16 dark materials)
  // Lighter gray-blue for better text contrast
  static const Color _surfaceDarkColor = Color(0xBF3A4A5C);

  // Border: Subtle light edge for definition on dark backgrounds
  static const Color _borderDarkColor = Color(0x40FFFFFF);

  // Tint overlay for dark glass
  // ignore: unused_field, for consistency with light theme
  static const Color _tintDarkColor = Color(0x40000000);

  // Text colors optimized for dark mode with higher contrast
  // Using near-white for primary text
  // (better contrast on translucent surface)
  static const Color _textPrimaryDarkColor = Color(0xFFF5F5F5);
  static const Color _textSecondaryDarkColor = Color(0xFFCCCCCC);
  // Reserved for disabled text states
  // ignore: unused_field
  static const Color _textDisabledDarkColor = Color(0xFF666666);

  // Specular highlight for dark mode
  // Reserved for advanced glass effects
  // ignore: unused_field
  static const Color _specularHighlightDark = Color(0x26FFFFFF);

  // Shadow color for dark mode
  static const Color _shadowDarkColor = Color(0x33000000);

  // ======================================================================
  // GLASS EFFECT CONSTANTS (from design spec)
  // ======================================================================

  /// Blur sigma: 16-30 per spec (we use 24 as optimal)
  static const double glassBlurSigma = 24;

  /// Corner radius: 12-24px per spec (we use 20 as default)
  static const double glassCornerRadius = 20;

  /// Border width: 1px per spec (using 0.5 for ultra-thin effect)
  static const double glassBorderWidth = 0.5;

  /// Animation duration: <300ms per spec
  static const Duration glassAnimationDuration = Duration(milliseconds: 250);

  /// Animation curve: easeOutCubic per spec
  static const Curve glassAnimationCurve = Curves.easeOutCubic;

  /// Elevation blur range: 8-12 per spec
  static const double glassShadowBlurRadius = 10;

  // ========================================================================
  // LIGHT THEME DATA
  // ========================================================================

  @override
  ThemeData get lightThemeData {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: _primaryLightColor,
        primaryContainer: _primaryLightVariant,
        secondaryContainer: _secondaryLightVariant,
        surface: _surfaceLightColor,
        error: Color(0xFFE53935),
        onSurface: _textPrimaryLightColor,
        outline: _borderLightColor,
      ),
      scaffoldBackgroundColor: _backgroundLightColor1,

      // AppBar: Glass effect with blur simulation
      appBarTheme: AppBarTheme(
        backgroundColor: _surfaceLightColor,
        foregroundColor: _textPrimaryLightColor,
        centerTitle: true,
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal + 4,
          fontWeight: FontWeight.w600,
          color: _textPrimaryLightColor,
          letterSpacing: 0.5,
        ),
        iconTheme: const IconThemeData(
          color: _textPrimaryLightColor,
        ),
      ),

      // Card: Glass effect container (iOS 16 style)
      cardTheme: CardThemeData(
        color: _surfaceLightColor,
        shadowColor: _shadowLightColor,
        elevation: 1, // Subtle shadow for depth (iOS 16 style)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(glassCornerRadius),
          side: const BorderSide(
            color: _borderLightColor,
            width: 0.75, // Slightly thicker for visibility
          ),
        ),
        margin: EdgeInsets.all(8.w),
      ),

      // Dialog: Modal glass effect
      dialogTheme: DialogThemeData(
        backgroundColor: _surfaceLightColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(glassCornerRadius),
          side: const BorderSide(
            color: _borderLightColor,
            width: glassBorderWidth,
          ),
        ),
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal + 6,
          fontWeight: FontWeight.bold,
          color: _textPrimaryLightColor,
        ),
        contentTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal,
          fontWeight: FontWeight.normal,
          color: _textSecondaryLightColor,
        ),
      ),

      // Bottom Sheet: Glass modal
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _surfaceLightColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(glassCornerRadius),
          ),
          side: BorderSide(
            color: _borderLightColor,
            width: glassBorderWidth,
          ),
        ),
        modalBackgroundColor: _surfaceLightColor,
      ),

      // Elevated Button: Glass button with depth
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryLightColor.withAlpha(230),
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: _shadowLightColor,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: const BorderSide(
              color: _borderLightColor,
              width: glassBorderWidth,
            ),
          ),
          animationDuration: glassAnimationDuration,
        ),
      ),

      // Outlined Button: Glass outline effect
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryLightColor,
          backgroundColor: _surfaceLightColor,
          side: const BorderSide(
            color: _primaryLightColor,
            width: 1.5,
          ),
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.w600,
            color: _primaryLightColor,
            letterSpacing: 0.5,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          animationDuration: glassAnimationDuration,
        ),
      ),

      // Text Button: Minimal glass effect
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryLightColor,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.w600,
            color: _primaryLightColor,
            letterSpacing: 0.5,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          animationDuration: glassAnimationDuration,
        ),
      ),

      // Input Decoration: Glass input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceLightColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: _borderLightColor,
            width: glassBorderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: _borderLightColor,
            width: glassBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: _primaryLightColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: Color(0xFFE53935),
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        hintStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal,
          fontWeight: FontWeight.normal,
          color: _textSecondaryLightColor,
        ),
      ),

      // Floating Action Button: Glass FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryLightColor,
        foregroundColor: Colors.white,
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: const BorderSide(
            color: _borderLightColor,
            width: glassBorderWidth,
          ),
        ),
      ),

      // Chip: Glass chip effect
      chipTheme: ChipThemeData(
        backgroundColor: _surfaceLightColor,
        selectedColor: _primaryLightColor.withAlpha(180),
        deleteIconColor: _textSecondaryLightColor,
        disabledColor: _surfaceLightColor.withAlpha(100),
        labelStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal - 2,
          fontWeight: FontWeight.w500,
          color: _textPrimaryLightColor,
        ),
        secondaryLabelStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal - 2,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(
            color: _borderLightColor,
            width: glassBorderWidth,
          ),
        ),
      ),

      // Text Theme
      textTheme: _getTextTheme(
        FontConfiguration.liquidGlassTheme.defaultFontFamily,
        FontSizeConfiguration.normal,
        _textPrimaryLightColor,
        _textSecondaryLightColor,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: _textPrimaryLightColor,
        size: 24,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: _borderLightColor,
        thickness: glassBorderWidth,
        space: 1,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryLightColor;
          }
          return _textSecondaryLightColor;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryLightColor.withAlpha(100);
          }
          return _surfaceLightColor;
        }),
        trackOutlineColor: WidgetStateProperty.all(_borderLightColor),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _primaryLightColor,
        linearTrackColor: _surfaceLightColor,
        circularTrackColor: _surfaceLightColor,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: _primaryLightColor,
        inactiveTrackColor: _surfaceLightColor,
        thumbColor: _primaryLightColor,
        overlayColor: _primaryLightColor.withAlpha(50),
        trackHeight: 4.h,
      ),
    );
  }

  // ========================================================================
  // DARK THEME DATA
  // ========================================================================

  @override
  ThemeData get darkThemeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: _primaryDarkColor,
      colorScheme: const ColorScheme.dark(
        primary: _primaryDarkColor,
        primaryContainer: _primaryDarkVariant,
        secondary: _secondaryDarkColor,
        secondaryContainer: _secondaryDarkVariant,
        surface: _surfaceDarkColor,
        error: Color(0xFFEF5350),
        onPrimary: Color(0xFF1A1A1A),
        onSecondary: Color(0xFF1A1A1A),
        onSurface: _textPrimaryDarkColor,
        onError: Colors.white,
        outline: _borderDarkColor,
      ),
      scaffoldBackgroundColor: _backgroundDarkColor1,

      // AppBar: Dark glass effect
      appBarTheme: AppBarTheme(
        backgroundColor: _surfaceDarkColor,
        foregroundColor: _textPrimaryDarkColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal + 4,
          fontWeight: FontWeight.w600,
          color: _textPrimaryDarkColor,
          letterSpacing: 0.5,
        ),
        iconTheme: const IconThemeData(
          color: _textPrimaryDarkColor,
        ),
      ),

      // Card: Dark glass container (iOS 16 style)
      cardTheme: CardThemeData(
        color: _surfaceDarkColor,
        shadowColor: _shadowDarkColor,
        elevation: 1, // Subtle shadow for depth (iOS 16 style)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(glassCornerRadius),
          side: const BorderSide(
            color: _borderDarkColor,
            width: 0.75, // Thicker for visibility in dark mode
          ),
        ),
        margin: EdgeInsets.all(8.w),
      ),

      // Dialog: Dark modal glass
      dialogTheme: DialogThemeData(
        backgroundColor: _surfaceDarkColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(glassCornerRadius),
          side: const BorderSide(
            color: _borderDarkColor,
            width: glassBorderWidth,
          ),
        ),
        titleTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal + 6,
          fontWeight: FontWeight.bold,
          color: _textPrimaryDarkColor,
        ),
        contentTextStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal,
          fontWeight: FontWeight.normal,
          color: _textSecondaryDarkColor,
        ),
      ),

      // Bottom Sheet: Dark glass modal
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _surfaceDarkColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(glassCornerRadius),
          ),
          side: BorderSide(
            color: _borderDarkColor,
            width: glassBorderWidth,
          ),
        ),
        modalBackgroundColor: _surfaceDarkColor,
      ),

      // Elevated Button: Dark glass button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryDarkColor.withAlpha(230),
          foregroundColor: const Color(0xFF1A1A1A),
          elevation: 0,
          shadowColor: _shadowDarkColor,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
            letterSpacing: 0.5,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: const BorderSide(
              color: _borderDarkColor,
              width: glassBorderWidth,
            ),
          ),
          animationDuration: glassAnimationDuration,
        ),
      ),

      // Outlined Button: Dark glass outline
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryDarkColor,
          backgroundColor: _surfaceDarkColor,
          side: const BorderSide(
            color: _primaryDarkColor,
            width: 1.5,
          ),
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.w600,
            color: _primaryDarkColor,
            letterSpacing: 0.5,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          animationDuration: glassAnimationDuration,
        ),
      ),

      // Text Button: Dark minimal effect
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryDarkColor,
          textStyle: _getTextStyle(
            fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
            fontSize: FontSizeConfiguration.normal,
            fontWeight: FontWeight.w600,
            color: _primaryDarkColor,
            letterSpacing: 0.5,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          animationDuration: glassAnimationDuration,
        ),
      ),

      // Input Decoration: Dark glass inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceDarkColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: _borderDarkColor,
            width: glassBorderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: _borderDarkColor,
            width: glassBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: _primaryDarkColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: Color(0xFFEF5350),
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        hintStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal,
          fontWeight: FontWeight.normal,
          color: _textSecondaryDarkColor,
        ),
      ),

      // Floating Action Button: Dark glass FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryDarkColor,
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: const BorderSide(
            color: _borderDarkColor,
            width: glassBorderWidth,
          ),
        ),
      ),

      // Chip: Dark glass chip
      chipTheme: ChipThemeData(
        backgroundColor: _surfaceDarkColor,
        selectedColor: _primaryDarkColor.withAlpha(180),
        deleteIconColor: _textSecondaryDarkColor,
        disabledColor: _surfaceDarkColor.withAlpha(100),
        labelStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal - 2,
          fontWeight: FontWeight.w500,
          color: _textPrimaryDarkColor,
        ),
        secondaryLabelStyle: _getTextStyle(
          fontFamily: FontConfiguration.liquidGlassTheme.defaultFontFamily,
          fontSize: FontSizeConfiguration.normal - 2,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1A1A1A),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(
            color: _borderDarkColor,
            width: glassBorderWidth,
          ),
        ),
      ),

      // Text Theme
      textTheme: _getTextTheme(
        FontConfiguration.liquidGlassTheme.defaultFontFamily,
        FontSizeConfiguration.normal,
        _textPrimaryDarkColor,
        _textSecondaryDarkColor,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: _textPrimaryDarkColor,
        size: 24,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: _borderDarkColor,
        thickness: glassBorderWidth,
        space: 1,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryDarkColor;
          }
          return _textSecondaryDarkColor;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryDarkColor.withAlpha(100);
          }
          return _surfaceDarkColor;
        }),
        trackOutlineColor: WidgetStateProperty.all(_borderDarkColor),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _primaryDarkColor,
        linearTrackColor: _surfaceDarkColor,
        circularTrackColor: _surfaceDarkColor,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: _primaryDarkColor,
        inactiveTrackColor: _surfaceDarkColor,
        thumbColor: _primaryDarkColor,
        overlayColor: _primaryDarkColor.withAlpha(50),
        trackHeight: 4.h,
      ),
    );
  }

  // ========================================================================
  // HELPER METHODS
  // ========================================================================

  /// Creates a text style with the given parameters
  static TextStyle _getTextStyle({
    required String fontFamily,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// Creates a complete text theme with the given parameters
  static TextTheme _getTextTheme(
    String fontFamily,
    double baseFontSize,
    Color primaryColor,
    Color secondaryColor,
  ) {
    return TextTheme(
      // Display styles
      displayLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 18,
        fontWeight: FontWeight.bold,
        color: primaryColor,
        height: 1.2,
      ),
      displayMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 14,
        fontWeight: FontWeight.bold,
        color: primaryColor,
        height: 1.2,
      ),
      displaySmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 10,
        fontWeight: FontWeight.bold,
        color: primaryColor,
        height: 1.2,
      ),

      // Headline styles
      headlineLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 8,
        fontWeight: FontWeight.bold,
        color: primaryColor,
        height: 1.3,
      ),
      headlineMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 6,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.3,
      ),
      headlineSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.3,
      ),

      // Title styles
      titleLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.4,
      ),
      titleMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 2,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.4,
      ),
      titleSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.4,
      ),

      // Body styles
      bodyLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize + 2,
        fontWeight: FontWeight.normal,
        color: primaryColor,
        height: 1.5,
      ),
      bodyMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize,
        fontWeight: FontWeight.normal,
        color: primaryColor,
        height: 1.5,
      ),
      bodySmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize - 2,
        fontWeight: FontWeight.normal,
        color: secondaryColor,
        height: 1.5,
      ),

      // Label styles
      labelLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize,
        fontWeight: FontWeight.w500,
        color: primaryColor,
        letterSpacing: 0.5,
      ),
      labelMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize - 2,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
      ),
      labelSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: baseFontSize - 4,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
      ),
    );
  }
}
