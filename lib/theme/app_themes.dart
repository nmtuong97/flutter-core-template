import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // Font sizes
  static const double smallFontSize = 12;
  static const double normalFontSize = 14;
  static const double mediumFontSize = 16;
  static const double largeFontSize = 18;
  static const double extraLargeFontSize = 22;

  // Global Theme Colors
  // Light Mode Colors
  static const Color primaryLightColor = Color(0xFF00CC7A); // xanh đậm
  static const Color secondaryLightColor = Color(0xFFE0E0E0);
  static const Color backgroundLightColor = Color(0xFFF5F5F5);
  static const Color surfaceLightColor = Colors.white;
  static const Color textPrimaryLightColor = Color(0xDD212121); // 87% opacity
  static const Color textSecondaryLightColor = Color(0x99757575); // 60% opacity
  static const Color textDisabledLightColor = Color(0x619E9E9E); // 38% opacity
  static const Color errorLightColor = Color(0xFFD32F2F);
  static const Color dividerLightColor = Color(0x1F000000); // 12% opacity

  // Dark Mode Colors
  static const Color primaryDarkColor = Color(0xFF00FF9D); // neon xanh
  static const Color secondaryDarkColor = Color(0xFF2D2D2D);
  static const Color backgroundDarkColor = Color(0xFF1A1A1A);
  static const Color surfaceDarkColor = Color(0xFF262626);
  static const Color textPrimaryDarkColor = Color(0xDDFFFFFF); // 87% opacity
  static const Color textSecondaryDarkColor = Color(0x99FFFFFF); // 60% opacity
  static const Color textDisabledDarkColor = Color(0x61FFFFFF); // 38% opacity
  static const Color errorDarkColor = Color(0xFFFF4D4D);
  static const Color dividerDarkColor = Color(0x1FFFFFFF); // 12% opacity

  // Bottom Navigation Bar
  static const Color bottomNavBgLightColor = Colors.white;
  static const Color bottomNavSelectedLightColor = Color(0xFF00CC7A);
  static const Color bottomNavUnselectedLightColor = Color(0xFF757575);

  static const Color bottomNavBgDarkColor = Color(0xFF2D2D2D);
  static const Color bottomNavSelectedDarkColor = Color(0xFF00FF9D);
  static const Color bottomNavUnselectedDarkColor = Color(
    0x99FFFFFF,
  ); // 60% opacity

  // FAB Colors
  static const Color fabIconLightColor = Colors.white;
  static const Color fabIconDarkColor = Colors.black;

  // Video Player Controls
  static const Color controlBarBgLightColor = Color(0xE6FFFFFF); // 90% opacity
  static const Color controlBarBgDarkColor = Color(0xCC000000); // 80% opacity
  static const Color seekBarInactiveLightColor = Color(
    0x33000000,
  ); // 20% opacity
  static const Color seekBarInactiveDarkColor = Color(
    0x4DFFFFFF,
  ); // 30% opacity

  // Card & Overlay
  static const Color cardBgLightColor = Color(0x0D000000); // 5% opacity
  static const Color cardBgDarkColor = Color(0x0DFFFFFF); // 5% opacity

  // Hover & Press States
  static const Color hoverLightColor = Color(0x0A000000); // 4% overlay
  static const Color hoverDarkColor = Color(0x14FFFFFF); // 8% overlay
  static const Color pressedLightColor = Color(0x14000000); // 8% overlay
  static const Color pressedDarkColor = Color(0x1FFFFFFF); // 12% overlay

  // Disabled State
  static const Color disabledLightColor = Color(0xFFBDBDBD);
  static const Color disabledDarkColor = Color(0x61FFFFFF); // 38% opacity

  // Font families
  static const String defaultFontFamily = 'Roboto';
  static const String alternateFontFamily = 'Poppins';
  static const String serifFontFamily = 'Merriweather';

  // Get light theme
  static ThemeData getLightTheme({
    double fontSize = normalFontSize,
    String fontFamily = defaultFontFamily,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryLightColor,
      colorScheme: const ColorScheme.light(
        primary: primaryLightColor,
        secondary: secondaryLightColor,
        surface: backgroundLightColor,
        error: errorLightColor,
        onSecondary: textPrimaryLightColor,
        onSurface: textPrimaryLightColor,
      ),
      scaffoldBackgroundColor: backgroundLightColor,
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLightColor,
        foregroundColor: textPrimaryLightColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: (fontSize + 4).sp,
          fontWeight: FontWeight.bold,
          color: textPrimaryLightColor,
        ),
        iconTheme: IconThemeData(color: textPrimaryLightColor, size: 24.r),
        actionsIconTheme: IconThemeData(
          color: textPrimaryLightColor,
          size: 24.r,
        ),
        centerTitle: false,
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
      ),
      // Text Theme
      textTheme: _getTextTheme(
        fontFamily,
        fontSize,
        textPrimaryLightColor,
        textSecondaryLightColor,
      ),
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLightColor,
          foregroundColor: Colors.white,
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 2,
          shadowColor: primaryLightColor.withAlpha((255 * 0.2).round()),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLightColor,
          side: const BorderSide(color: primaryLightColor),
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryLightColor,
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      // Card Theme
      cardTheme: CardTheme(
        color: surfaceLightColor,
        elevation: 2,
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(4),
      ),
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bottomNavBgLightColor,
        selectedItemColor: bottomNavSelectedLightColor,
        unselectedItemColor: bottomNavUnselectedLightColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
        ),
      ),
      // Bottom App Bar Theme
      bottomAppBarTheme: BottomAppBarTheme(
        color: bottomNavBgLightColor,
        elevation: 8,
        height: 56,
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
        surfaceTintColor: Colors.transparent,
      ),
      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLightColor,
        foregroundColor: fabIconLightColor,
        elevation: 6,
        focusElevation: 8,
        hoverElevation: 8,
        splashColor: Colors.white.withAlpha((255 * 0.2).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        enableFeedback: true,
        iconSize: 24,
      ),
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: dividerLightColor,
        thickness: 1,
        space: 1,
        indent: 0,
        endIndent: 0,
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surfaceLightColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: textSecondaryLightColor.withAlpha((255 * 0.5).round()),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: textSecondaryLightColor.withAlpha((255 * 0.5).round()),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryLightColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorLightColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorLightColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textDisabledLightColor),
        ),
        hintStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textSecondaryLightColor,
        ),
        labelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryLightColor,
        ),
        helperStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: textSecondaryLightColor,
        ),
        errorStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: errorLightColor,
        ),
        prefixStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryLightColor,
        ),
        suffixStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryLightColor,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: surfaceLightColor,
        elevation: 24,
        shadowColor: Colors.black.withAlpha((255 * 0.2).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        alignment: Alignment.center,
        titleTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize + 2,
          fontWeight: FontWeight.bold,
          color: primaryLightColor,
        ),
        contentTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryLightColor,
        ),
      ),
      // Alert Dialog Theme is part of dialogTheme in Flutter
      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surfaceLightColor,
        elevation: 16,
        modalElevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        modalBackgroundColor: surfaceLightColor,
        clipBehavior: Clip.antiAlias,
        constraints: BoxConstraints(minWidth: double.infinity),
      ),
      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceDarkColor,
        elevation: 6,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actionTextColor: primaryLightColor,
        contentTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: primaryLightColor,
        unselectedLabelColor: textSecondaryLightColor,
        indicatorColor: primaryLightColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
        ),
        dividerColor: dividerLightColor,
      ),
      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textDisabledLightColor;
          }
          if (states.contains(WidgetState.selected)) {
            return primaryLightColor;
          }
          return textSecondaryLightColor;
        }),
        checkColor: WidgetStateColor.resolveWith((_) => Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: textSecondaryLightColor, width: 1.5),
      ),
      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textDisabledLightColor;
          }
          if (states.contains(WidgetState.selected)) {
            return primaryLightColor;
          }
          return textSecondaryLightColor;
        }),
      ),
      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textDisabledLightColor;
          }
          if (states.contains(WidgetState.selected)) {
            return primaryLightColor;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textDisabledLightColor.withAlpha((255 * 0.5).round());
          }
          if (states.contains(WidgetState.selected)) {
            return primaryLightColor.withAlpha((255 * 0.5).round());
          }
          return textSecondaryLightColor.withAlpha((255 * 0.3).round());
        }),
        trackOutlineColor: WidgetStateColor.resolveWith(
          (_) => Colors.transparent,
        ),
      ),
      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryLightColor,
        inactiveTrackColor: textSecondaryLightColor.withAlpha(
          (255 * 0.3).round(),
        ),
        thumbColor: primaryLightColor,
        overlayColor: primaryLightColor.withAlpha((255 * 0.2).round()),
        valueIndicatorColor: primaryLightColor,
        valueIndicatorTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: Colors.white,
        ),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      ),
      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryLightColor,
        linearTrackColor: textSecondaryLightColor.withAlpha(
          (255 * 0.3).round(),
        ),
        circularTrackColor: textSecondaryLightColor.withAlpha(
          (255 * 0.3).round(),
        ),
        refreshBackgroundColor: surfaceLightColor,
      ),
      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surfaceDarkColor.withAlpha((255 * 0.9).round()),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      // Popup Menu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: surfaceLightColor,
        elevation: 8,
        shadowColor: Colors.black.withAlpha((255 * 0.2).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryLightColor,
        ),
      ),
      // Drawer Theme
      drawerTheme: DrawerThemeData(
        backgroundColor: surfaceLightColor,
        elevation: 16,
        scrimColor: Colors.black.withAlpha((255 * 0.6).round()),
        width: 280,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
        ),
      ),
      // Navigation Rail Theme
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: bottomNavBgLightColor,
        elevation: 8,
        selectedIconTheme: const IconThemeData(
          color: bottomNavSelectedLightColor,
          size: 24,
        ),
        unselectedIconTheme: const IconThemeData(
          color: bottomNavUnselectedLightColor,
          size: 24,
        ),
        selectedLabelTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          fontWeight: FontWeight.w500,
          color: bottomNavSelectedLightColor,
        ),
        unselectedLabelTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: bottomNavUnselectedLightColor,
        ),
        useIndicator: true,
        indicatorColor: primaryLightColor.withAlpha((255 * 0.2).round()),
        labelType: NavigationRailLabelType.selected,
      ),
      // Date Picker Theme
      datePickerTheme: DatePickerThemeData(
        backgroundColor: surfaceLightColor,
        elevation: 24,
        shadowColor: Colors.black.withAlpha((255 * 0.2).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        headerBackgroundColor: primaryLightColor,
        headerForegroundColor: Colors.white,
        headerHeadlineStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize + 4,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headerHelpStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: Colors.white.withAlpha((255 * 0.8).round()),
        ),
        dayStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryLightColor,
        ),
        weekdayStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: textSecondaryLightColor,
        ),
        yearStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryLightColor,
        ),
        todayBorder: const BorderSide(color: primaryLightColor),
        dayBackgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryLightColor;
          }
          return Colors.transparent;
        }),
        dayForegroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return textPrimaryLightColor;
        }),
      ),
      // Time Picker Theme
      timePickerTheme: TimePickerThemeData(
        backgroundColor: surfaceLightColor,
        hourMinuteTextColor: textPrimaryLightColor,
        hourMinuteColor: surfaceLightColor,
        dayPeriodTextColor: textPrimaryLightColor,
        dayPeriodColor: surfaceLightColor,
        dialHandColor: primaryLightColor,
        dialBackgroundColor: secondaryLightColor.withAlpha((255 * 0.3).round()),
        dialTextColor: textPrimaryLightColor,
        entryModeIconColor: primaryLightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: secondaryLightColor,
        deleteIconColor: textSecondaryLightColor,
        disabledColor: textDisabledLightColor.withAlpha((255 * 0.3).round()),
        selectedColor: primaryLightColor,
        secondarySelectedColor: primaryLightColor.withAlpha(
          (255 * 0.2).round(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: textPrimaryLightColor,
        ),
        secondaryLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: primaryLightColor,
        ),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        pressElevation: 2,
      ),
      // Icon Theme
      iconTheme: const IconThemeData(
        color: textPrimaryLightColor,
        size: 24,
        opacity: 1,
      ),
      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: primaryLightColor,
        size: 24,
        opacity: 1,
      ),
    );
  }

  // Get dark theme
  static ThemeData getDarkTheme({
    double fontSize = normalFontSize,
    String fontFamily = defaultFontFamily,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryDarkColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryDarkColor,
        secondary: secondaryDarkColor,
        surface: surfaceDarkColor,
        error: errorDarkColor,
        onSecondary: textPrimaryDarkColor,
        onSurface: textPrimaryDarkColor,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundDarkColor,
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundDarkColor,
        foregroundColor: textPrimaryDarkColor,
        elevation: 0,
        titleTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize + 4,
          fontWeight: FontWeight.bold,
          color: textPrimaryDarkColor,
        ),
        iconTheme: const IconThemeData(color: textPrimaryDarkColor, size: 24),
        actionsIconTheme: const IconThemeData(
          color: textPrimaryDarkColor,
          size: 24,
        ),
        centerTitle: false,
        shadowColor: Colors.black.withAlpha((255 * 0.3).round()),
      ),
      // Text Theme
      textTheme: _getTextTheme(
        fontFamily,
        fontSize,
        textPrimaryDarkColor,
        textSecondaryDarkColor,
      ),
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDarkColor,
          foregroundColor: Colors.black,
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          shadowColor: primaryDarkColor.withAlpha((255 * 0.3).round()),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDarkColor,
          side: const BorderSide(color: primaryDarkColor),
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryDarkColor,
          textStyle: _getTextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      // Card Theme
      cardTheme: CardTheme(
        color: surfaceDarkColor,
        elevation: 0,
        shadowColor: primaryDarkColor.withAlpha((255 * 0.1).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(4),
      ),
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bottomNavBgDarkColor,
        selectedItemColor: bottomNavSelectedDarkColor,
        unselectedItemColor: bottomNavUnselectedDarkColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
        ),
      ),
      // Bottom App Bar Theme
      bottomAppBarTheme: BottomAppBarTheme(
        color: bottomNavBgDarkColor,
        elevation: 8,
        height: 56,
        shadowColor: Colors.black.withAlpha((255 * 0.3).round()),
        surfaceTintColor: Colors.transparent,
      ),
      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryDarkColor,
        foregroundColor: fabIconDarkColor,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        splashColor: Colors.black.withAlpha((255 * 0.2).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        enableFeedback: true,
        iconSize: 24,
        // Gradient effect will be applied in custom FAB widget
      ),
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: dividerDarkColor,
        thickness: 1,
        space: 1,
        indent: 0,
        endIndent: 0,
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        fillColor: secondaryDarkColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: textSecondaryDarkColor.withAlpha((255 * 0.3).round()),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: textSecondaryDarkColor.withAlpha((255 * 0.3).round()),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryDarkColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorDarkColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorDarkColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textDisabledDarkColor),
        ),
        hintStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textSecondaryDarkColor,
        ),
        labelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryDarkColor,
        ),
        helperStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: textSecondaryDarkColor,
        ),
        errorStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: errorDarkColor,
        ),
        prefixStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryDarkColor,
        ),
        suffixStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryDarkColor,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: surfaceDarkColor,
        elevation: 24,
        shadowColor: Colors.black.withAlpha((255 * 0.5).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        alignment: Alignment.center,
        titleTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize + 2,
          fontWeight: FontWeight.bold,
          color: primaryDarkColor,
        ),
        contentTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryDarkColor,
        ),
      ),
      // Alert Dialog Theme is part of dialogTheme in Flutter
      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surfaceDarkColor,
        elevation: 16,
        modalElevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        modalBackgroundColor: surfaceDarkColor,
        clipBehavior: Clip.antiAlias,
        constraints: BoxConstraints(minWidth: double.infinity),
      ),
      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceLightColor,
        elevation: 6,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actionTextColor: primaryDarkColor,
        contentTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: Colors.black,
        ),
      ),
      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: primaryDarkColor,
        unselectedLabelColor: textSecondaryDarkColor,
        indicatorColor: primaryDarkColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
        ),
        dividerColor: dividerDarkColor,
      ),
      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textDisabledDarkColor;
          }
          if (states.contains(WidgetState.selected)) {
            return primaryDarkColor;
          }
          return textSecondaryDarkColor;
        }),
        checkColor: WidgetStateColor.resolveWith((_) => Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: textSecondaryDarkColor, width: 1.5),
      ),
      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textDisabledDarkColor;
          }
          if (states.contains(WidgetState.selected)) {
            return primaryDarkColor;
          }
          return textSecondaryDarkColor;
        }),
      ),
      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textDisabledDarkColor;
          }
          if (states.contains(WidgetState.selected)) {
            return primaryDarkColor;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textDisabledDarkColor.withAlpha((255 * 0.5).round());
          }
          if (states.contains(WidgetState.selected)) {
            return primaryDarkColor.withAlpha((255 * 0.5).round());
          }
          return textSecondaryDarkColor.withAlpha((255 * 0.3).round());
        }),
        trackOutlineColor: WidgetStateColor.resolveWith(
          (_) => Colors.transparent,
        ),
      ),
      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryDarkColor,
        inactiveTrackColor: textSecondaryDarkColor.withAlpha(
          (255 * 0.3).round(),
        ),
        thumbColor: primaryDarkColor,
        overlayColor: primaryDarkColor.withAlpha((255 * 0.2).round()),
        valueIndicatorColor: primaryDarkColor,
        valueIndicatorTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: Colors.black,
        ),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      ),
      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryDarkColor,
        linearTrackColor: textSecondaryDarkColor.withAlpha(
          (255 * 0.3).round(),
        ),
        circularTrackColor: textSecondaryDarkColor.withAlpha(
          (255 * 0.3).round(),
        ),
        refreshBackgroundColor: surfaceDarkColor,
      ),
      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surfaceLightColor.withAlpha((255 * 0.9).round()),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      // Popup Menu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: surfaceDarkColor,
        elevation: 8,
        shadowColor: Colors.black.withAlpha((255 * 0.5).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryDarkColor,
        ),
      ),
      // Drawer Theme
      drawerTheme: DrawerThemeData(
        backgroundColor: surfaceDarkColor,
        elevation: 16,
        scrimColor: Colors.black.withAlpha((255 * 0.8).round()),
        width: 280,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
        ),
      ),
      // Navigation Rail Theme
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: bottomNavBgDarkColor,
        elevation: 8,
        selectedIconTheme: const IconThemeData(
          color: bottomNavSelectedDarkColor,
          size: 24,
        ),
        unselectedIconTheme: const IconThemeData(
          color: bottomNavUnselectedDarkColor,
          size: 24,
        ),
        selectedLabelTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          fontWeight: FontWeight.w500,
          color: bottomNavSelectedDarkColor,
        ),
        unselectedLabelTextStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: bottomNavUnselectedDarkColor,
        ),
        useIndicator: true,
        indicatorColor: primaryDarkColor.withAlpha((255 * 0.2).round()),
        labelType: NavigationRailLabelType.selected,
      ),
      // Date Picker Theme
      datePickerTheme: DatePickerThemeData(
        backgroundColor: surfaceDarkColor,
        elevation: 24,
        shadowColor: Colors.black.withAlpha((255 * 0.5).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        headerBackgroundColor: primaryDarkColor,
        headerForegroundColor: Colors.black,
        headerHeadlineStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize + 4,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headerHelpStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: Colors.black.withAlpha((255 * 0.8).round()),
        ),
        dayStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryDarkColor,
        ),
        weekdayStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: textSecondaryDarkColor,
        ),
        yearStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textPrimaryDarkColor,
        ),
        todayBorder: const BorderSide(color: primaryDarkColor),
        dayBackgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryDarkColor;
          }
          return Colors.transparent;
        }),
        dayForegroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return textPrimaryDarkColor;
        }),
      ),
      // Time Picker Theme
      timePickerTheme: TimePickerThemeData(
        backgroundColor: surfaceDarkColor,
        hourMinuteTextColor: textPrimaryDarkColor,
        hourMinuteColor: secondaryDarkColor,
        dayPeriodTextColor: textPrimaryDarkColor,
        dayPeriodColor: secondaryDarkColor,
        dialHandColor: primaryDarkColor,
        dialBackgroundColor: secondaryDarkColor,
        dialTextColor: textPrimaryDarkColor,
        entryModeIconColor: primaryDarkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: secondaryDarkColor,
        deleteIconColor: textSecondaryDarkColor,
        disabledColor: textDisabledDarkColor.withAlpha((255 * 0.3).round()),
        selectedColor: primaryDarkColor,
        secondarySelectedColor: primaryDarkColor.withAlpha(
          (255 * 0.2).round(),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        labelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: textPrimaryDarkColor,
        ),
        secondaryLabelStyle: _getTextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize - 2,
          color: primaryDarkColor,
        ),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        pressElevation: 0,
      ),
      // Icon Theme
      iconTheme: const IconThemeData(
        color: textPrimaryDarkColor,
        size: 24,
        opacity: 1,
      ),
      // Primary Icon Theme
      primaryIconTheme: IconThemeData(
        color: primaryDarkColor,
        size: 24.r,
        opacity: 1,
      ),
    );
  }

  // Helper method to get text style with Google Fonts
  static TextStyle _getTextStyle({
    required String fontFamily,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    // Sử dụng ScreenUtil để responsive font size
    final responsiveFontSize = fontSize.sp;
    TextStyle textStyle;

    switch (fontFamily) {
      case alternateFontFamily:
        textStyle = GoogleFonts.poppins(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
        );
      case serifFontFamily:
        textStyle = GoogleFonts.merriweather(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
        );
      case defaultFontFamily:
      default:
        textStyle = GoogleFonts.roboto(
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          color: color,
        );
    }

    return textStyle;
  }

  // Helper method to get text theme
  static TextTheme _getTextTheme(
    String fontFamily,
    double fontSize,
    Color primaryTextColor,
    Color secondaryTextColor,
  ) {
    return TextTheme(
      displayLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 12,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      displayMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 8,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      displaySmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 6,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      headlineLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 10,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 6,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 4,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 2,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      bodyLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize + 2,
        color: primaryTextColor,
      ),
      bodyMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: primaryTextColor,
      ),
      bodySmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize - 2,
        color: secondaryTextColor,
      ),
      labelLarge: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
      labelMedium: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize - 1,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
      ),
      labelSmall: _getTextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize - 2,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
      ),
    );
  }
}
