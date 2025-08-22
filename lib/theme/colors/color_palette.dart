import 'package:flutter/material.dart';
import '../constants/theme_constants.dart';

/// Type-safe color palette system
/// Provides consistent color management across all themes
abstract class ColorPalette {
  /// Primary colors
  Color get primary;
  Color get primaryVariant;
  Color get onPrimary;

  /// Secondary colors
  Color get secondary;
  Color get secondaryVariant;
  Color get onSecondary;

  /// Surface colors
  Color get surface;
  Color get surfaceVariant;
  Color get onSurface;
  Color get onSurfaceVariant;

  /// Background colors
  Color get background;
  Color get onBackground;

  /// Error colors
  Color get error;
  Color get errorVariant;
  Color get onError;

  /// Outline colors
  Color get outline;
  Color get outlineVariant;

  /// Shadow colors
  Color get shadow;
  Color get scrim;

  /// Inverse colors
  Color get inverseSurface;
  Color get onInverseSurface;
  Color get inversePrimary;

  /// Success colors (custom)
  Color get success;
  Color get onSuccess;

  /// Warning colors (custom)
  Color get warning;
  Color get onWarning;

  /// Info colors (custom)
  Color get info;
  Color get onInfo;

  /// Disabled colors
  Color get disabled =>
      onSurface.withValues(alpha: ThemeConstants.disabledOpacity);
  Color get disabledContainer =>
      surface.withValues(alpha: ThemeConstants.disabledOpacity);

  /// Hint colors
  Color get hint => onSurface.withValues(alpha: ThemeConstants.hintOpacity);

  /// Divider colors
  Color get divider => outline.withValues(alpha: ThemeConstants.dividerOpacity);

  /// Create ColorScheme from this palette
  ColorScheme toColorScheme(Brightness brightness);

  /// Get semantic colors for specific use cases
  SemanticColors get semantic => SemanticColors(this);
}

/// Semantic color groupings for specific UI components
class SemanticColors {
  const SemanticColors(this._palette);

  final ColorPalette _palette;

  /// Card colors
  CardColors get card => CardColors(_palette);

  /// Button colors
  ButtonColors get button => ButtonColors(_palette);

  /// Text colors
  TextColors get text => TextColors(_palette);

  /// Input colors
  InputColors get input => InputColors(_palette);

  /// Navigation colors
  NavigationColors get navigation => NavigationColors(_palette);

  /// Status colors
  StatusColors get status => StatusColors(_palette);
}

/// Card-specific colors
class CardColors {
  const CardColors(this._palette);

  final ColorPalette _palette;

  Color get background => _palette.surface;
  Color get border => _palette.outline.withValues(alpha: 0.12);
  Color get shadow => _palette.shadow.withValues(alpha: 0.08);
  Color get content => _palette.onSurface;
  Color get subtitle => _palette.onSurface.withValues(alpha: 0.6);
}

/// Button-specific colors
class ButtonColors {
  const ButtonColors(this._palette);

  final ColorPalette _palette;

  // Primary button
  Color get primaryBackground => _palette.primary;
  Color get primaryForeground => _palette.onPrimary;
  Color get primaryDisabled => _palette.disabled;

  // Secondary button
  Color get secondaryBackground => _palette.secondary;
  Color get secondaryForeground => _palette.onSecondary;
  Color get secondaryDisabled => _palette.disabled;

  // Outlined button
  Color get outlinedBorder => _palette.outline;
  Color get outlinedForeground => _palette.primary;
  Color get outlinedDisabled => _palette.disabled;

  // Text button
  Color get textForeground => _palette.primary;
  Color get textDisabled => _palette.disabled;
}

/// Text-specific colors
class TextColors {
  const TextColors(this._palette);

  final ColorPalette _palette;

  Color get primary => _palette.onSurface;
  Color get secondary => _palette.onSurface.withValues(alpha: 0.6);
  Color get disabled => _palette.disabled;
  Color get hint => _palette.hint;
  Color get link => _palette.primary;
  Color get linkVisited => _palette.primary.withValues(alpha: 0.8);
}

/// Input-specific colors
class InputColors {
  const InputColors(this._palette);

  final ColorPalette _palette;

  Color get background => _palette.surface;
  Color get border => _palette.outline;
  Color get borderFocused => _palette.primary;
  Color get borderError => _palette.error;
  Color get text => _palette.onSurface;
  Color get placeholder => _palette.hint;
  Color get label => _palette.onSurface.withValues(alpha: 0.8);
  Color get helperText => _palette.onSurface.withValues(alpha: 0.6);
  Color get errorText => _palette.error;
}

