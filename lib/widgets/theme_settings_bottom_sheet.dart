import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/base/app_theme.dart';
import '../theme/themes/app_themes.dart';

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
                  RadioGroup<ThemeMode>(
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      if (value != null) {
                        themeProvider.setThemeMode(value);
                      }
                    },
                    child: const Column(
                      children: [
                        RadioListTile<ThemeMode>(
                          title: Text('Light Theme'),
                          value: ThemeMode.light,
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text('Dark Theme'),
                          value: ThemeMode.dark,
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text('System Theme'),
                          value: ThemeMode.system,
                        ),
                      ],
                    ),
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
                  RadioGroup<String>(
                    groupValue: themeProvider.fontFamily,
                    onChanged: (value) {
                      if (value != null) {
                        themeProvider.setFontFamily(value);
                      }
                    },
                    child: const Column(
                       children: [
                         RadioListTile<String>(
                           title: Text('Roboto'),
                           value: 'Roboto',
                         ),
                         RadioListTile<String>(
                           title: Text('Poppins'),
                           value: 'Poppins',
                         ),
                         RadioListTile<String>(
                           title: Text('Merriweather'),
                           value: 'Merriweather',
                         ),
                       ],
                     ),
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
                  RadioGroup<AppTheme>(
                    groupValue: themeProvider.currentAppTheme,
                    onChanged: (value) {
                      if (value != null) {
                        themeProvider.setAppTheme(value);
                      }
                    },
                    child: Column(
                      children: AppThemes.all.map((AppTheme theme) {
                        return RadioListTile<AppTheme>(
                          title: Text(theme.name),
                          value: theme,
                        );
                      }).toList(),
                     ),
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
                      RadioGroup<String>(
                        groupValue: languageProvider.locale.languageCode,
                        onChanged: (value) {
                          if (value != null) {
                            languageProvider.setLocale(Locale(value));
                          }
                        },
                        child: const Column(
                          children: [
                            RadioListTile<String>(
                              title: Text('English'),
                              value: 'en',
                            ),
                            RadioListTile<String>(
                              title: Text('Tiếng Việt'),
                              value: 'vi',
                            ),
                          ],
                        ),
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
