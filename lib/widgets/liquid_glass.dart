import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/liquid_glass.dart' as lg;

/// Liquid Glass Widget - Base component for glassmorphism effect
///
/// **PRODUCTION VERSION**: Now uses flutter_liquid_glass package for enhanced features
///
/// Implements the Liquid Glass UI design specification with:
/// - Multi-layer transparency and depth
/// - Dynamic light diffusion via specular highlights
/// - Material simulation through blur and gradient
/// - Micro-motion feedback on interaction
/// - Context-adaptive colors for optimal readability
///
/// This component is designed for use with:
/// - System overlays (status bar, dock)
/// - Floating controls (music player, chat heads)
/// - Dialogs and modal sheets
/// - Navigation bars
/// - Interactive cards and tiles
///
/// Performance considerations:
/// - BackdropFilter is GPU-intensive
/// - Consider disabling blur on low-end devices (use fallback)
/// - Avoid using on complex/animated backgrounds
/// - Not recommended for dense text areas
class LiquidGlass extends StatelessWidget {
  const LiquidGlass({
    super.key,
    required this.child,
    this.blur = 24.0,
    this.tint,
    this.borderRadius = 20.0,
    this.borderColor,
    this.borderWidth = 0.5,
    this.enableBlur = true,
    this.padding,
    this.gradient,
    this.shadows,
  });

  /// Child widget to display inside the glass container
  final Widget child;

  /// Blur sigma value (16-30 recommended per spec)
  /// Higher values = more blur, but heavier GPU load
  final double blur;

  /// Tint overlay color for the glass effect
  /// Light mode default: rgba(white, 0.15)
  /// Dark mode default: rgba(black, 0.25)
  final Color? tint;

  /// Corner radius (12-24px recommended per spec)
  final double borderRadius;

  /// Border color for edge definition
  /// Default: rgba(white, 0.2)
  final Color? borderColor;

  /// Border width (0.5-1px recommended per spec)
  final double borderWidth;

  /// Enable/disable blur effect (performance optimization)
  /// Set to false for low-end devices
  final bool enableBlur;

  /// Optional padding inside the glass container
  final EdgeInsetsGeometry? padding;

  /// Optional gradient for specular light effect
  /// Typically placed at top-left corner
  final Gradient? gradient;

  /// Optional shadows for elevation effect
  /// Recommended: blur 8-12, opacity 0.05-0.1
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Context-adaptive tint colors per spec (same as V1 for compatibility)
    final effectiveTint = tint ??
        (isDark
            ? const Color(0x40000000) // rgba(black, 0.25)
            : const Color(0x26FFFFFF)); // rgba(white, 0.15)

    // Map V1 API to package config for enhanced features
    final config = lg.LiquidGlassConfig(
      baseColor: effectiveTint,
      opacity: effectiveTint.opacity,
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
      // Enhanced features from package (optional, can be toggled)
      refractionIntensity: 0.5,
      enableSpecularHighlight: true,
    );

    return lg.LiquidGlassContainer(
      config: config,
      padding: padding,
      child: child,
    );
  }
}

