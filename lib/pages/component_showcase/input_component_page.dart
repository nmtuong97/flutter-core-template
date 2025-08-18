import 'package:flutter/material.dart';

class InputComponentPage extends StatefulWidget {
  const InputComponentPage({super.key});

  @override
  State<InputComponentPage> createState() => _InputComponentPageState();
}

class _InputComponentPageState extends State<InputComponentPage> {
  int? _radioValue = 1;
  bool _checkboxValue = true;
  bool _switchValue = true;

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
            value: _checkboxValue,
            onChanged: (bool? value) {
              setState(() {
                _checkboxValue = value ?? false;
              });
            },
          ),
          const SizedBox(height: 16),
          RadioGroup<int>(
            groupValue: _radioValue,
            onChanged: (int? value) {
              setState(() {
                _radioValue = value;
              });
            },
            child: const Column(
              children: [
                RadioListTile<int>(
                  title: Text('Radio Button 1'),
                  value: 1,
                ),
                RadioListTile<int>(
                  title: Text('Radio Button 2'),
                  value: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Switch'),
            value: _switchValue,
            onChanged: (bool value) {
              setState(() {
                _switchValue = value;
              });
            },
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
