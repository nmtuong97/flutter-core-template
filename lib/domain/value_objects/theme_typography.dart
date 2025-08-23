import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Value object representing theme typography configuration
class ThemeTypography extends Equatable {
  const ThemeTypography({
    required this.fontFamily,
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  /// Create default typography
  const ThemeTypography.defaultTypography()
      : fontFamily = 'Roboto',
        displayLarge = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 57,
          fontWeight: FontWeight.w400,
          height: 1.12,
        ),
        displayMedium = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 45,
          fontWeight: FontWeight.w400,
          height: 1.16,
        ),
        displaySmall = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 36,
          fontWeight: FontWeight.w400,
          height: 1.22,
        ),
        headlineLarge = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 32,
          fontWeight: FontWeight.w400,
          height: 1.25,
        ),
        headlineMedium = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 28,
          fontWeight: FontWeight.w400,
          height: 1.29,
        ),
        headlineSmall = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          fontWeight: FontWeight.w400,
          height: 1.33,
        ),
        titleLarge = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 22,
          fontWeight: FontWeight.w400,
          height: 1.27,
        ),
        titleMedium = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.50,
        ),
        titleSmall = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.43,
        ),
        bodyLarge = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.50,
        ),
        bodyMedium = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.43,
        ),
        bodySmall = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.33,
        ),
        labelLarge = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.43,
        ),
        labelMedium = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.33,
        ),
        labelSmall = const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.45,
        );

  /// Create typography with custom font family
  factory ThemeTypography.withFontFamily(String fontFamily) {
    return ThemeTypography(
      fontFamily: fontFamily,
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 1.22,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 1.33,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.50,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.50,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
      ),
    );
  }

  final String fontFamily;
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  /// Convert to Flutter TextTheme
  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  /// Scale typography by factor
  ThemeTypography scale(double scaleFactor) {
    return ThemeTypography(
      fontFamily: fontFamily,
      displayLarge: _scaleTextStyle(displayLarge, scaleFactor),
      displayMedium: _scaleTextStyle(displayMedium, scaleFactor),
      displaySmall: _scaleTextStyle(displaySmall, scaleFactor),
      headlineLarge: _scaleTextStyle(headlineLarge, scaleFactor),
      headlineMedium: _scaleTextStyle(headlineMedium, scaleFactor),
      headlineSmall: _scaleTextStyle(headlineSmall, scaleFactor),
      titleLarge: _scaleTextStyle(titleLarge, scaleFactor),
      titleMedium: _scaleTextStyle(titleMedium, scaleFactor),
      titleSmall: _scaleTextStyle(titleSmall, scaleFactor),
      bodyLarge: _scaleTextStyle(bodyLarge, scaleFactor),
      bodyMedium: _scaleTextStyle(bodyMedium, scaleFactor),
      bodySmall: _scaleTextStyle(bodySmall, scaleFactor),
      labelLarge: _scaleTextStyle(labelLarge, scaleFactor),
      labelMedium: _scaleTextStyle(labelMedium, scaleFactor),
      labelSmall: _scaleTextStyle(labelSmall, scaleFactor),
    );
  }

  TextStyle _scaleTextStyle(TextStyle style, double scaleFactor) {
    return style.copyWith(
      fontSize: (style.fontSize ?? 14) * scaleFactor,
    );
  }

  /// Validate typography
  bool get isValid {
    return fontFamily.isNotEmpty;
  }

  @override
  List<Object?> get props => [
        fontFamily,
        displayLarge,
        displayMedium,
        displaySmall,
        headlineLarge,
        headlineMedium,
        headlineSmall,
        titleLarge,
        titleMedium,
        titleSmall,
        bodyLarge,
        bodyMedium,
        bodySmall,
        labelLarge,
        labelMedium,
        labelSmall,
      ];
}
