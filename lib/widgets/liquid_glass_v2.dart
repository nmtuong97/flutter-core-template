import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/liquid_glass.dart' as lg;

/// Liquid Glass Widget V2 - Enhanced with flutter_liquid_glass package
///
/// This is a wrapper around the flutter_liquid_glass package that provides:
/// - Same API as our original LiquidGlass widget (backward compatible)
/// - Enhanced effects from the professional package
/// - Better performance optimizations
/// - Additional interactive animations
///
/// Migration from V1:
/// ```dart
/// // Old (V1 - custom BackdropFilter)
/// import 'package:flutter_theme_showcase/widgets/liquid_glass.dart';
/// LiquidGlass(blur: 24, child: MyWidget());
///
/// // New (V2 - package-based)
/// import 'package:flutter_theme_showcase/widgets/liquid_glass_v2.dart';
/// LiquidGlassV2(blur: 24, child: MyWidget());
/// ```
class LiquidGlassV2 extends StatelessWidget {
  const LiquidGlassV2({
    required this.child,
    super.key,
    this.blur = 24.0,
    this.tint,
    this.borderRadius = 20.0,
    this.borderColor,
    this.borderWidth = 0.5,
    this.enableBlur = true,
    this.padding,
    this.gradient,
    this.shadows,
    this.onTap,
    this.enableHapticFeedback = true,
    this.enableParallax = true,
    this.enableDynamicLight = true,
  });

  /// Child widget to display inside the glass container
  final Widget child;

  /// Blur sigma value (16-30 recommended)
  /// Maps to package's blurAmount
  final double blur;

  /// Tint overlay color for the glass effect
  /// Maps to package's baseColor
  final Color? tint;

  /// Corner radius (12-24px recommended)
  final double borderRadius;

  /// Border color for edge definition
  final Color? borderColor;

  /// Border width (0.5-1px recommended)
  final double borderWidth;

  /// Enable/disable blur effect
  final bool enableBlur;

  /// Optional padding inside the glass container
  final EdgeInsetsGeometry? padding;

  /// Optional gradient for specular light effect
  final Gradient? gradient;

  /// Optional shadows for elevation effect
  final List<BoxShadow>? shadows;

  /// Tap callback (new feature from package)
  final VoidCallback? onTap;

  /// Enable haptic feedback on tap
  final bool enableHapticFeedback;

  /// Enable parallax effect (new feature from package)
  final bool enableParallax;

  /// Enable dynamic light response (new feature from package)
  final bool enableDynamicLight;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Context-adaptive tint colors (same as V1)
    final effectiveTint = tint ??
        (isDark
            ? const Color(0x40000000) // rgba(black, 0.25)
            : const Color(0x26FFFFFF)); // rgba(white, 0.15)

    // Map our API to package config
    final config = lg.LiquidGlassConfig(
      baseColor: effectiveTint,
      opacity: effectiveTint.a,
      blurAmount: enableBlur ? blur : 0.0,
      borderRadius: BorderRadius.circular(borderRadius),
      border: borderWidth > 0
          ? Border.all(
              color: borderColor ?? const Color(0x33FFFFFF),
              width: borderWidth,
            )
          : null,
      gradient: gradient,
      shadows: shadows,
      enableParallax: enableParallax,
      enableDynamicLight: enableDynamicLight,
    );

    return lg.LiquidGlassContainer(
      config: config,
      padding: padding,
      onTap: onTap,
      enableHapticFeedback: enableHapticFeedback,
      child: child,
    );
  }
}

/// Animated Liquid Glass Widget V2
///
/// Enhanced version with smooth animations and interactive effects.
/// Wraps flutter_liquid_glass package with custom API.
class AnimatedLiquidGlassV2 extends StatelessWidget {
  const AnimatedLiquidGlassV2({
    required this.child,
    super.key,
    this.blur = 24.0,
    this.tint,
    this.borderRadius = 20.0,
    this.borderColor,
    this.borderWidth = 0.5,
    this.enableBlur = true,
    this.padding,
    this.gradient,
    this.shadows,
    this.onTap,
    this.onLongPress,
    this.hoverScale = 1.02,
    this.enableHapticFeedback = true,
    this.enableParallax = true,
    this.enableDynamicLight = true,
    this.enableMorphing = true,
  });