/// Navigation-specific colors
class NavigationColors {
  const NavigationColors(this._palette);

  final ColorPalette _palette;

  Color get background => _palette.surface;
  Color get selectedBackground => _palette.primary.withValues(alpha: 0.12);
  Color get selectedForeground => _palette.primary;
  Color get unselectedForeground => _palette.onSurface.withValues(alpha: 0.6);
  Color get indicator => _palette.primary;
  Color get divider => _palette.divider;
}

/// Status-specific colors
class StatusColors {
  const StatusColors(this._palette);

  final ColorPalette _palette;

  Color get success => _palette.success;
  Color get successBackground => _palette.success.withValues(alpha: 0.12);
  Color get onSuccess => _palette.onSuccess;

  Color get warning => _palette.warning;
  Color get warningBackground => _palette.warning.withValues(alpha: 0.12);
  Color get onWarning => _palette.onWarning;

  Color get error => _palette.error;
  Color get errorBackground => _palette.error.withValues(alpha: 0.12);
  Color get onError => _palette.onError;

  Color get info => _palette.info;
  Color get infoBackground => _palette.info.withValues(alpha: 0.12);
  Color get onInfo => _palette.onInfo;
}

/// Light theme color palette
class LightColorPalette extends ColorPalette {
  LightColorPalette({
    required this.seedColor,
    this.customSuccess,
    this.customWarning,
    this.customInfo,
  }) : _colorScheme = ColorScheme.fromSeed(
          seedColor: seedColor,
        );

  final Color seedColor;
  final Color? customSuccess;
  final Color? customWarning;
  final Color? customInfo;
  final ColorScheme _colorScheme;

  @override
  Color get primary => _colorScheme.primary;

  @override
  Color get primaryVariant => _colorScheme.primary.withValues(alpha: 0.8);

  @override
  Color get onPrimary => _colorScheme.onPrimary;

  @override
  Color get secondary => _colorScheme.secondary;

  @override
  Color get secondaryVariant => _colorScheme.secondary.withValues(alpha: 0.8);

  @override
  Color get onSecondary => _colorScheme.onSecondary;

  @override
  Color get surface => _colorScheme.surface;

  @override
  Color get surfaceVariant => _colorScheme.surfaceContainerHighest;

  @override
  Color get onSurface => _colorScheme.onSurface;

  @override
  Color get onSurfaceVariant => _colorScheme.onSurfaceVariant;

  @override
  Color get background => _colorScheme.surface;

  @override
  Color get onBackground => _colorScheme.onSurface;

  @override
  Color get error => _colorScheme.error;

  @override
  Color get errorVariant => _colorScheme.error.withValues(alpha: 0.8);

  @override
  Color get onError => _colorScheme.onError;

  @override
  Color get outline => _colorScheme.outline;

  @override
  Color get outlineVariant => _colorScheme.outlineVariant;

  @override
  Color get shadow => _colorScheme.shadow;

  @override
  Color get scrim => _colorScheme.scrim;

  @override
  Color get inverseSurface => _colorScheme.inverseSurface;

  @override
  Color get onInverseSurface => _colorScheme.onInverseSurface;

  @override
  Color get inversePrimary => _colorScheme.inversePrimary;

  @override
  Color get success => customSuccess ?? const Color(0xFF4CAF50);

  @override
  Color get onSuccess => Colors.white;

  @override
  Color get warning => customWarning ?? const Color(0xFFFF9800);

  @override
  Color get onWarning => Colors.white;

  @override
  Color get info => customInfo ?? const Color(0xFF2196F3);

  @override
  Color get onInfo => Colors.white;

  @override
  ColorScheme toColorScheme(Brightness brightness) => _colorScheme;
}