/// Animated Liquid Glass - Interactive variant with micro-motion feedback
///
/// Provides smooth animations and hover effects (<300ms per spec).
/// Ideal for:
/// - Interactive cards
/// - Buttons with glass effect
/// - Hover-responsive controls
///
/// Supports:
/// - Scale animation (< 5% per spec)
/// - Color transitions
/// - Blur intensity changes
class AnimatedLiquidGlass extends StatefulWidget {
  const AnimatedLiquidGlass({
    super.key,
    required this.child,
    this.blur = 24.0,
    this.tint,
    this.borderRadius = 20.0,
    this.borderColor,
    this.borderWidth = 0.5,
    this.enableBlur = true,
    this.padding,
    this.gradient,
    this.shadows,
    this.hoverBlur,
    this.hoverTint,
    this.hoverScale = 1.02,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeOutCubic,
    this.onTap,
    this.onLongPress,
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

  /// Blur intensity on hover
  final double? hoverBlur;

  /// Tint color on hover
  final Color? hoverTint;

  /// Scale factor on hover (1.0-1.05 recommended, <5% per spec)
  final double hoverScale;

  /// Animation duration (<300ms per spec)
  final Duration animationDuration;

  /// Animation curve (easeOutCubic recommended per spec)
  final Curve animationCurve;

  /// Tap callback
  final VoidCallback? onTap;

  /// Long press callback
  final VoidCallback? onLongPress;

  @override
  State<AnimatedLiquidGlass> createState() => _AnimatedLiquidGlassState();
}

class _AnimatedLiquidGlassState extends State<AnimatedLiquidGlass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      ),
    );

    _blurAnimation = Tween<double>(
      begin: widget.blur,
      end: widget.hoverBlur ?? widget.blur * 1.2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter() {
    setState(() => _isHovered = true);
    _controller.forward();
  }

  void _onExit() {
    setState(() => _isHovered = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: LiquidGlass(
                blur: _blurAnimation.value,
                tint: _isHovered && widget.hoverTint != null
                    ? widget.hoverTint
                    : widget.tint,
                borderRadius: widget.borderRadius,
                borderColor: widget.borderColor,
                borderWidth: widget.borderWidth,
                enableBlur: widget.enableBlur,
                padding: widget.padding,
                gradient: widget.gradient,
                shadows: widget.shadows,
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Liquid Glass Card - Pre-configured card with glass effect
///
/// Convenient wrapper for common card use cases.
class LiquidGlassCard extends StatelessWidget {
  const LiquidGlassCard({
    super.key,
    required this.child,
    this.blur = 24.0,
    this.tint,
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(8.0),
    this.enableBlur = true,
    this.elevation = true,
    this.onTap,
  });

  final Widget child;
  final double blur;
  final Color? tint;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool enableBlur;
  final bool elevation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final widget = LiquidGlass(
      blur: blur,
      tint: tint,
      borderRadius: borderRadius,
      enableBlur: enableBlur,
      padding: padding,
      shadows: elevation
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
          : null,
      child: child,
    );

    return Padding(
      padding: margin,
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              child: widget,
            )
          : widget,
    );
  }
}

/// Liquid Glass App Bar - Glass effect app bar
///
/// Provides a floating app bar with glass effect and blur.
class LiquidGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LiquidGlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.blur = 24.0,
    this.tint,
    this.height = 56.0,
    this.elevation = true,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final double blur;
  final Color? tint;
  final double height;
  final bool elevation;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      blur: blur,
      tint: tint,
      borderRadius: 0,
      enableBlur: true,
      borderWidth: 0,
      shadows: elevation
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
          : null,
      child: SafeArea(
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              if (leading != null) leading!,
              if (leading == null) const SizedBox(width: 16),
              Expanded(
                child: title ?? const SizedBox.shrink(),
              ),
              if (actions != null) ...actions!,
              if (actions == null) const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

/// Liquid Glass Bottom Sheet - Modal sheet with glass effect
///
/// Pre-configured bottom sheet with optimal glass parameters.
class LiquidGlassBottomSheet extends StatelessWidget {
  const LiquidGlassBottomSheet({
    super.key,
    required this.child,
    this.blur = 30.0,
    this.tint,
    this.borderRadius = 24.0,
    this.padding = const EdgeInsets.all(24.0),
    this.enableBlur = true,
  });

  final Widget child;
  final double blur;
  final Color? tint;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool enableBlur;

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      blur: blur,
      tint: tint,
      borderRadius: borderRadius,
      enableBlur: enableBlur,
      borderWidth: 1.0,
      padding: padding,
      child: child,
    );
  }

  /// Show the bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double blur = 30.0,
    Color? tint,
    double borderRadius = 24.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24.0),
    bool enableBlur = true,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      builder: (context) => LiquidGlassBottomSheet(
        blur: blur,
        tint: tint,
        borderRadius: borderRadius,
        padding: padding,
        enableBlur: enableBlur,
        child: child,
      ),
    );
  }
}