  final Widget child;
  final double blur;
  final Color? tint;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final bool enableBlur;
  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  final List<BoxShadow>? shadows;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double hoverScale;
  final bool enableHapticFeedback;
  final bool enableParallax;
  final bool enableDynamicLight;
  final bool enableMorphing;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveTint =
        tint ?? (isDark ? const Color(0x40000000) : const Color(0x26FFFFFF));

    // Enhanced config with morphing animations
    final config = lg.LiquidGlassConfig(
      baseColor: effectiveTint,
      opacity: effectiveTint.a,
      blurAmount: enableBlur ? blur : 0.0,
      borderRadius: BorderRadius.circular(borderRadius),
      border: borderWidth > 0
          ? Border.all(
              color: borderColor ?? const Color(0x33FFFFFF),
              width: borderWidth,
            )
          : null,
      gradient: gradient,
      shadows: shadows,
      enableParallax: enableParallax,
      enableDynamicLight: enableDynamicLight,
      enableMorphing: enableMorphing,
      refractionIntensity: 0.6,
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeOutCubic,
    );

    return lg.LiquidGlassContainer(
      config: config,
      padding: padding,
      onTap: onTap,
      onLongPress: onLongPress,
      enableHapticFeedback: enableHapticFeedback,
      child: child,
    );
  }
}

/// Liquid Glass Card V2 - Pre-configured card variant
///
/// Wraps flutter_liquid_glass's LiquidGlassCard with custom defaults.
class LiquidGlassCardV2 extends StatelessWidget {
  const LiquidGlassCardV2({
    required this.child,
    super.key,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.elevation = 2,
    this.blur = 20.0,
    this.tint,
    this.borderRadius = 16.0,
  });

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double elevation;
  final double blur;
  final Color? tint;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveTint =
        tint ?? (isDark ? const Color(0x33000000) : const Color(0x1AFFFFFF));

    final config = lg.LiquidGlassConfig(
      baseColor: effectiveTint,
      opacity: effectiveTint.a,
      blurAmount: blur,
      borderRadius: BorderRadius.circular(borderRadius),
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05 * elevation),
          blurRadius: 8 * elevation,
          offset: Offset(0, 4 * elevation),
        ),
      ],
    );

    return SizedBox(
      width: width,
      height: height,
      child: lg.LiquidGlassCard(
        config: config,
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

/// Liquid Glass Button V2 - Pre-configured button variant
///
/// Enhanced button with package's interactive effects.
class LiquidGlassButtonV2 extends StatelessWidget {
  const LiquidGlassButtonV2({
    required this.child,
    required this.onPressed,
    super.key,
    this.onLongPress,
    this.width,
    this.height = 48,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.isPrimary = false,
    this.blur = 20.0,
    this.borderRadius = 12.0,
    this.enableHapticFeedback = true,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final double? width;
  final double height;
  final EdgeInsetsGeometry padding;
  final bool isPrimary;
  final double blur;
  final double borderRadius;
  final bool enableHapticFeedback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseColor = isPrimary
        ? theme.colorScheme.primary.withValues(alpha: 0.3)
        : (isDark ? const Color(0x33000000) : const Color(0x1AFFFFFF));

    final config = lg.LiquidGlassConfig(
      baseColor: baseColor,
      opacity: baseColor.a,
      blurAmount: blur,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: isPrimary
            ? theme.colorScheme.primary.withValues(alpha: 0.5)
            : Colors.white.withValues(alpha: 0.2),
      ),
      refractionIntensity: 0.6,
    );

    return lg.LiquidGlassButton(
      config: config,
      onPressed: onPressed,
      onLongPressed: onLongPress,
      width: width,
      height: height,
      padding: padding,
      enableHapticFeedback: enableHapticFeedback,
      child: DefaultTextStyle(
        style: theme.textTheme.labelLarge!.copyWith(
          color: isPrimary
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        child: child,
      ),
    );
  }
}