/// Dark theme color palette
class DarkColorPalette extends ColorPalette {
  DarkColorPalette({
    required this.seedColor,
    this.customSuccess,
    this.customWarning,
    this.customInfo,
  }) : _colorScheme = ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        );

  final Color seedColor;
  final Color? customSuccess;
  final Color? customWarning;
  final Color? customInfo;
  final ColorScheme _colorScheme;

  @override
  Color get primary => _colorScheme.primary;

  @override
  Color get primaryVariant => _colorScheme.primary.withValues(alpha: 0.8);

  @override
  Color get onPrimary => _colorScheme.onPrimary;

  @override
  Color get secondary => _colorScheme.secondary;

  @override
  Color get secondaryVariant => _colorScheme.secondary.withValues(alpha: 0.8);

  @override
  Color get onSecondary => _colorScheme.onSecondary;

  @override
  Color get surface => _colorScheme.surface;

  @override
  Color get surfaceVariant => _colorScheme.surfaceContainerHighest;

  @override
  Color get onSurface => _colorScheme.onSurface;

  @override
  Color get onSurfaceVariant => _colorScheme.onSurfaceVariant;

  @override
  Color get background => _colorScheme.surface;

  @override
  Color get onBackground => _colorScheme.onSurface;

  @override
  Color get error => _colorScheme.error;

  @override
  Color get errorVariant => _colorScheme.error.withValues(alpha: 0.8);

  @override
  Color get onError => _colorScheme.onError;

  @override
  Color get outline => _colorScheme.outline;

  @override
  Color get outlineVariant => _colorScheme.outlineVariant;

  @override
  Color get shadow => _colorScheme.shadow;

  @override
  Color get scrim => _colorScheme.scrim;

  @override
  Color get inverseSurface => _colorScheme.inverseSurface;

  @override
  Color get onInverseSurface => _colorScheme.onInverseSurface;

  @override
  Color get inversePrimary => _colorScheme.inversePrimary;

  @override
  Color get success => customSuccess ?? const Color(0xFF66BB6A);

  @override
  Color get onSuccess => Colors.black;

  @override
  Color get warning => customWarning ?? const Color(0xFFFFB74D);

  @override
  Color get onWarning => Colors.black;

  @override
  Color get info => customInfo ?? const Color(0xFF64B5F6);

  @override
  Color get onInfo => Colors.black;

  @override
  ColorScheme toColorScheme(Brightness brightness) => _colorScheme;
}

/// Color palette factory for creating themed palettes
class ColorPaletteFactory {
  const ColorPaletteFactory._();

  /// Create a light color palette
  static LightColorPalette light({
    required Color seedColor,
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return LightColorPalette(
      seedColor: seedColor,
      customSuccess: success,
      customWarning: warning,
      customInfo: info,
    );
  }

  /// Create a dark color palette
  static DarkColorPalette dark({
    required Color seedColor,
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return DarkColorPalette(
      seedColor: seedColor,
      customSuccess: success,
      customWarning: warning,
      customInfo: info,
    );
  }

  /// Create both light and dark palettes
  static ColorPalettePair pair({
    required Color seedColor,
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return ColorPalettePair(
      light: light(
        seedColor: seedColor,
        success: success,
        warning: warning,
        info: info,
      ),
      dark: dark(
        seedColor: seedColor,
        success: success,
        warning: warning,
        info: info,
      ),
    );
  }
}

/// Pair of light and dark color palettes
class ColorPalettePair {
  const ColorPalettePair({
    required this.light,
    required this.dark,
  });

  final LightColorPalette light;
  final DarkColorPalette dark;

  /// Get palette for specific brightness
  ColorPalette forBrightness(Brightness brightness) {
    return brightness == Brightness.light ? light : dark;
  }
}

/// Predefined color palettes for common themes
class PredefinedPalettes {
  const PredefinedPalettes._();

  /// Material Design default palette
  static ColorPalettePair get material => ColorPaletteFactory.pair(
        seedColor: const Color(0xFF6750A4),
      );

  /// Blue palette
  static ColorPalettePair get blue => ColorPaletteFactory.pair(
        seedColor: Colors.blue,
      );

  /// Green palette
  static ColorPalettePair get green => ColorPaletteFactory.pair(
        seedColor: Colors.green,
      );

  /// Purple palette
  static ColorPalettePair get purple => ColorPaletteFactory.pair(
        seedColor: Colors.purple,
      );

  /// Orange palette
  static ColorPalettePair get orange => ColorPaletteFactory.pair(
        seedColor: Colors.orange,
      );

  /// Red palette
  static ColorPalettePair get red => ColorPaletteFactory.pair(
        seedColor: Colors.red,
      );

  /// Teal palette
  static ColorPalettePair get teal => ColorPaletteFactory.pair(
        seedColor: Colors.teal,
      );

  /// Indigo palette
  static ColorPalettePair get indigo => ColorPaletteFactory.pair(
        seedColor: Colors.indigo,
      );
}
