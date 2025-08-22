import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Font type enum để xác định loại font
enum FontType { defaultFont, alternateFont, serifFont }

/// Configuration class để định nghĩa font families cho từng theme
class FontConfiguration {
  const FontConfiguration({
    required this.defaultFontFamily,
    required this.alternateFontFamily,
    required this.serifFontFamily,
  });

  final String defaultFontFamily;
  final String alternateFontFamily;
  final String serifFontFamily;

  /// Predefined font configurations for each theme
  static const FontConfiguration defaultTheme = FontConfiguration(
    defaultFontFamily: 'Roboto',
    alternateFontFamily: 'Poppins',
    serifFontFamily: 'Merriweather',
  );

  static const FontConfiguration cyberpunkTheme = FontConfiguration(
    defaultFontFamily: 'Roboto',
    alternateFontFamily: 'Poppins',
    serifFontFamily: 'Merriweather',
  );

  static const FontConfiguration nightSkyTheme = FontConfiguration(
    defaultFontFamily: 'Roboto',
    alternateFontFamily: 'Poppins',
    serifFontFamily: 'Merriweather',
  );

  static const FontConfiguration exaggeratedMinimalismTheme = FontConfiguration(
    defaultFontFamily: 'Inter',
    alternateFontFamily: 'Space Grotesk',
    serifFontFamily: 'Merriweather',
  );

  static const FontConfiguration neumorphismTheme = FontConfiguration(
    defaultFontFamily: 'Poppins',
    alternateFontFamily: 'Montserrat',
    serifFontFamily: 'Merriweather',
  );

  static const FontConfiguration glassmorphismTheme = FontConfiguration(
    defaultFontFamily: 'Quicksand',
    alternateFontFamily: 'Nunito',
    serifFontFamily: 'Lora',
  );

  static const FontConfiguration retroVintageTheme = FontConfiguration(
    defaultFontFamily: 'Playfair Display',
    alternateFontFamily: 'Abril Fatface',
    serifFontFamily: 'Lora',
  );

  static const FontConfiguration organicNaturalTheme = FontConfiguration(
    defaultFontFamily: 'Comfortaa',
    alternateFontFamily: 'Caveat',
    serifFontFamily: 'Cormorant',
  );

  /// Get GoogleFonts TextStyle based on font type and configuration
  static TextStyle getGoogleFontStyle({
    required FontConfiguration config,
    required FontType fontType,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    double? letterSpacing,
    List<Shadow>? shadows,
  }) {
    final base = _getGoogleFontByName(
      switch (fontType) {
        FontType.alternateFont => config.alternateFontFamily,
        FontType.serifFont => config.serifFontFamily,
        FontType.defaultFont => config.defaultFontFamily,
      },
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
    if (shadows != null && shadows.isNotEmpty) {
      return base.copyWith(shadows: shadows);
    }
    return base;
  }

  /// Helper method để get Google Font by name
  static TextStyle _getGoogleFontByName(
    String fontName, {
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    double? letterSpacing,
  }) {
    // Map font names to GoogleFonts methods
    switch (fontName.toLowerCase().replaceAll(' ', '')) {
      // Default theme fonts
      case 'roboto':
        return GoogleFonts.roboto(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      case 'poppins':
        return GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      case 'merriweather':
        return GoogleFonts.merriweather(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );

      // Exaggerated Minimalism theme fonts
      case 'inter':
        return GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      case 'spacegrotesk':
        return GoogleFonts.spaceGrotesk(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );

      // Neumorphism theme fonts
      case 'montserrat':
        return GoogleFonts.montserrat(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );

      // Glassmorphism theme fonts
      case 'quicksand':
        return GoogleFonts.quicksand(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      case 'nunito':
        return GoogleFonts.nunito(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      case 'lora':
        return GoogleFonts.lora(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );

      // Retro Vintage theme fonts
      case 'playfairdisplay':
        return GoogleFonts.playfairDisplay(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      case 'abrilfatface':
        return GoogleFonts.abrilFatface(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );

      // Organic Natural theme fonts
      case 'comfortaa':
        return GoogleFonts.comfortaa(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      case 'caveat':
        return GoogleFonts.caveat(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
      case 'cormorant':
        return GoogleFonts.cormorant(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );

      // Fallback to Roboto
      default:
        return GoogleFonts.roboto(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
        );
    }
  }

  /// Get font configuration by theme ID
  static FontConfiguration getByThemeId(String themeId) {
    switch (themeId) {
      case 'cyberpunk':
        return cyberpunkTheme;
      case 'night_sky':
        return nightSkyTheme;
      case 'exaggerated_minimalism':
        return exaggeratedMinimalismTheme;
      case 'neumorphism':
        return neumorphismTheme;
      case 'glassmorphism':
        return glassmorphismTheme;
      case 'retro_vintage':
        return retroVintageTheme;
      case 'organic_natural':
        return organicNaturalTheme;
      case 'default':
      default:
        return defaultTheme;
    }
  }
}
