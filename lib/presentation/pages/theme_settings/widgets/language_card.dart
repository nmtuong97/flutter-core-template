import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../theme/theme_preferences.dart';
import 'common/settings_card.dart';

/// Card component for language selection with restart handling
class LanguageCard extends StatefulWidget {
  const LanguageCard({super.key});

  @override
  State<LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard>
    with TickerProviderStateMixin {
  String _currentLanguage = 'en';
  bool _isLoading = false;

  late final AnimationController _flagController;
  late final Animation<double> _flagAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    unawaited(_loadCurrentLanguage());
  }

  @override
  void dispose() {
    _flagController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _flagController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _flagAnimation = Tween<double>(
      begin: 1,
      end: 1.1,
    ).animate(
      CurvedAnimation(
        parent: _flagController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _loadCurrentLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final language = prefs.getString(ThemePreferences.languageKey) ??
          ThemePreferences.englishLanguage;

      if (mounted) {
        setState(() {
          _currentLanguage = language;
        });
      }
    } on Exception catch (e) {
      debugPrint('Error loading language: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SettingsCard(
      title: l10n.language,
      subtitle: l10n.languageDescription,
      icon: Icons.language_rounded,
      isLoading: _isLoading,
      child: _buildLanguageOptions(context, l10n),
    );
  }

  Widget _buildLanguageOptions(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final languages = [
      _LanguageOption(
        code: 'en',
        name: l10n.english,
        nativeName: 'English',
        flag: '🇺🇸',
        description: l10n.englishDescription,
      ),
      _LanguageOption(
        code: 'vi',
        name: l10n.vietnamese,
        nativeName: 'Tiếng Việt',
        flag: '🇻🇳',
        description: l10n.vietnameseDescription,
      ),
    ];

    return Column(
      children: languages.map((language) {
        return _buildLanguageOption(context, language);
      }).toList(),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    _LanguageOption language,
  ) {
    final theme = Theme.of(context);
    final isSelected = language.code == _currentLanguage;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: isSelected
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: _isLoading || isSelected
              ? null
              : () => _handleLanguageChange(language.code),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildLanguageFlag(language, isSelected),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            language.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          if (language.nativeName != language.name) ...[
                            const SizedBox(width: 8),
                            Text(
                              '(${language.nativeName})',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        language.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSelectionIndicator(context, isSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageFlag(
    _LanguageOption language,
    bool isSelected,
  ) {
    return AnimatedBuilder(
      animation: _flagAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _flagAnimation.value : 1.0,
          child: child,
        );
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            language.flag,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(BuildContext context, bool isSelected) {
    final theme = Theme.of(context);

    if (isSelected) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          size: 16,
          color: theme.colorScheme.onPrimary,
        ),
      );
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outline,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  Future<void> _handleLanguageChange(String languageCode) async {
    if (_isLoading || languageCode == _currentLanguage) return;

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(ThemePreferences.languageKey, languageCode);

      if (mounted) {
        setState(() {
          _currentLanguage = languageCode;
          _isLoading = false;
        });

        // Trigger flag animation
        await _flagController.forward();
        await _flagController.reverse();

        // Show restart dialog
        if (mounted) {
          await _showRestartDialog(context);
        }
      }
    } on Exception catch (e) {
      debugPrint('Error saving language: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorSnackBar(context);
      }
    }
  }

  Future<void> _showRestartDialog(BuildContext context) async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(
          Icons.restart_alt_rounded,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(l10n.languageChanged),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.languageChangedDescription),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.restartNote,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (mounted) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(l10n.restartLater),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (mounted) {
                Navigator.of(dialogContext).pop();
                // In a real app, you might want to restart the app here
                // For now, we'll just show a message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.restartAppManually),
                  ),
                );
              }
            },
            icon: const Icon(Icons.restart_alt_rounded),
            label: Text(l10n.restartNow),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_rounded,
              color: Theme.of(context).colorScheme.onError,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(l10n.languageChangeError),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: SnackBarAction(
          label: l10n.retry,
          textColor: Theme.of(context).colorScheme.onError,
          onPressed: _loadCurrentLanguage,
        ),
      ),
    );
  }
}

/// Internal data class for language options
class _LanguageOption {
  const _LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
    required this.description,
  });

  final String code;
  final String name;
  final String nativeName;
  final String flag;
  final String description;
}
