import 'dart:ui';

import 'package:flutter/material.dart';

import 'liquid_glass.dart'; // Now uses package-based implementation

/// Liquid Glass Components - Extended UI components for Liquid Glass theme
///
/// **PRODUCTION VERSION**: All components now use package-based LiquidGlass for
/// enhanced features
///
/// This file provides a complete set of UI components with glass effect:
/// - Input components (TextField, Button, Switch)
/// - Container components (Dialog, ListTile, GridTile)
/// - Navigation components (BottomNavBar, TabBar)
///
/// All components are designed to work seamlessly with the Liquid Glass theme
/// and can be used independently or as part of the theme system.

// ============================================================================
// INPUT COMPONENTS
// ============================================================================

/// Liquid Glass TextField - Text input with glass effect
///
/// Features:
/// - Glass background with blur
/// - Subtle border for focus states
/// - Smooth transitions
class LiquidGlassTextField extends StatefulWidget {
  const LiquidGlassTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.blur = 20.0,
    this.tint,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final double blur;
  final Color? tint;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  State<LiquidGlassTextField> createState() => _LiquidGlassTextFieldState();
}

class _LiquidGlassTextFieldState extends State<LiquidGlassTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blur,
            sigmaY: widget.blur,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: widget.tint ??
                  (isDark ? const Color(0x40000000) : const Color(0x26FFFFFF)),
              border: Border.all(
                color: _isFocused
                    ? theme.colorScheme.primary
                    : (isDark
                        ? const Color(0x40FFFFFF)
                        : const Color(0x40000000)),
                width: _isFocused ? 2.0 : 0.75,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            padding: widget.padding,
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              obscureText: widget.obscureText,
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              decoration: widget.decoration?.copyWith(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ) ??
                  const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Liquid Glass Button - Button with glass effect
///
/// Features:
/// - Glass background with blur
/// - Ripple effect on tap
/// - Scale animation
/// - Customizable colors
class LiquidGlassButton extends StatelessWidget {
  const LiquidGlassButton({
    required this.onPressed,
    required this.child,
    super.key,
    this.blur = 20.0,
    this.tint,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.isPrimary = false,
    this.width,
    this.height,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double blur;
  final Color? tint;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isPrimary;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveTint = tint ??
        (isPrimary
            ? theme.colorScheme.primary.withValues(alpha: 0.9)
            : (isDark ? const Color(0x40000000) : const Color(0x26FFFFFF)));

    return AnimatedLiquidGlass(
      blur: blur,
      tint: effectiveTint,
      borderRadius: borderRadius,
      padding: padding,
      hoverScale: 1.03,
      animationDuration: const Duration(milliseconds: 200),
      onTap: onPressed,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: DefaultTextStyle(
            style: theme.textTheme.labelLarge?.copyWith(
                  color: isPrimary ? Colors.white : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ) ??
                const TextStyle(),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Liquid Glass Icon Button - Icon button with glass effect
class LiquidGlassIconButton extends StatelessWidget {
  const LiquidGlassIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.blur = 20.0,
    this.tint,
    this.size = 48.0,
    this.iconSize = 24.0,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double blur;
  final Color? tint;
  final double size;
  final double iconSize;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final button = AnimatedLiquidGlass(
      blur: blur,
      tint: tint,
      borderRadius: size / 2,
      hoverScale: 1.05,
      onTap: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          icon,
          size: iconSize,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        child: button,
      );
    }

    return button;
  }
}

/// Liquid Glass Switch - Toggle switch with glass effect
class LiquidGlassSwitch extends StatelessWidget {
  const LiquidGlassSwitch({
    required this.value,
    required this.onChanged,
    super.key,
    this.blur = 16.0,
    this.activeColor,
    this.inactiveColor,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double blur;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 56,
        height: 32,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: value
                    ? (activeColor ?? theme.colorScheme.primary)
                        .withValues(alpha: 0.3)
                    : (inactiveColor ??
                        (isDark
                            ? const Color(0x40000000)
                            : const Color(0x26FFFFFF))),
                border: Border.all(
                  color: value
                      ? (activeColor ?? theme.colorScheme.primary)
                      : (isDark
                          ? const Color(0x40FFFFFF)
                          : const Color(0x40000000)),
                  width: 0.75,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    alignment:
                        value ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 26,
                      height: 26,
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: value
                            ? (activeColor ?? theme.colorScheme.primary)
                            : theme.colorScheme.onSurface
                                .withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// CONTAINER COMPONENTS
// ============================================================================

/// Liquid Glass Dialog - Dialog with glass effect
class LiquidGlassDialog extends StatelessWidget {
  const LiquidGlassDialog({
    required this.content,
    super.key,
    this.title,
    this.actions,
    this.blur = 30.0,
    this.tint,
    this.borderRadius = 24.0,
  });

  final Widget? title;
  final Widget content;
  final List<Widget>? actions;
  final double blur;
  final Color? tint;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: LiquidGlass(
        blur: blur,
        tint: tint,
        borderRadius: borderRadius,
        borderWidth: 1,
        padding: const EdgeInsets.all(24),
        shadows: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              DefaultTextStyle(
                style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ) ??
                    const TextStyle(),
                child: title!,
              ),
              const SizedBox(height: 16),
            ],
            DefaultTextStyle(
              style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ) ??
                  const TextStyle(),
              child: content,
            ),
            if (actions != null && actions!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!
                    .map(
                      (action) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: action,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Show the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    Widget? title,
    List<Widget>? actions,
    double blur = 30.0,
    Color? tint,
    double borderRadius = 24.0,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => LiquidGlassDialog(
        title: title,
        content: content,
        actions: actions,
        blur: blur,
        tint: tint,
        borderRadius: borderRadius,
      ),
    );
  }
}

/// Liquid Glass List Tile - List item with glass effect
class LiquidGlassListTile extends StatelessWidget {
  const LiquidGlassListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.blur = 20.0,
    this.tint,
    this.borderRadius = 16.0,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double blur;
  final Color? tint;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: margin,
      child: AnimatedLiquidGlass(
        blur: blur,
        tint: tint,
        borderRadius: borderRadius,
        hoverScale: 1.01,
        onTap: onTap,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    DefaultTextStyle(
                      style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ) ??
                          const TextStyle(),
                      child: title!,
                    ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    DefaultTextStyle(
                      style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(178),
                          ) ??
                          const TextStyle(),
                      child: subtitle!,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Liquid Glass Grid Tile - Grid item with glass effect
class LiquidGlassGridTile extends StatelessWidget {
  const LiquidGlassGridTile({
    required this.child,
    super.key,
    this.onTap,
    this.blur = 20.0,
    this.tint,
    this.borderRadius = 20.0,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double blur;
  final Color? tint;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return AnimatedLiquidGlass(
      blur: blur,
      tint: tint,
      borderRadius: borderRadius,
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      child: Center(child: child),
    );
  }
}

// ============================================================================
// NAVIGATION COMPONENTS
// ============================================================================

/// Liquid Glass Bottom Navigation Bar - Bottom nav with glass effect
class LiquidGlassBottomNavBar extends StatelessWidget {
  const LiquidGlassBottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
    this.blur = 30.0,
    this.tint,
    this.height = 70.0,
  });

  final List<LiquidGlassBottomNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double blur;
  final Color? tint;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LiquidGlass(
      blur: blur,
      tint: tint,
      borderRadius: 0,
      borderWidth: 0,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, -2),
        ),
      ],
      child: SafeArea(
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (index) => _NavBarItem(
                item: items[index],
                isSelected: index == currentIndex,
                onTap: () => onTap(index),
                isDark: isDark,
                theme: theme,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LiquidGlassBottomNavBarItem {
  const LiquidGlassBottomNavBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
    required this.theme,
  });

  final LiquidGlassBottomNavBarItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface.withAlpha(153);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected && item.activeIcon != null
                    ? item.activeIcon
                    : item.icon,
                color: color,
                size: 24,
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Liquid Glass Tab Bar - Tab bar with glass effect
class LiquidGlassTabBar extends StatelessWidget {
  const LiquidGlassTabBar({
    required this.tabs,
    required this.controller,
    super.key,
    this.blur = 20.0,
    this.tint,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(4),
    this.indicatorPadding = const EdgeInsets.all(2),
  });

  final List<Widget> tabs;
  final TabController controller;
  final double blur;
  final Color? tint;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry indicatorPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LiquidGlass(
      blur: blur,
      tint: tint,
      borderRadius: borderRadius,
      padding: padding,
      child: TabBar(
        controller: controller,
        tabs: tabs,
        indicator: BoxDecoration(
          color: theme.colorScheme.primary.withAlpha(51),
          borderRadius: BorderRadius.circular(borderRadius - 4),
        ),
        indicatorPadding: indicatorPadding,
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: theme.colorScheme.onSurface.withAlpha(153),
        labelStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: theme.textTheme.labelLarge,
        dividerColor: Colors.transparent,
      ),
    );
  }
}
