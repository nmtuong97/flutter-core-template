import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import '../presentation/blocs/theme/theme_bloc.dart';
import '../presentation/blocs/theme/theme_event.dart';
import '../presentation/blocs/theme/theme_state.dart';
import '../theme/theme_preferences.dart';

/// A simple RadioGroup widget that manages radio button states
class RadioGroup<T> extends InheritedWidget {
  const RadioGroup({
    required this.groupValue,
    required this.onChanged,
    required super.child,
    super.key,
  });

  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  @override
  bool updateShouldNotify(RadioGroup<T> oldWidget) {
    return groupValue != oldWidget.groupValue ||
        onChanged != oldWidget.onChanged;
  }

  static RadioGroup<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RadioGroup<T>>();
  }
}

/// Enhanced RadioListTile that works with RadioGroup
class RadioListTile<T> extends StatelessWidget {
  const RadioListTile({
    required this.value,
    required this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.activeColor,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.autofocus = false,
    this.contentPadding,
    this.shape,
    this.tileColor,
    this.selectedTileColor,
    this.visualDensity,
    this.focusNode,
    this.onFocusChange,
    this.enableFeedback,
    super.key,
  });

  final T value;
  final Widget title;
  final Widget? subtitle;
  final bool isThreeLine;
  final bool? dense;
  final Color? activeColor;
  final ListTileControlAffinity controlAffinity;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final ShapeBorder? shape;
  final Color? tileColor;
  final Color? selectedTileColor;
  final VisualDensity? visualDensity;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final bool? enableFeedback;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        leading: Radio<T>(
          value: value,
          activeColor: activeColor,
          focusNode: focusNode,
          autofocus: autofocus,
          visualDensity: visualDensity,
        ),
        title: title,
        subtitle: subtitle,
        isThreeLine: isThreeLine,
        dense: dense,
        contentPadding: contentPadding,
        onTap: () {
          final radioGroup = RadioGroup.of<T>(context);
          radioGroup?.onChanged?.call(value);
        },
        shape: shape,
        tileColor: tileColor,
        selectedTileColor: selectedTileColor,
        onFocusChange: onFocusChange,
        enableFeedback: enableFeedback,
      ),
    );
  }
}

