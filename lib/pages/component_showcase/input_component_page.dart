import 'package:flutter/material.dart';

class InputComponentPage extends StatelessWidget {
  const InputComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Text Field',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Text Form Field',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            title: const Text('Checkbox'),
            value: true,
            onChanged: (bool? value) {},
          ),
          const SizedBox(height: 16),
          RadioListTile<int>(
            title: const Text('Radio Button'),
            value: 1,
            groupValue: 1,
            onChanged: (int? value) {},
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Switch'),
            value: true,
            onChanged: (bool? value) {},
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(value: 0.7),
          const SizedBox(height: 16),
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
