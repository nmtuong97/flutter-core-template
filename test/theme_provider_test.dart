import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/theme/base/theme_factory.dart';
import 'package:flutter_theme_showcase/theme/theme_preferences.dart';
import 'package:flutter_theme_showcase/theme/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'ThemeProvider khởi tạo với isLoading true và set false sau khi load',
    () async {
      final provider = ThemeProvider();
      expect(provider.isLoading, true);

      // Đợi 1 microtask để _loadPreferences chạy xong
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(provider.isLoading, false);
    },
  );

  test('setThemeMode lưu và phản ánh đúng', () async {
    final provider = ThemeProvider();
    await Future<void>.delayed(const Duration(milliseconds: 50));

    await provider.setThemeMode(ThemeMode.light);
    expect(provider.themeMode, ThemeMode.light);

    final saved = await ThemePreferences.getThemeMode();
    expect(saved, ThemePreferences.lightTheme);
  });

  test('setFontSize và setFontFamily hoạt động và được lưu', () async {
    final provider = ThemeProvider();
    await Future<void>.delayed(const Duration(milliseconds: 50));

    await provider.setFontSize(ThemePreferences.largeFont);
    expect(
      provider.fontSize,
      ThemePreferences.getFontSizeFromString(ThemePreferences.largeFont),
    );

    await provider.setFontFamily(ThemePreferences.serifFont);
    expect(
      provider.fontFamily,
      ThemePreferences.getFontFamilyFromString(ThemePreferences.serifFont),
    );
  });

  test(
    'setThemeStyle chuyển đổi qua lại giữa các theme khả dụng và lưu',
    () async {
      final provider = ThemeProvider();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final themes = ThemeFactory.availableThemes;
      expect(themes.isNotEmpty, true);

      for (final t in themes) {
        await provider.setThemeStyle(t.id);
        expect(provider.currentTheme.id, t.id);

        final saved = await ThemePreferences.getThemeStyle();
        expect(saved, t.id);
      }
    },
  );
}
// EOF
