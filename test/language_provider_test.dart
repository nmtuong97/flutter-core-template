import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_showcase/providers/language_provider.dart';
import 'package:flutter_theme_showcase/theme/theme_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('LanguageProvider loadLocale dùng key chuẩn và default en', () async {
    final provider = LanguageProvider();
    await provider.loadLocale();

    expect(provider.locale, const Locale('en'));
  });

  test('setLocale lưu với key dùng ThemePreferences.languageKey', () async {
    final provider = LanguageProvider()..setLocale(const Locale('vi'));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(provider.locale, const Locale('vi'));

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(ThemePreferences.languageKey);
    expect(saved, ThemePreferences.vietnameseLanguage);
  });
}
