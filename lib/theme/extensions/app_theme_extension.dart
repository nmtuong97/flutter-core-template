import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Extension for Theme to add custom properties
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.cardBackgroundColor,
    required this.videoControlsBackground,
    required this.bottomNavBarBackground,
    required this.bottomNavBarInactiveColor,
    required this.bottomNavBarActiveColor,
    required this.defaultBorderRadius,
    required this.cardBorderRadius,
    required this.buttonBorderRadius,
    required this.dialogBorderRadius,
    required this.defaultPadding,
    required this.cardPadding,
    required this.buttonPadding,
    required this.dialogPadding,
    required this.videoOverlayColor,
    this.cardShadow,
    this.buttonShadow,
    this.dialogShadow,
    this.buttonGradient,
    this.cardGradient,
  });

  /// Create default instance for light theme
  factory AppThemeExtension.light() {
    return AppThemeExtension(
      cardBackgroundColor: Colors.white,
      videoControlsBackground: Colors.black.withAlpha((255 * 0.7).round()),
      bottomNavBarBackground: Colors.white,
      bottomNavBarInactiveColor: Colors.grey.shade600,
      bottomNavBarActiveColor: Colors.blue,
      defaultBorderRadius: BorderRadius.circular(8.r),
      cardBorderRadius: BorderRadius.circular(12.r),
      buttonBorderRadius: BorderRadius.circular(8.r),
      dialogBorderRadius: BorderRadius.circular(16.r),
      cardShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((255 * 0.1).round()),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      buttonShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((255 * 0.1).round()),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      dialogShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((255 * 0.2).round()),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      defaultPadding: EdgeInsets.all(16.r),
      cardPadding: EdgeInsets.all(16.r),
      buttonPadding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      dialogPadding: EdgeInsets.all(24.r),
      videoOverlayColor: Colors.black.withAlpha((255 * 0.5).round()),
    );
  }

  /// Create default instance for dark theme
  factory AppThemeExtension.dark() {
    return AppThemeExtension(
      cardBackgroundColor: const Color(0xFF1E1E1E),
      videoControlsBackground: Colors.black.withAlpha((255 * 0.8).round()),
      bottomNavBarBackground: const Color(0xFF121212),
      bottomNavBarInactiveColor: Colors.grey.shade400,
      bottomNavBarActiveColor: Colors.blue.shade300,
      defaultBorderRadius: BorderRadius.circular(8.r),
      cardBorderRadius: BorderRadius.circular(12.r),
      buttonBorderRadius: BorderRadius.circular(8.r),
      dialogBorderRadius: BorderRadius.circular(16.r),
      cardShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((255 * 0.3).round()),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      buttonShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((255 * 0.3).round()),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      dialogShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((255 * 0.4).round()),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      defaultPadding: EdgeInsets.all(16.r),
      cardPadding: EdgeInsets.all(16.r),
      buttonPadding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      dialogPadding: EdgeInsets.all(24.r),
      videoOverlayColor: Colors.black.withAlpha((255 * 0.7).round()),
    );
  }

  /// Background color of the card
  final Color cardBackgroundColor;

  /// Background color of video controls
  final Color videoControlsBackground;

  /// Background color of the bottom navigation bar
  final Color bottomNavBarBackground;

  /// Color of inactive icon in bottom navigation bar
  final Color bottomNavBarInactiveColor;

  /// Color of active icon in bottom navigation bar
  final Color bottomNavBarActiveColor;

  /// Default border radius
  final BorderRadius defaultBorderRadius;

  /// Border radius for card
  final BorderRadius cardBorderRadius;

  /// Border radius for button
  final BorderRadius buttonBorderRadius;

  /// Border radius for dialog
  final BorderRadius dialogBorderRadius;

  /// Shadow for card
  final List<BoxShadow>? cardShadow;

  /// Shadow for button
  final List<BoxShadow>? buttonShadow;

  /// Shadow for dialog
  final List<BoxShadow>? dialogShadow;

  /// Default padding
  final EdgeInsetsGeometry defaultPadding;

  /// Padding for card
  final EdgeInsetsGeometry cardPadding;

  /// Padding for button
  final EdgeInsetsGeometry buttonPadding;

  /// Padding for dialog
  final EdgeInsetsGeometry dialogPadding;

  /// Overlay color for video controls
  final Color videoOverlayColor;

  /// Gradient color for button
  final Gradient? buttonGradient;

  /// Gradient color for card
  final Gradient? cardGradient;

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? cardBackgroundColor,
    Color? videoControlsBackground,
    Color? bottomNavBarBackground,
    Color? bottomNavBarInactiveColor,
    Color? bottomNavBarActiveColor,
    BorderRadius? defaultBorderRadius,
    BorderRadius? cardBorderRadius,
    BorderRadius? buttonBorderRadius,
    BorderRadius? dialogBorderRadius,
    List<BoxShadow>? cardShadow,
    List<BoxShadow>? buttonShadow,
    List<BoxShadow>? dialogShadow,
    EdgeInsetsGeometry? defaultPadding,
    EdgeInsetsGeometry? cardPadding,
    EdgeInsetsGeometry? buttonPadding,
    EdgeInsetsGeometry? dialogPadding,
    Color? videoOverlayColor,
    Gradient? buttonGradient,
    Gradient? cardGradient,
  }) {
    return AppThemeExtension(
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      videoControlsBackground:
          videoControlsBackground ?? this.videoControlsBackground,
      bottomNavBarBackground:
          bottomNavBarBackground ?? this.bottomNavBarBackground,
      bottomNavBarInactiveColor:
          bottomNavBarInactiveColor ?? this.bottomNavBarInactiveColor,
      bottomNavBarActiveColor:
          bottomNavBarActiveColor ?? this.bottomNavBarActiveColor,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
      dialogBorderRadius: dialogBorderRadius ?? this.dialogBorderRadius,
      cardShadow: cardShadow ?? this.cardShadow,
      buttonShadow: buttonShadow ?? this.buttonShadow,
      dialogShadow: dialogShadow ?? this.dialogShadow,
      defaultPadding: defaultPadding ?? this.defaultPadding,
      cardPadding: cardPadding ?? this.cardPadding,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      dialogPadding: dialogPadding ?? this.dialogPadding,
      videoOverlayColor: videoOverlayColor ?? this.videoOverlayColor,
      buttonGradient: buttonGradient ?? this.buttonGradient,
      cardGradient: cardGradient ?? this.cardGradient,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      cardBackgroundColor:
          Color.lerp(cardBackgroundColor, other.cardBackgroundColor, t)!,
      videoControlsBackground: Color.lerp(
        videoControlsBackground,
        other.videoControlsBackground,
        t,
      )!,
      bottomNavBarBackground:
          Color.lerp(bottomNavBarBackground, other.bottomNavBarBackground, t)!,
      bottomNavBarInactiveColor: Color.lerp(
        bottomNavBarInactiveColor,
        other.bottomNavBarInactiveColor,
        t,
      )!,
      bottomNavBarActiveColor: Color.lerp(
        bottomNavBarActiveColor,
        other.bottomNavBarActiveColor,
        t,
      )!,
      defaultBorderRadius:
          BorderRadius.lerp(defaultBorderRadius, other.defaultBorderRadius, t)!,
      cardBorderRadius:
          BorderRadius.lerp(cardBorderRadius, other.cardBorderRadius, t)!,
      buttonBorderRadius:
          BorderRadius.lerp(buttonBorderRadius, other.buttonBorderRadius, t)!,
      dialogBorderRadius:
          BorderRadius.lerp(dialogBorderRadius, other.dialogBorderRadius, t)!,
      cardShadow: t < 0.5 ? cardShadow : other.cardShadow,
      buttonShadow: t < 0.5 ? buttonShadow : other.buttonShadow,
      dialogShadow: t < 0.5 ? dialogShadow : other.dialogShadow,
      defaultPadding:
          EdgeInsetsGeometry.lerp(defaultPadding, other.defaultPadding, t)!,
      cardPadding: EdgeInsetsGeometry.lerp(cardPadding, other.cardPadding, t)!,
      buttonPadding:
          EdgeInsetsGeometry.lerp(buttonPadding, other.buttonPadding, t)!,
      dialogPadding:
          EdgeInsetsGeometry.lerp(dialogPadding, other.dialogPadding, t)!,
      videoOverlayColor:
          Color.lerp(videoOverlayColor, other.videoOverlayColor, t)!,
      buttonGradient: Gradient.lerp(buttonGradient, other.buttonGradient, t),
      cardGradient: Gradient.lerp(cardGradient, other.cardGradient, t),
    );
  }
}

/// Extension cho BuildContext để dễ dàng truy cập AppThemeExtension
extension AppThemeExtensionContext on BuildContext {
  /// Lấy AppThemeExtension từ Theme
  AppThemeExtension get appTheme =>
      Theme.of(this).extension<AppThemeExtension>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? AppThemeExtension.dark()
          : AppThemeExtension.light());
}
