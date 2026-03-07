import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Theme constants for consistent styling across the application
/// Centralizes all magic numbers and hardcoded values
class ThemeConstants {
  const ThemeConstants._();

  // ==========================================================================
  // MATERIAL DESIGN CONFIGURATION
  // ==========================================================================

  /// Enable Material 3 design system
  static const bool useMaterial3 = true;

  // ==========================================================================
  // OPACITY VALUES
  // ==========================================================================

  /// Standard opacity for disabled elements
  static const double disabledOpacity = 0.38;

  /// Standard opacity for secondary text
  static const double secondaryOpacity = 0.6;

  /// Alternative name for secondary text opacity (backward compatibility)
  static const double secondaryTextOpacity = secondaryOpacity;

  /// Standard opacity for hint text
  static const double hintOpacity = 0.5;

  /// Standard opacity for dividers
  static const double dividerOpacity = 0.12;

  /// Standard opacity for overlays
  static const double overlayOpacity = 0.08;

  /// Standard opacity values for consistent transparency
  static const double opacityDisabled = 0.38;
  static const double opacitySecondary = 0.6;
  static const double opacityPrimary = 0.87;
  static const double opacityOverlay = 0.5;
  static const double opacityCardShadow = 0.1;
  static const double opacityButtonShadow = 0.2;
  static const double opacityDialogShadow = 0.3;
  static const double opacityVideoControls = 0.7;
  static const double opacityGlassEffect = 0.7;
  static const double opacityFrostedBorder = 0.4;

  // ==================== FONT SIZE OFFSETS ====================
  /// Font size increments for text hierarchy
  static const List<double> fontSizeOffsets = [
    12, // displayLarge
    10, // displayMedium
    8, // displaySmall
    6, // headlineLarge
    5, // headlineMedium
    4, // headlineSmall, titleLarge
    2, // titleMedium, bodyLarge
    0, // bodyMedium, titleSmall, labelLarge (base)
    -1, // labelMedium
    -2, // bodySmall, labelSmall
  ];

  // ==========================================================================
  // FONT SIZE ADJUSTMENTS
  // ==========================================================================

  /// Font size offset for better readability
  static double get fontSizeOffset => 2.sp;

  /// Minimum font size for accessibility
  static double get minFontSize => 12.sp;

  /// Maximum font size for headers
  static double get maxHeaderFontSize => 32.sp;

  /// App bar title font size
  static double get appBarTitleFontSize => 20.sp;

  /// Button font size
  static double get buttonFontSize => 16.sp;

  // ==================== BORDER RADIUS VALUES ====================
  /// Standard border radius values for consistent UI
  static BorderRadius get smallRadius => BorderRadius.circular(4.r);
  static BorderRadius get defaultRadius => BorderRadius.circular(8.r);
  static BorderRadius get mediumRadius => BorderRadius.circular(12.r);
  static BorderRadius get largeRadius => BorderRadius.circular(16.r);
  static BorderRadius get extraLargeRadius => BorderRadius.circular(24.r);

  // ==================== PADDING VALUES ====================
  /// Standard padding values for consistent spacing
  static EdgeInsets get tinyPadding => EdgeInsets.all(4.r);
  static EdgeInsets get smallPadding => EdgeInsets.all(8.r);
  static EdgeInsets get defaultPadding => EdgeInsets.all(16.r);
  static EdgeInsets get mediumPadding => EdgeInsets.all(20.r);
  static EdgeInsets get largePadding => EdgeInsets.all(24.r);
  static EdgeInsets get extraLargePadding => EdgeInsets.all(32.r);

