import 'package:flutter/material.dart';
import '../constants/theme_constants.dart';

/// Base configuration for theme settings
/// Centralizes all theme-specific configurations to eliminate magic numbers
abstract class ThemeConfiguration {
  /// Theme identifier
  String get themeId;

  /// Theme display name
  String get themeName;

  /// Theme description
  String get themeDescription;

  /// Primary color for the theme
  Color get primaryColor;

  /// Secondary color for the theme
  Color get secondaryColor;

  /// Background color for the theme
  Color get backgroundColor;

  /// Surface color for the theme
  Color get surfaceColor;

  /// Error color for the theme
  Color get errorColor;

  /// Primary text color
  Color get primaryTextColor;

  /// Secondary text color
  Color get secondaryTextColor;

  /// Font family configuration
  FontFamilyConfiguration get fontFamily;

  /// Typography configuration
  TypographyConfiguration get typography;

  /// Component configuration
  ComponentConfiguration get components;

  /// Shadow configuration
  ShadowConfiguration get shadows;

  /// Animation configuration
  AnimationConfiguration get animations;
}

/// Font family configuration
class FontFamilyConfiguration {
  const FontFamilyConfiguration({
    required this.primary,
    required this.secondary,
    required this.display,
    required this.monospace,
  });

  /// Default font family configuration
  const FontFamilyConfiguration.defaultConfig() : this(
    primary: 'Inter',
    secondary: 'Inter',
    display: 'Inter',
    monospace: 'JetBrains Mono',
  );

  /// Cyberpunk theme font configuration
  const FontFamilyConfiguration.cyberpunkConfig() : this(
    primary: 'Orbitron',
    secondary: 'Orbitron',
    display: 'Orbitron',
    monospace: 'JetBrains Mono',
  );

  /// Glassmorphism theme font configuration
  const FontFamilyConfiguration.glassmorphismConfig() : this(
    primary: 'SF Pro Display',
    secondary: 'SF Pro Display',
    display: 'SF Pro Display',
    monospace: 'SF Mono',
  );

  /// Neumorphism theme font configuration
  const FontFamilyConfiguration.neumorphismConfig() : this(
    primary: 'Nunito',
    secondary: 'Nunito',
    display: 'Nunito',
    monospace: 'JetBrains Mono',
  );

  /// Primary font family for body text
  final String primary;

  /// Secondary font family for headings
  final String secondary;

  /// Display font family for large text
  final String display;

  /// Monospace font family for code
  final String monospace;
}

/// Typography configuration
class TypographyConfiguration {
  const TypographyConfiguration({
    required this.baseFontSize,
    required this.fontSizeScale,
    required this.lineHeightScale,
    required this.letterSpacingScale,
    this.hasTextShadow = false,
    this.shadowColor,
    this.isResponsive = true,
  });

  /// Default typography configuration
  const TypographyConfiguration.defaultConfig() : this(
    baseFontSize: 16,
    fontSizeScale: 1,
    lineHeightScale: 1.4,
    letterSpacingScale: 0,
  );

  /// Cyberpunk typography configuration with glow effects
  const TypographyConfiguration.cyberpunkConfig() : this(
    baseFontSize: 16,
    fontSizeScale: 1,
    lineHeightScale: 1.3,
    letterSpacingScale: 0.5,
    hasTextShadow: true,
    shadowColor: const Color(0xFF00FFFF),
  );

  /// Glassmorphism typography configuration
  const TypographyConfiguration.glassmorphismConfig() : this(
    baseFontSize: 16,
    fontSizeScale: 1,
    lineHeightScale: 1.5,
    letterSpacingScale: 0.2,
  );

  /// Neumorphism typography configuration
  const TypographyConfiguration.neumorphismConfig() : this(
    baseFontSize: 16,
    fontSizeScale: 1,
    lineHeightScale: 1.4,
    letterSpacingScale: 0.1,
  );

  /// Base font size for body text
  final double baseFontSize;

  /// Font size scaling factor
  final double fontSizeScale;

  /// Line height scaling factor
  final double lineHeightScale;

  /// Letter spacing scaling factor
  final double letterSpacingScale;

  /// Whether text should have shadow effects
  final bool hasTextShadow;

  /// Shadow color for text effects
  final Color? shadowColor;

  /// Whether typography should be responsive
  final bool isResponsive;
}

/// Component configuration for UI elements
class ComponentConfiguration {
  const ComponentConfiguration({
    required this.borderRadius,
    required this.elevation,
    required this.padding,
    required this.buttonHeight,
    required this.inputHeight,
    this.hasGlassEffect = false,
    this.hasNeumorphismEffect = false,
    this.glassOpacity = 0.1,
  });

  /// Default component configuration
  ComponentConfiguration.defaultConfig()
      : borderRadius = ThemeConstants.defaultRadius,
        elevation = 2,
        padding = ThemeConstants.defaultPadding,
        buttonHeight = 48,
        inputHeight = 56,
        hasGlassEffect = false,
        hasNeumorphismEffect = false,
        glassOpacity = 0.1;

  /// Cyberpunk component configuration
  ComponentConfiguration.cyberpunkConfig()
      : borderRadius = ThemeConstants.smallRadius,
        elevation = 8,
        padding = ThemeConstants.defaultPadding,
        buttonHeight = 48,
        inputHeight = 56,
        hasGlassEffect = false,
        hasNeumorphismEffect = false,
        glassOpacity = 0.1;

  /// Glassmorphism component configuration
  ComponentConfiguration.glassmorphismConfig()
      : borderRadius = ThemeConstants.largeRadius,
        elevation = 0,
        padding = ThemeConstants.mediumPadding,
        buttonHeight = 52,
        inputHeight = 60,
        hasGlassEffect = true,
        hasNeumorphismEffect = false,
        glassOpacity = 0.15;

