import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';

class ListComponentPage extends StatelessWidget {
  const ListComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.listViewExample),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.list),
                  title: Text('${context.l10n.item} ${index + 1}'),
                  subtitle: Text(context.l10n.descriptionOfItem),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(context.l10n.gridViewExample),
          const SizedBox(height: 8),
          SizedBox(
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final theme = Theme.of(context);
                final isDark = theme.brightness == Brightness.dark;

                return Card(
                  // Use theme surface color for consistency
                  color: theme.colorScheme.surface,
                  child: Center(
                    child: Text(
                      '${context.l10n.gridItem} ${index + 1}',
                      style: TextStyle(
                        // Ensure high contrast text color
                        color: isDark
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
