import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../widgets/theme_settings_bottom_sheet.dart';
import 'component_showcase/button_component_page.dart';
import 'component_showcase/input_component_page.dart';
import 'component_showcase/layout_component_page.dart';
import 'component_showcase/list_component_page.dart';
import 'component_showcase/text_component_page.dart';

class ThemeShowcasePage extends StatelessWidget {
  const ThemeShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.appTitle),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return const ThemeSettingsBottomSheet();
                  },
                );
              },
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: l10n.textComponents),
              Tab(text: l10n.buttonComponents),
              Tab(text: l10n.inputComponents),
              Tab(text: l10n.layoutComponents),
              Tab(text: l10n.listComponents),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TextComponentPage(),
            ButtonComponentPage(),
            InputComponentPage(),
            LayoutComponentPage(),
            ListComponentPage(),
          ],
        ),
      ),
    );
  }
}
