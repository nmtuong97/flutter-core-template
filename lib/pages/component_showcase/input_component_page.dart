import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';

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
          TextField(
            decoration: InputDecoration(
              labelText: context.l10n.textField,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: context.l10n.textFormField,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            title: Text(context.l10n.checkbox),
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
            child: Column(
              children: [
                RadioListTile<int>(
                  title: Text(context.l10n.radioButton1),
                  value: 1,
                ),
                RadioListTile<int>(
                  title: Text(context.l10n.radioButton2),
                  value: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: Text(context.l10n.switchWidget),
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
