import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class TextComponentPage extends StatelessWidget {
  const TextComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sampleText,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
