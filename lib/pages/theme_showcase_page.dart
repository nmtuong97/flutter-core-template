import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/theme_settings_bottom_sheet.dart';

class ThemeShowcasePage extends StatelessWidget {
  const ThemeShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return const ThemeSettingsBottomSheet();
                },
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Nội dung khác sẽ được thêm vào sau.'),
      ),
    );
  }
}
