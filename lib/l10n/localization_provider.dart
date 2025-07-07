import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  LocalizationProvider() {
    _loadSavedLanguage();
  }
  static const String languageKey = 'language_code';
  static const String defaultLanguage = 'en';

  Locale _locale = const Locale(defaultLanguage);
  bool _isLoading = true;

  Locale get locale => _locale;
  Locale get currentLocale => _locale;
  bool get isLoading => _isLoading;

  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('vi'),
  ];

  // Load saved language
  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(languageKey) ?? defaultLanguage;
    _locale = Locale(languageCode);
    _isLoading = false;
    notifyListeners();
  }

  // Set language
  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, languageCode);
  }

  // Check if current language is English
  bool get isEnglish => _locale.languageCode == 'en';

  // Check if current language is Vietnamese
  bool get isVietnamese => _locale.languageCode == 'vi';
}
