import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../blocs/theme/theme_bloc.dart';
import '../../../blocs/theme/theme_event.dart';
import '../../../blocs/theme/theme_state.dart';
import 'common/settings_card.dart';

/// Card component for theme mode selection (Light, Dark, System)
/// with immediate state updates and visual previews
class ThemeModeCard extends StatelessWidget {
  const ThemeModeCard({
    required this.themeState,
    required this.isLoading,
    super.key,
  });

  /// Current theme state
  final ThemeLoaded themeState;

  /// Whether the card is in loading state
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SettingsCard(
      title: l10n.themeMode,
      subtitle: l10n.themeModeDescription,
      icon: Icons.palette_rounded,
      isLoading: isLoading,
      child: _buildThemeModeOptions(context, l10n),
    );
  }

  Widget _buildThemeModeOptions(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final themeModes = [
      _ThemeModeOption(
        mode: ThemeMode.light,
        title: l10n.lightTheme,
        subtitle: l10n.lightThemeDescription,
        icon: Icons.light_mode_rounded,
      ),
      _ThemeModeOption(
        mode: ThemeMode.dark,
        title: l10n.darkTheme,
        subtitle: l10n.darkThemeDescription,
        icon: Icons.dark_mode_rounded,
      ),
      _ThemeModeOption(
        mode: ThemeMode.system,
        title: l10n.systemTheme,
        subtitle: l10n.systemThemeDescription,
        icon: Icons.auto_mode_rounded,
      ),
    ];

    return Column(
      children: themeModes.map((option) {
        return _buildThemeModeOption(context, option);
      }).toList(),
    );
  }

  Widget _buildThemeModeOption(
    BuildContext context,
    _ThemeModeOption option,
  ) {
    final theme = Theme.of(context);
    final isSelected = option.mode == themeState.themeMode;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: isSelected
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: isLoading || isSelected
              ? null
              : () => _handleThemeModeChange(context, option.mode),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildThemePreview(context, option, isSelected),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        option.subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected) ...[
                  Container(
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
                  ),
                ] else ...[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.outline,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemePreview(
    BuildContext context,
    _ThemeModeOption option,
    bool isSelected,
  ) {
    final theme = Theme.of(context);

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outline,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: _buildModePreviewContent(context, option),
      ),
    );
  }

  Widget _buildModePreviewContent(
    BuildContext context,
    _ThemeModeOption option,
  ) {
    switch (option.mode) {
      case ThemeMode.light:
        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFBFE),
                Color(0xFFF7F2FA),
              ],
            ),
          ),
          child: Center(
            child: Icon(
              option.icon,
              size: 20,
              color: const Color(0xFF1C1B1F),
            ),
          ),
        );
      case ThemeMode.dark:
        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1C1B1F),
                Color(0xFF2A2D2F),
              ],
            ),
          ),
          child: Center(
            child: Icon(
              option.icon,
              size: 20,
              color: const Color(0xFFE6E1E5),
            ),
          ),
        );
      case ThemeMode.system:
        return Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFBFE),
                      Color(0xFFF7F2FA),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1C1B1F),
                      Color(0xFF2A2D2F),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }

  void _handleThemeModeChange(BuildContext context, ThemeMode mode) {
    context.read<ThemeBloc>().add(
          ThemeChangeModeEvent(themeMode: mode),
        );
  }
}

/// Internal data class for theme mode options
class _ThemeModeOption {
  const _ThemeModeOption({
    required this.mode,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final ThemeMode mode;
  final String title;
  final String subtitle;
  final IconData icon;
}
