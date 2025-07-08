import 'package:flutter/material.dart';
import 'package:flutter_theme_showcase/app.dart';
import 'package:flutter_theme_showcase/providers/language_provider.dart';
import 'package:flutter_theme_showcase/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  final languageProvider = LanguageProvider();
  await themeProvider.loadPreferences();
  await languageProvider.loadLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: languageProvider),
      ],
      child: const MyApp(),
    ),
  );
}
