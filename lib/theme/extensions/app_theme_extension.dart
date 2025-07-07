import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Extension cho Theme để thêm các thuộc tính tùy chỉnh
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  /// Màu nền của card
  final Color cardBackgroundColor;
  
  /// Màu nền của video controls
  final Color videoControlsBackground;
  
  /// Màu nền của bottom navigation bar
  final Color bottomNavBarBackground;
  
  /// Màu của icon không active trong bottom navigation bar
  final Color bottomNavBarInactiveColor;
  
  /// Màu của icon active trong bottom navigation bar
  final Color bottomNavBarActiveColor;
  
  /// Border radius mặc định
  final BorderRadius defaultBorderRadius;
  
  /// Border radius cho card
  final BorderRadius cardBorderRadius;
  
  /// Border radius cho button
  final BorderRadius buttonBorderRadius;
  
  /// Border radius cho dialog
  final BorderRadius dialogBorderRadius;
  
  /// Shadow cho card
  final List<BoxShadow>? cardShadow;
  
  /// Shadow cho button
  final List<BoxShadow>? buttonShadow;
  
  /// Shadow cho dialog
  final List<BoxShadow>? dialogShadow;
  
  /// Padding mặc định
  final EdgeInsetsGeometry defaultPadding;
  
  /// Padding cho card
  final EdgeInsetsGeometry cardPadding;
  
  /// Padding cho button
  final EdgeInsetsGeometry buttonPadding;
  
  /// Padding cho dialog
  final EdgeInsetsGeometry dialogPadding;
  
  /// Màu overlay cho video controls
  final Color videoOverlayColor;
  
  /// Màu gradient cho button
  final Gradient? buttonGradient;
  
  /// Màu gradient cho card
  final Gradient? cardGradient;
  
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
    this.cardShadow,
    this.buttonShadow,
    this.dialogShadow,
    required this.defaultPadding,
    required this.cardPadding,
    required this.buttonPadding,
    required this.dialogPadding,
    required this.videoOverlayColor,
    this.buttonGradient,
    this.cardGradient,
  });
  
  /// Tạo instance mặc định cho light theme
  factory AppThemeExtension.light() {
    return AppThemeExtension(
      cardBackgroundColor: Colors.white,
      videoControlsBackground: Colors.black.withOpacity(0.7),
      bottomNavBarBackground: Colors.white,
      bottomNavBarInactiveColor: Colors.grey.shade600,
      bottomNavBarActiveColor: Colors.blue,
      defaultBorderRadius: BorderRadius.circular(8.r),
      cardBorderRadius: BorderRadius.circular(12.r),
      buttonBorderRadius: BorderRadius.circular(8.r),
      dialogBorderRadius: BorderRadius.circular(16.r),
      cardShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      buttonShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      dialogShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      defaultPadding: EdgeInsets.all(16.r),
      cardPadding: EdgeInsets.all(16.r),
      buttonPadding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      dialogPadding: EdgeInsets.all(24.r),
      videoOverlayColor: Colors.black.withOpacity(0.5),
      buttonGradient: null,
      cardGradient: null,
    );
  }
  
  /// Tạo instance mặc định cho dark theme
  factory AppThemeExtension.dark() {
    return AppThemeExtension(
      cardBackgroundColor: const Color(0xFF1E1E1E),
      videoControlsBackground: Colors.black.withOpacity(0.8),
      bottomNavBarBackground: const Color(0xFF121212),
      bottomNavBarInactiveColor: Colors.grey.shade400,
      bottomNavBarActiveColor: Colors.blue.shade300,
      defaultBorderRadius: BorderRadius.circular(8.r),
      cardBorderRadius: BorderRadius.circular(12.r),
      buttonBorderRadius: BorderRadius.circular(8.r),
      dialogBorderRadius: BorderRadius.circular(16.r),
      cardShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      buttonShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      dialogShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      defaultPadding: EdgeInsets.all(16.r),
      cardPadding: EdgeInsets.all(16.r),
      buttonPadding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      dialogPadding: EdgeInsets.all(24.r),
      videoOverlayColor: Colors.black.withOpacity(0.7),
      buttonGradient: null,
      cardGradient: null,
    );
  }
  
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
      videoControlsBackground: videoControlsBackground ?? this.videoControlsBackground,
      bottomNavBarBackground: bottomNavBarBackground ?? this.bottomNavBarBackground,
      bottomNavBarInactiveColor: bottomNavBarInactiveColor ?? this.bottomNavBarInactiveColor,
      bottomNavBarActiveColor: bottomNavBarActiveColor ?? this.bottomNavBarActiveColor,
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
      cardBackgroundColor: Color.lerp(cardBackgroundColor, other.cardBackgroundColor, t)!,
      videoControlsBackground: Color.lerp(videoControlsBackground, other.videoControlsBackground, t)!,
      bottomNavBarBackground: Color.lerp(bottomNavBarBackground, other.bottomNavBarBackground, t)!,
      bottomNavBarInactiveColor: Color.lerp(bottomNavBarInactiveColor, other.bottomNavBarInactiveColor, t)!,
      bottomNavBarActiveColor: Color.lerp(bottomNavBarActiveColor, other.bottomNavBarActiveColor, t)!,
      defaultBorderRadius: BorderRadius.lerp(defaultBorderRadius, other.defaultBorderRadius, t)!,
      cardBorderRadius: BorderRadius.lerp(cardBorderRadius, other.cardBorderRadius, t)!,
      buttonBorderRadius: BorderRadius.lerp(buttonBorderRadius, other.buttonBorderRadius, t)!,
      dialogBorderRadius: BorderRadius.lerp(dialogBorderRadius, other.dialogBorderRadius, t)!,
      cardShadow: t < 0.5 ? cardShadow : other.cardShadow,
      buttonShadow: t < 0.5 ? buttonShadow : other.buttonShadow,
      dialogShadow: t < 0.5 ? dialogShadow : other.dialogShadow,
      defaultPadding: EdgeInsetsGeometry.lerp(defaultPadding, other.defaultPadding, t)!,
      cardPadding: EdgeInsetsGeometry.lerp(cardPadding, other.cardPadding, t)!,
      buttonPadding: EdgeInsetsGeometry.lerp(buttonPadding, other.buttonPadding, t)!,
      dialogPadding: EdgeInsetsGeometry.lerp(dialogPadding, other.dialogPadding, t)!,
      videoOverlayColor: Color.lerp(videoOverlayColor, other.videoOverlayColor, t)!,
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
