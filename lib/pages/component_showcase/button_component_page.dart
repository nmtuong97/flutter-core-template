import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';

class ButtonComponentPage extends StatelessWidget {
  const ButtonComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(l10n.sampleButton),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: Text(l10n.sampleButton),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            child: Text(l10n.sampleButton),
          ),
          const SizedBox(height: 16),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: 'Option 1',
            items: [
               DropdownMenuItem(
                 value: 'Option 1', 
                 child: Text(context.l10n.option1),
               ),
               DropdownMenuItem(
                 value: 'Option 2', 
                 child: Text(context.l10n.option2),
               ),
             ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
