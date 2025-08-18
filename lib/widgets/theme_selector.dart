import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          children: [
            _buildThemeModeSelector(context, themeProvider),
            const SizedBox(height: 16),
            _buildThemeStyleSelector(context, themeProvider),
          ],
        );
      },
    );
  }

  Widget _buildThemeModeSelector(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Row(
      children: [
        Text(
          'Theme Mode: ',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 8),
        SegmentedButton<ThemeMode>(
          segments: const [
            ButtonSegment(
              value: ThemeMode.system,
              label: Text('System'),
              icon: Icon(Icons.brightness_auto),
            ),
            ButtonSegment(
              value: ThemeMode.light,
              label: Text('Light'),
              icon: Icon(Icons.brightness_high),
            ),
            ButtonSegment(
              value: ThemeMode.dark,
              label: Text('Dark'),
              icon: Icon(Icons.brightness_low),
            ),
          ],
          selected: {themeProvider.themeMode},
          onSelectionChanged: (Set<ThemeMode> selection) {
            unawaited(themeProvider.setThemeMode(selection.first));
          },
        ),
      ],
    );
  }

  Widget _buildThemeStyleSelector(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme Style:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: themeProvider.availableThemes.map((theme) {
            final isSelected = themeProvider.currentTheme.name == theme.name;
            return FilterChip(
              label: Text(theme.name),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  unawaited(themeProvider.setThemeStyle(theme.id));
                }
              },
              avatar: isSelected ? const Icon(Icons.check) : null,
            );
          }).toList(),
        ),
      ],
    );
  }
}
