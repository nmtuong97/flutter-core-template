import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/language_provider.dart';
import '../theme/base/app_theme.dart';
import '../theme/base/theme_factory.dart';
import '../theme/theme_provider.dart';

class ThemeSettingsBottomSheet extends StatelessWidget {
  const ThemeSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ThemeModeSection(),
          SizedBox(height: 16),
          _FontSizeSection(),
          SizedBox(height: 16),
          _FontFamilySection(),
          SizedBox(height: 16),
          _AppThemeSection(),
          SizedBox(height: 16),
          _LanguageSection(),
          SizedBox(height: 16),
          _PreviewSection(),
        ],
      ),
    );
  }
}

class _ThemeModeSection extends StatelessWidget {
  const _ThemeModeSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeMode = context.select<ThemeProvider, ThemeMode>(
      (p) => p.themeMode,
    );
    final isLoading = context.select<ThemeProvider, bool>((p) => p.isLoading);

    return Card(
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
              groupValue: themeMode,
              onChanged: (value) {
                if (isLoading) return;
                if (value != null) {
                  unawaited(
                    context.read<ThemeProvider>().setThemeMode(value),
                  );
                }
              },
              child: Column(
                children: [
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.lightTheme),
                    value: ThemeMode.light,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.darkTheme),
                    value: ThemeMode.dark,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.systemTheme),
                    value: ThemeMode.system,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FontSizeSection extends StatelessWidget {
  const _FontSizeSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final fontSize = context.select<ThemeProvider, double>((p) => p.fontSize);
    final isLoading = context.select<ThemeProvider, bool>((p) => p.isLoading);

    return Card(
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
              value: fontSize,
              min: 12,
              max: 24,
              divisions: 12,
              label: '${fontSize.round()}',
              onChanged: (value) {
                if (isLoading) return;
                String fontSizeString;
                if (value <= 14) {
                  fontSizeString = 'small';
                } else if (value <= 18) {
                  fontSizeString = 'normal';
                } else {
                  fontSizeString = 'large';
                }
                unawaited(
                  context.read<ThemeProvider>().setFontSize(fontSizeString),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FontFamilySection extends StatelessWidget {
  const _FontFamilySection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final fontFamily = context.select<ThemeProvider, String>(
      (p) => p.fontFamily,
    );
    final isLoading = context.select<ThemeProvider, bool>((p) => p.isLoading);

    return Card(
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
              groupValue: fontFamily,
              onChanged: (value) {
                if (isLoading) return;
                if (value != null) {
                  unawaited(
                    context.read<ThemeProvider>().setFontFamily(value),
                  );
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
    );
  }
}

class _AppThemeSection extends StatelessWidget {
  const _AppThemeSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentTheme = context.select<ThemeProvider, AppTheme>(
      (p) => p.currentTheme,
    );
    final isLoading = context.select<ThemeProvider, bool>((p) => p.isLoading);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.appTheme,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            RadioGroup<AppTheme>(
              groupValue: currentTheme,
              onChanged: (value) {
                if (isLoading) return;
                if (value != null) {
                  unawaited(
                    context.read<ThemeProvider>().setThemeStyle(value.id),
                  );
                }
              },
              child: Column(
                children: ThemeFactory.availableThemes.map((AppTheme theme) {
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
    );
  }
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = context.select<LanguageProvider, String>(
      (p) => p.locale.languageCode,
    );

    return Card(
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
                  groupValue: languageCode,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<LanguageProvider>().setLocale(Locale(value));
                    }
                  },
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text(l10n.english),
                        value: 'en',
                      ),
                      RadioListTile<String>(
                        title: Text(l10n.vietnamese),
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
    );
  }
}

class _PreviewSection extends StatelessWidget {
  const _PreviewSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.preview,
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
    );
  }
}
