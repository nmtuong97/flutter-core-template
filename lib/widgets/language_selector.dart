import 'package:flutter/material.dart';
import 'package:flutter_theme_showcase/l10n/localization_provider.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        return Row(
          children: [
            Text(
              'Language: ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 8),
            DropdownButton<Locale>(
              value: localizationProvider.currentLocale,
              items: LocalizationProvider.supportedLocales.map((locale) {
                return DropdownMenuItem<Locale>(
                  value: locale,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_getLanguageFlag(locale.languageCode)),
                      const SizedBox(width: 8),
                      Text(_getLanguageName(locale.languageCode)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  localizationProvider.setLocale(newLocale.languageCode);
                }
              },
            ),
          ],
        );
      },
    );
  }

  String _getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'vi':
        return '🇻🇳';
      case 'es':
        return '🇪🇸';
      default:
        return '🌐';
    }
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'vi':
        return 'Tiếng Việt';
      case 'es':
        return 'Español';
      default:
        return languageCode.toUpperCase();
    }
  }
}