  /// Button specific padding
  static EdgeInsets get buttonPadding => EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      );

  /// Card specific padding
  static EdgeInsets get cardPadding => EdgeInsets.all(16.r);

  /// Dialog specific padding
  static EdgeInsets get dialogPadding => EdgeInsets.all(24.r);

  /// Button horizontal padding
  static double get buttonPaddingHorizontal => 24.w;

  /// Button vertical padding
  static double get buttonPaddingVertical => 12.h;

  // ==================== ELEVATION VALUES ====================
  /// Standard elevation values for consistent shadows
  static const double elevationNone = 0;
  static const double elevationLow = 1;
  static const double elevationMedium = 2;
  static const double elevationHigh = 4;
  static const double elevationVeryHigh = 8;
  static const double elevationExtreme = 16;

  /// Standard elevation for cards
  static const double cardElevation = 2;

  /// Standard elevation for buttons
  static const double buttonElevation = 1;

  /// Standard elevation for dialogs
  static const double dialogElevation = 8;

  /// Standard elevation for app bars
  static const double appBarElevation = 0;

  /// Standard elevation for bottom sheets
  static const double bottomSheetElevation = 4;

  // ==================== ICON SIZES ====================
  /// Standard icon sizes
  static double get smallIconSize => 16.r;
  static double get defaultIconSize => 24.r;
  static double get mediumIconSize => 32.r;
  static double get largeIconSize => 48.r;

  // ==================== ANIMATION DURATIONS ====================
  /// Standard animation durations for consistent motion
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration normalAnimation = Duration(milliseconds: 250);
  static const Duration slowAnimation = Duration(milliseconds: 350);
  static const Duration verySlowAnimation = Duration(milliseconds: 500);

  // ==================== SHADOW CONFIGURATIONS ====================
  /// Pre-configured shadow styles
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: opacityCardShadow),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: opacityButtonShadow),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get dialogShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: opacityDialogShadow),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  /// Neon glow effect for cyberpunk theme
  static List<BoxShadow> neonGlow(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.5),
          blurRadius: 8,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 16,
          spreadRadius: 4,
        ),
      ];

  /// Neumorphism shadow effect
  static List<BoxShadow> neumorphismShadow({
    required Color lightShadow,
    required Color darkShadow,
  }) =>
      [
        BoxShadow(
          color: darkShadow,
          offset: const Offset(4, 4),
          blurRadius: 8,
        ),
        BoxShadow(
          color: lightShadow,
          offset: const Offset(-4, -4),
          blurRadius: 8,
        ),
      ];

  // ==================== TEXT SHADOW CONFIGURATIONS ====================
  /// Pre-configured text shadows
  static List<Shadow> get defaultTextShadow => [
        Shadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 2,
          offset: const Offset(1, 1),
        ),
      ];

  static List<Shadow> neonTextGlow(Color color) => [
        Shadow(
          color: color.withValues(alpha: 0.7),
          blurRadius: 4,
        ),
        Shadow(
          color: color.withValues(alpha: 0.5),
          blurRadius: 8,
        ),
      ];

  // ==================== BORDER CONFIGURATIONS ====================
  /// Standard border styles
  static BorderSide get defaultBorder => const BorderSide(
        color: Colors.grey,
      );

  static BorderSide get thickBorder => const BorderSide(
        color: Colors.grey,
        width: 2,
      );

  /// Standard border width
  static const double borderWidth = 1;

  /// Button border radius
  static double get buttonBorderRadius => 8.r;

  /// Card border radius
  static double get cardBorderRadius => 12.r;

  /// Card margin
  static double get cardMargin => 8.w;

  /// Divider thickness
  static const double dividerThickness = 1;

  /// Divider space
  static double get dividerSpace => 16.h;

  static BorderSide frostedBorder(Color color) => BorderSide(
        color: color.withValues(alpha: opacityFrostedBorder),
      );

  // ==================== VALIDATION CONSTANTS ====================
  /// Constants for theme validation
  static const double minContrastRatio = 4.5;
  static const double preferredContrastRatio = 7;
  static const int maxThemeNameLength = 50;
  static const int maxThemeDescriptionLength = 200;

  // ==================== PERFORMANCE CONSTANTS ====================
  /// Constants for performance optimization
  static const int maxCachedTextStyles = 100;

  // Cache configuration
  static const Duration cacheExpiration = Duration(minutes: 30);
  static const int maxThemeInstances = 10;
  static const int maxCacheSize = 100;

  // Additional validation constants
  static const int maxThemeCreationTime = 100; // milliseconds
  static const int maxThemeIdLength = 50;
}
