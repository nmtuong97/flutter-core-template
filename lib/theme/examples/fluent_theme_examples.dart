import 'package:flutter/material.dart';
import '../builders/fluent_theme_builder.dart';

/// Examples demonstrating the FluentThemeBuilder usage
/// Shows various ways to create themes using method chaining
class FluentThemeExamples {
  /// Create a modern Material Design 3 theme
  static CustomFluentTheme createModernTheme() {
    return FluentThemeBuilder.create('modern_theme', 'Modern Theme')
        .withDescription(
          'A clean, modern theme following Material Design 3 principles',
        )
        .withMaterial3Defaults()
        .withPrimaryColors(
          primary: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
          background: Colors.white,
          surface: Colors.grey[50],
        )
        .withTypography(
          fontFamily: 'Roboto',
          baseFontSize: 14,
          primaryTextColor: Colors.black87,
          secondaryTextColor: Colors.grey[600],
        )
        .buildCustomTheme();
  }

  /// Create a dark cyberpunk-inspired theme
  static CustomFluentTheme createCyberpunkTheme() {
    return FluentThemeBuilder.create('cyberpunk_theme', 'Cyberpunk Theme')
        .withDescription('A futuristic dark theme with neon accents')
        .withPrimaryColors(
          primary: const Color(0xFF00FFFF), // Cyan
          secondary: const Color(0xFFFF00FF), // Magenta
          background: const Color(0xFF0A0A0A), // Almost black
          surface: const Color(0xFF1A1A1A), // Dark grey
          error: const Color(0xFFFF0040), // Neon red
        )
        .withTypography(
          fontFamily: 'Orbitron',
          baseFontSize: 13,
          primaryTextColor: const Color(0xFF00FFFF),
          secondaryTextColor: const Color(0xFF888888),
        )
        .withTextStyling(
          letterSpacing: 0.5,
        )
        .withComponentStyling(
          borderRadius: 2,
          elevation: 8,
          buttonPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        )
        .withModeSupport(light: false)
        .buildCustomTheme();
  }

  /// Create a minimalist theme
  static CustomFluentTheme createMinimalistTheme() {
    return FluentThemeBuilder.create('minimalist_theme', 'Minimalist Theme')
        .withDescription('Clean and simple design with minimal visual elements')
        .withMinimalistDesign()
        .withColorPalette(ThemeColorPalette.monochrome)
        .withTypography(
          fontFamily: 'Helvetica Neue',
          baseFontSize: 15,
        )
        .buildCustomTheme();
  }

  /// Create a nature-inspired theme
  static CustomFluentTheme createNatureTheme() {
    return FluentThemeBuilder.create('nature_theme', 'Nature Theme')
        .withDescription('Earthy colors inspired by nature')
        .withPrimaryColors(
          primary: const Color(0xFF4CAF50), // Green
          secondary: const Color(0xFF8BC34A), // Light green
          background: const Color(0xFFF1F8E9), // Very light green
          surface: const Color(0xFFE8F5E8), // Light green surface
          error: const Color(0xFFD32F2F), // Red
        )
        .withTypography(
          fontFamily: 'Lato',
          baseFontSize: 14,
          primaryTextColor: const Color(0xFF2E7D32),
          secondaryTextColor: const Color(0xFF558B2F),
        )
        .withComponentStyling(
          borderRadius: 16,
          elevation: 2,
          buttonPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        )
        .buildCustomTheme();
  }

  /// Create a retro theme with vintage colors
  static CustomFluentTheme createRetroTheme() {
    return FluentThemeBuilder.create('retro_theme', 'Retro Theme')
        .withDescription('Vintage-inspired theme with warm, nostalgic colors')
        .withPrimaryColors(
          primary: const Color(0xFFD2691E), // Chocolate
          secondary: const Color(0xFFCD853F), // Peru
          background: const Color(0xFFFFF8DC), // Cornsilk
          surface: const Color(0xFFFAF0E6), // Linen
          error: const Color(0xFFB22222), // Fire brick
        )
        .withTypographyStyle(TypographyStyle.classic)
        .withComponentStyling(
          borderRadius: 8,
          elevation: 4,
        )
        .buildCustomTheme();
  }

