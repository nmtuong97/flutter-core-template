import 'package:flutter/material.dart';
import 'package:flutter_theme_showcase/l10n/app_localizations.dart';
import 'package:flutter_theme_showcase/providers/language_provider.dart';
import 'package:flutter_theme_showcase/providers/theme_provider.dart';
import 'package:flutter_theme_showcase/theme/base/app_theme.dart';
import 'package:flutter_theme_showcase/theme/themes/app_themes.dart';
import 'package:provider/provider.dart';

class ThemeSettingsBottomSheet extends StatelessWidget {
  const ThemeSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Theme Mode Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.themeMode,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      RadioListTile<ThemeMode>(
                        title: Text(l10n.lightTheme),
                        value: ThemeMode.light,
                        groupValue: themeProvider.themeMode,
                        onChanged: (value) =>
                            themeProvider.setThemeMode(value!),
                      ),
                      RadioListTile<ThemeMode>(
                        title: Text(l10n.darkTheme),
                        value: ThemeMode.dark,
                        groupValue: themeProvider.themeMode,
                        onChanged: (value) =>
                            themeProvider.setThemeMode(value!),
                      ),
                      RadioListTile<ThemeMode>(
                        title: Text(l10n.systemTheme),
                        value: ThemeMode.system,
                        groupValue: themeProvider.themeMode,
                        onChanged: (value) =>
                            themeProvider.setThemeMode(value!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Font Size Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.fontSize,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: themeProvider.fontSize,
                    min: 12,
                    max: 24,
                    divisions: 12,
                    label: '${themeProvider.fontSize.round()}',
                    onChanged: themeProvider.setFontSize,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Font Family Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.fontFamily,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      RadioListTile<String>(
                        title: const Text('Roboto'),
                        value: 'Roboto',
                        groupValue: themeProvider.fontFamily,
                        onChanged: (value) =>
                            themeProvider.setFontFamily(value!),
                      ),
                      RadioListTile<String>(
                        title: const Text('Poppins'),
                        value: 'Poppins',
                        groupValue: themeProvider.fontFamily,
                        onChanged: (value) =>
                            themeProvider.setFontFamily(value!),
                      ),
                      RadioListTile<String>(
                        title: const Text('Merriweather'),
                        value: 'Merriweather',
                        groupValue: themeProvider.fontFamily,
                        onChanged: (value) =>
                            themeProvider.setFontFamily(value!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // App Theme Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Theme',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: AppThemes.all.map((AppTheme theme) {
                      return RadioListTile<AppTheme>(
                        title: Text(theme.name),
                        value: theme,
                        groupValue: themeProvider.currentAppTheme,
                        onChanged: (value) => themeProvider.setAppTheme(value!),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Language Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.language,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      RadioListTile<String>(
                        title: Text(l10n.english),
                        value: 'en',
                        groupValue: languageProvider.locale.languageCode,
                        onChanged: (value) =>
                            languageProvider.setLocale(Locale(value!)),
                      ),
                      RadioListTile<String>(
                        title: Text(l10n.vietnamese),
                        value: 'vi',
                        groupValue: languageProvider.locale.languageCode,
                        onChanged: (value) =>
                            languageProvider.setLocale(Locale(value!)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Preview Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.sampleText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(l10n.sampleButton),
                  ),
                  const SizedBox(height: 16),
                  const LinearProgressIndicator(value: 0.7),
                  const SizedBox(height: 16),
                  const ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Sample ListTile'),
                    subtitle: Text('This is a subtitle'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
