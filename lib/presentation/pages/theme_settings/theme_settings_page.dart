import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_event.dart';
import '../../blocs/theme/theme_state.dart';
import 'widgets/theme_settings_view.dart';

/// Main theme settings page that provides a comprehensive interface for
/// theme customization with professional UI/UX
class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  /// Route name for navigation
  static const String routeName = '/theme-settings';

  /// Route generator for the theme settings page
  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ThemeSettingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        // Handle state changes and show appropriate feedback
        _handleStateChanges(context, state, l10n);
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildAppBar(context, l10n),
            const SliverToBoxAdapter(
              child: ThemeSettingsView(),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the custom app bar with gradient background and actions
  Widget _buildAppBar(BuildContext context, AppLocalizations l10n) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          l10n.themeSettings,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.8),
                Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withValues(alpha: 0.6),
              ],
            ),
          ),
        ),
      ),
      actions: [
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: state is ThemeOperationInProgress
                  ? null
                  : () {
                      context.read<ThemeBloc>().add(
                            const ThemeResetToDefaultEvent(),
                          );
                    },
              tooltip: l10n.resetToDefault,
            );
          },
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert_rounded),
          onSelected: (value) => _handleMenuAction(context, value),
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'export',
              child: Row(
                children: [
                  const Icon(Icons.download_rounded),
                  const SizedBox(width: 8),
                  Text(l10n.exportSettings),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'import',
              child: Row(
                children: [
                  const Icon(Icons.upload_rounded),
                  const SizedBox(width: 8),
                  Text(l10n.importSettings),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'share',
              child: Row(
                children: [
                  const Icon(Icons.share_rounded),
                  const SizedBox(width: 8),
                  Text(l10n.shareTheme),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Handles state changes and provides user feedback
  void _handleStateChanges(
    BuildContext context,
    ThemeState state,
    AppLocalizations l10n,
  ) {
    if (state is ThemeOperationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(state.message)),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (state is ThemeError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.error_rounded,
                color: Theme.of(context).colorScheme.onError,
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(state.message)),
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
            onPressed: () {
              context.read<ThemeBloc>().add(const ThemeLoadCurrentEvent());
            },
          ),
        ),
      );
    }
  }

  /// Handles menu actions from the overflow menu
  Future<void> _handleMenuAction(BuildContext context, String action) async {
    switch (action) {
      case 'export':
        await _showExportDialog(context);
      case 'import':
        await _showImportDialog(context);
      case 'share':
        await _showShareDialog(context);
    }
  }

  /// Shows export settings dialog
  Future<void> _showExportDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.exportSettings),
        content: Text(l10n.exportSettingsDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Export functionality to be implemented
            },
            child: Text(l10n.export),
          ),
        ],
      ),
    );
  }

  /// Shows import settings dialog
  Future<void> _showImportDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.importSettings),
        content: Text(l10n.importSettingsDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Import functionality to be implemented
            },
            child: Text(l10n.import),
          ),
        ],
      ),
    );
  }

  /// Shows share theme dialog
  Future<void> _showShareDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.shareTheme),
        content: Text(l10n.shareThemeDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Share functionality to be implemented
            },
            child: Text(l10n.share),
          ),
        ],
      ),
    );
  }
}