  /// Neumorphism component configuration
  ComponentConfiguration.neumorphismConfig()
      : borderRadius = ThemeConstants.mediumRadius,
        elevation = 0,
        padding = ThemeConstants.defaultPadding,
        buttonHeight = 48,
        inputHeight = 56,
        hasGlassEffect = false,
        hasNeumorphismEffect = true,
        glassOpacity = 0.1;

  /// Border radius for components
  final BorderRadius borderRadius;

  /// Default elevation for components
  final double elevation;

  /// Default padding for components
  final EdgeInsets padding;

  /// Standard button height
  final double buttonHeight;

  /// Standard input field height
  final double inputHeight;

  /// Whether components should have glass effect
  final bool hasGlassEffect;

  /// Whether components should have neumorphism effect
  final bool hasNeumorphismEffect;

  /// Opacity for glass effects
  final double glassOpacity;
}

/// Shadow configuration for theme effects
class ShadowConfiguration {
  const ShadowConfiguration({
    required this.cardShadow,
    required this.buttonShadow,
    required this.dialogShadow,
    this.hasNeonGlow = false,
    this.neonGlowColor,
    this.hasNeumorphismShadow = false,
  });

  /// Default shadow configuration
  ShadowConfiguration.defaultConfig()
      : cardShadow = ThemeConstants.cardShadow,
        buttonShadow = ThemeConstants.buttonShadow,
        dialogShadow = ThemeConstants.dialogShadow,
        hasNeonGlow = false,
        neonGlowColor = null,
        hasNeumorphismShadow = false;

  /// Cyberpunk shadow configuration with neon effects
  ShadowConfiguration.cyberpunkConfig()
      : cardShadow = ThemeConstants.cardShadow,
        buttonShadow = ThemeConstants.buttonShadow,
        dialogShadow = ThemeConstants.dialogShadow,
        hasNeonGlow = true,
        neonGlowColor = const Color(0xFF00FFFF),
        hasNeumorphismShadow = false;

  /// Glassmorphism shadow configuration (minimal shadows)
  ShadowConfiguration.glassmorphismConfig()
      : cardShadow = const [],
        buttonShadow = const [],
        dialogShadow = const [],
        hasNeonGlow = false,
        neonGlowColor = null,
        hasNeumorphismShadow = false;

  /// Neumorphism shadow configuration
  ShadowConfiguration.neumorphismConfig()
      : cardShadow = ThemeConstants.neumorphismShadow(
          lightShadow: Colors.white,
          // Colors.grey.shade300 equivalent
          darkShadow: const Color(0xFFD1D5DB),
        ),
        buttonShadow = ThemeConstants.neumorphismShadow(
          lightShadow: Colors.white,
          // Colors.grey.shade300 equivalent
          darkShadow: const Color(0xFFD1D5DB),
        ),
        dialogShadow = ThemeConstants.neumorphismShadow(
          lightShadow: Colors.white,
          // Colors.grey.shade300 equivalent
          darkShadow: const Color(0xFFD1D5DB),
        ),
        hasNeonGlow = false,
        neonGlowColor = null,
        hasNeumorphismShadow = true;

  /// Shadow configuration for cards
  final List<BoxShadow> cardShadow;

  /// Shadow configuration for buttons
  final List<BoxShadow> buttonShadow;

  /// Shadow configuration for dialogs
  final List<BoxShadow> dialogShadow;

  /// Whether to apply neon glow effects
  final bool hasNeonGlow;

  /// Color for neon glow effects
  final Color? neonGlowColor;

  /// Whether to apply neumorphism shadow effects
  final bool hasNeumorphismShadow;
}

/// Animation configuration for theme transitions
class AnimationConfiguration {
  const AnimationConfiguration({
    required this.fastDuration,
    required this.normalDuration,
    required this.slowDuration,
    required this.curve,
    this.hasCustomTransitions = false,
  });

  /// Default animation configuration
  const AnimationConfiguration.defaultConfig()
      : fastDuration = ThemeConstants.fastAnimation,
        normalDuration = ThemeConstants.normalAnimation,
        slowDuration = ThemeConstants.slowAnimation,
        curve = Curves.easeInOut,
        hasCustomTransitions = false;

  /// Cyberpunk animation configuration with custom effects
  const AnimationConfiguration.cyberpunkConfig()
      : fastDuration = ThemeConstants.fastAnimation,
        normalDuration = ThemeConstants.normalAnimation,
        slowDuration = ThemeConstants.slowAnimation,
        curve = Curves.easeInOutCubic,
        hasCustomTransitions = true;

  /// Glassmorphism animation configuration
  const AnimationConfiguration.glassmorphismConfig()
      : fastDuration = ThemeConstants.fastAnimation,
        normalDuration = ThemeConstants.normalAnimation,
        slowDuration = ThemeConstants.slowAnimation,
        curve = Curves.easeInOutQuart,
        hasCustomTransitions = false;

  /// Neumorphism animation configuration
  const AnimationConfiguration.neumorphismConfig()
      : fastDuration = ThemeConstants.fastAnimation,
        normalDuration = ThemeConstants.normalAnimation,
        slowDuration = ThemeConstants.slowAnimation,
        curve = Curves.easeInOutBack,
        hasCustomTransitions = false;

  /// Fast animation duration
  final Duration fastDuration;

  /// Normal animation duration
  final Duration normalDuration;

  /// Slow animation duration
  final Duration slowDuration;

  /// Animation curve
  final Curve curve;

  /// Whether to use custom transitions
  final bool hasCustomTransitions;
}
