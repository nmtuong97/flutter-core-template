import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../theme/base/app_theme.dart';
import '../theme/themes/app_themes.dart';
import '../providers/language_provider.dart';

class ThemeShowcasePage extends StatelessWidget {
  const ThemeShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Mode Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.themeMode,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<ThemeMode>(
                            title: Text(l10n.lightTheme),
                            value: ThemeMode.light,
                            groupValue: themeProvider.themeMode,
                            onChanged: (value) =>
                                themeProvider.setThemeMode(value!),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<ThemeMode>(
                            title: Text(l10n.darkTheme),
                            value: ThemeMode.dark,
                            groupValue: themeProvider.themeMode,
                            onChanged: (value) =>
                                themeProvider.setThemeMode(value!),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<ThemeMode>(
                            title: Text(l10n.systemTheme),
                            value: ThemeMode.system,
                            groupValue: themeProvider.themeMode,
                            onChanged: (value) =>
                                themeProvider.setThemeMode(value!),
                          ),
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
                padding: const EdgeInsets.all(16.0),
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
                      min: 12.0,
                      max: 24.0,
                      divisions: 12,
                      label: '${themeProvider.fontSize.round()}',
                      onChanged: (value) => themeProvider.setFontSize(value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Font Family Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.fontFamily,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: themeProvider.fontFamily,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                            value: 'Roboto', child: Text('Roboto')),
                        DropdownMenuItem(
                            value: 'Poppins', child: Text('Poppins')),
                        DropdownMenuItem(
                            value: 'Merriweather', child: Text('Merriweather')),
                      ],
                      onChanged: (value) => themeProvider.setFontFamily(value!),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // App Theme Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Theme',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<AppTheme>(
                      value: themeProvider.currentAppTheme,
                      isExpanded: true,
                      items: AppThemes.all.map((AppTheme theme) {
                        return DropdownMenuItem<AppTheme>(
                          value: theme,
                          child: Text(theme.name),
                        );
                      }).toList(),
                      onChanged: (value) => themeProvider.setAppTheme(value!),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Language Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.language,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(l10n.english),
                            value: 'en',
                            groupValue: languageProvider.locale.languageCode,
                            onChanged: (value) =>
                                languageProvider.setLocale(Locale(value!)),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(l10n.vietnamese),
                            value: 'vi',
                            groupValue: languageProvider.locale.languageCode,
                            onChanged: (value) =>
                                languageProvider.setLocale(Locale(value!)),
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
                padding: const EdgeInsets.all(16.0),
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
                    ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text('Sample ListTile'),
                      subtitle: const Text('This is a subtitle'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