  /// Create a high-contrast accessibility theme
  static CustomFluentTheme createAccessibilityTheme() {
    return FluentThemeBuilder.create(
      'accessibility_theme',
      'High Contrast Theme',
    )
        .withDescription('High contrast theme for better accessibility')
        .withPrimaryColors(
          primary: Colors.black,
          secondary: const Color(0xFF333333),
          background: Colors.white,
          surface: const Color(0xFFF5F5F5),
          error: const Color(0xFFCC0000),
        )
        .withTypography(
          fontFamily: 'Roboto',
          baseFontSize: 16, // Larger base font for accessibility
          primaryTextColor: Colors.black,
          secondaryTextColor: const Color(0xFF333333),
        )
        .withComponentStyling(
          borderRadius: 4,
          elevation: 0, // Flat design for clarity
          buttonPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        )
        .buildCustomTheme();
  }

  /// Create a playful theme for children's apps
  static CustomFluentTheme createPlayfulTheme() {
    return FluentThemeBuilder.create('playful_theme', 'Playful Theme')
        .withDescription(
          "Bright and colorful theme perfect for children's applications",
        )
        .withPrimaryColors(
          primary: const Color(0xFFFF6B6B), // Coral
          secondary: const Color(0xFF4ECDC4), // Turquoise
          background: const Color(0xFFFFFBF0), // Ivory
          surface: const Color(0xFFF0F8FF), // Alice blue
          error: const Color(0xFFFF4757), // Red
        )
        .withTypographyStyle(TypographyStyle.playful)
        .withComponentStyling(
          borderRadius: 20, // Very rounded for playful look
          elevation: 3,
          buttonPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        )
        .buildCustomTheme();
  }

  /// Get all example themes as a list
  static List<CustomFluentTheme> getAllExampleThemes() {
    return [
      createModernTheme(),
      createCyberpunkTheme(),
      createMinimalistTheme(),
      createNatureTheme(),
      createRetroTheme(),
      createAccessibilityTheme(),
      createPlayfulTheme(),
    ];
  }

  /// Demonstrate theme customization with user preferences
  static CustomFluentTheme createCustomizedTheme({
    required String userId,
    required Color preferredColor,
    required double fontSize,
    required bool isDarkMode,
  }) {
    final baseBuilder = FluentThemeBuilder.create(
      'user_${userId}_theme',
      'Custom Theme for User $userId',
    ).withDescription('Personalized theme based on user preferences');

    if (isDarkMode) {
      return baseBuilder
          .withColorPalette(ThemeColorPalette.dark)
          .withPrimaryColors(primary: preferredColor)
          .withTypography(baseFontSize: fontSize)
          .asDarkTheme()
          .buildCustomTheme();
    } else {
      return baseBuilder
          .withColorPalette(ThemeColorPalette.material)
          .withPrimaryColors(primary: preferredColor)
          .withTypography(baseFontSize: fontSize)
          .asLightTheme()
          .buildCustomTheme();
    }
  }
}

/// Usage examples for different scenarios
class FluentThemeUsageExamples {
  /// Example: Creating a theme for a specific brand
  static void brandThemeExample() {
    final brandTheme = FluentThemeBuilder.create('brand_theme', 'Brand Theme')
        .withDescription('Corporate brand theme')
        .withPrimaryColors(
          primary: const Color(0xFF1976D2), // Brand blue
          secondary: const Color(0xFF42A5F5), // Light blue
        )
        .withTypography(
          fontFamily: 'Corporate Sans', // Brand font
          baseFontSize: 14,
        )
        .withMaterial3Defaults()
        .buildCustomTheme();

    // Use the theme in your app
    debugPrint('Created brand theme: ${brandTheme.name}');
  }

  /// Example: Creating a theme with conditional styling
  static CustomFluentTheme createConditionalTheme({required bool isTablet}) {
    final builder =
        FluentThemeBuilder.create('responsive_theme', 'Responsive Theme')
            .withDescription('Theme that adapts to device type')
            .withMaterial3Defaults();

    if (isTablet) {
      // Larger elements for tablets
      return builder
          .withTypography(baseFontSize: 16)
          .withComponentStyling(
            borderRadius: 12,
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          )
          .buildCustomTheme();
    } else {
      // Smaller elements for phones
      return builder
          .withTypography(baseFontSize: 14)
          .withComponentStyling(
            borderRadius: 8,
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          )
          .buildCustomTheme();
    }
  }

  /// Example: Theme inheritance and modification
  static CustomFluentTheme createDerivedTheme(CustomFluentTheme baseTheme) {
    // Create a new theme based on an existing one with modifications
    return FluentThemeBuilder.create(
      '${baseTheme.id}_derived',
      '${baseTheme.name} (Modified)',
    )
        .withDescription('Derived from ${baseTheme.name}')
        .withColorPalette(ThemeColorPalette.material)
        .withTypographyStyle(TypographyStyle.modern)
        .withMinimalistDesign()
        .buildCustomTheme();
  }
}