class ThemeSettingsBottomSheet extends StatelessWidget {
  const ThemeSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        // Show snackbar on successful operations
        if (state is ThemeOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.primary,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        // Show error snackbar on failed operations
        if (state is ThemeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is! ThemeLoaded &&
            state is! ThemeOperationInProgress &&
            state is! ThemeOperationSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading theme settings...'),
                ],
              ),
            ),
          );
        }

        late ThemeLoaded themeState;
        if (state is ThemeLoaded) {
          themeState = state;
        } else if (state is ThemeOperationInProgress &&
            state.previousState != null) {
          themeState = state.previousState!;
        } else if (state is ThemeOperationSuccess) {
          themeState = state.updatedState;
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48),
                  SizedBox(height: 16),
                  Text('Unable to load theme settings'),
                ],
              ),
            ),
          );
        }

        final isLoading = state is ThemeOperationInProgress;

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Theme Settings',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    if (isLoading)
                      const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _ThemeModeSection(themeState: themeState, isLoading: isLoading),
                const SizedBox(height: 16),
                _FontSizeSection(themeState: themeState, isLoading: isLoading),
                const SizedBox(height: 16),
                _FontFamilySection(
                  themeState: themeState,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 16),
                _AppThemeSection(themeState: themeState, isLoading: isLoading),
                const SizedBox(height: 16),
                const _LanguageSection(),
                const SizedBox(height: 16),
                const _PreviewSection(),
                // Bottom padding for better scrolling
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThemeModeSection extends StatelessWidget {
  const _ThemeModeSection({
    required this.themeState,
    required this.isLoading,
  });

  final ThemeLoaded themeState;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.themeMode,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            RadioGroup<ThemeMode>(
              groupValue: themeState.themeMode,
              onChanged: (value) {
                if (isLoading || value == null) return;
                context.read<ThemeBloc>().add(
                      ThemeChangeModeEvent(themeMode: value),
                    );
              },
              child: Column(
                children: [
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.lightTheme),
                    value: ThemeMode.light,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.darkTheme),
                    value: ThemeMode.dark,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.systemTheme),
                    value: ThemeMode.system,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FontSizeSection extends StatelessWidget {
  const _FontSizeSection({
    required this.themeState,
    required this.isLoading,
  });

  final ThemeLoaded themeState;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.fontSize,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Slider(
              value: themeState.fontSize,
              min: 12,
              max: 24,
              divisions: 12,
              label: '${themeState.fontSize.round()}',
              onChanged: (value) {
                if (isLoading) return;
                context.read<ThemeBloc>().add(
                      ThemeChangeFontSizeEvent(fontSize: value),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FontFamilySection extends StatelessWidget {
  const _FontFamilySection({
    required this.themeState,
    required this.isLoading,
  });

  final ThemeLoaded themeState;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.fontFamily,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            RadioGroup<String>(
              groupValue: themeState.fontFamily,
              onChanged: (value) {
                if (isLoading || value == null) return;
                context.read<ThemeBloc>().add(
                      ThemeChangeFontFamilyEvent(fontFamily: value),
                    );
              },
              child: const Column(
                children: [
                  RadioListTile<String>(
                    title: Text('Roboto'),
                    value: 'Roboto',
                  ),
                  RadioListTile<String>(
                    title: Text('Poppins'),
                    value: 'Poppins',
                  ),
                  RadioListTile<String>(
                    title: Text('Merriweather'),
                    value: 'Merriweather',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppThemeSection extends StatelessWidget {
  const _AppThemeSection({
    required this.themeState,
    required this.isLoading,
  });

  final ThemeLoaded themeState;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.appTheme,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            RadioGroup<String>(
              groupValue: themeState.currentTheme.id,
              onChanged: (value) {
                if (isLoading || value == null) return;
                context.read<ThemeBloc>().add(
                      ThemeSwitchEvent(themeId: value),
                    );
              },
              child: Column(
                children: themeState.availableThemes.map((theme) {
                  return RadioListTile<String>(
                    title: Text(theme.name),
                    value: theme.id,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSection extends StatefulWidget {
  const _LanguageSection();

  @override
  State<_LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends State<_LanguageSection> {
  String _currentLanguage = 'en';

  @override
  void initState() {
    super.initState();
    unawaited(_loadCurrentLanguage());
  }

  Future<void> _loadCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString(ThemePreferences.languageKey) ??
        ThemePreferences.englishLanguage;
    if (mounted) {
      setState(() {
        _currentLanguage = language;
      });
    }
  }

  Future<void> _setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ThemePreferences.languageKey, languageCode);
    if (mounted) {
      setState(() {
        _currentLanguage = languageCode;
      });
      // Show restart dialog
      if (context.mounted) {
        await _showRestartDialog();
      }
    }
  }

  Future<void> _showRestartDialog() {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Language Changed'),
        content: const Text(
          'Please restart the app for the language change to take effect.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.language,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            RadioGroup<String>(
              groupValue: _currentLanguage,
              onChanged: (value) async {
                if (value != null) {
                  await _setLanguage(value);
                }
              },
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: Text(l10n.english),
                    value: 'en',
                  ),
                  RadioListTile<String>(
                    title: Text(l10n.vietnamese),
                    value: 'vi',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewSection extends StatelessWidget {
  const _PreviewSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.preview,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.sampleText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text(l10n.sampleButton),
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(value: 0.7),
            const SizedBox(height: 16),
            const ListTile(
              leading: Icon(Icons.star),
              title: Text('Sample ListTile'),
              subtitle: Text('This is a subtitle'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
