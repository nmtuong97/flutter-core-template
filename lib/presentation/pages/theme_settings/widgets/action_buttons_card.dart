import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../blocs/theme/theme_bloc.dart';
import '../../../blocs/theme/theme_event.dart';
import '../../../blocs/theme/theme_state.dart';
import 'common/settings_card.dart';

/// Card component for action buttons like reset, export, import, and share
class ActionButtonsCard extends StatefulWidget {
  const ActionButtonsCard({
    required this.themeState,
    required this.isLoading,
    super.key,
  });

  /// Current theme state
  final ThemeLoaded themeState;

  /// Whether the card is in loading state
  final bool isLoading;

  @override
  State<ActionButtonsCard> createState() => _ActionButtonsCardState();
}

class _ActionButtonsCardState extends State<ActionButtonsCard>
    with TickerProviderStateMixin {
  late final AnimationController _buttonController;
  late final Animation<double> _buttonAnimation;

  bool _isExporting = false;
  bool _isImporting = false;

  // Global references for ScaffoldMessenger and Navigator
  static ScaffoldMessengerState? _scaffoldMessenger;
  static NavigatorState? _navigator;

  // Method to set global references
  static void setGlobalReferences(BuildContext context) {
    _scaffoldMessenger = ScaffoldMessenger.of(context);
    _navigator = Navigator.of(context);
  }

  // Method to show snackbars using global reference
  static void showSuccessSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    _scaffoldMessenger?.showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: textColor,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Method to show error snackbars using global reference
  static void showErrorSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    _scaffoldMessenger?.showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_rounded,
                  color: textColor,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: TextStyle(
                color: textColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Method to show reset confirmation dialog using global reference
  static Future<bool> showResetConfirmationDialog({
    required Color errorColor,
    required String title,
    required String content,
    required String cancelText,
    required String resetText,
  }) async {
    if (_navigator == null) return false;

    return _navigator!
        .push(
          DialogRoute<bool>(
            context: _navigator!.context,
            builder: (dialogContext) => AlertDialog(
              icon: Icon(
                Icons.warning_amber_rounded,
                size: 32,
                color: errorColor,
              ),
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(cancelText),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: errorColor,
                  ),
                  child: Text(resetText),
                ),
              ],
            ),
          ),
        )
        .then((value) => value ?? false);
  }

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _buttonAnimation = Tween<double>(
      begin: 1,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Set global references when building
    setGlobalReferences(context);

    final l10n = AppLocalizations.of(context);

    return SettingsCard(
      title: l10n.actions,
      subtitle: l10n.actionsDescription,
      icon: Icons.settings_applications_rounded,
      isLoading: widget.isLoading,
      child: Column(
        children: [
          _buildActionButtonsRow(context, l10n),
          const SizedBox(height: 12),
          _buildSecondaryActionsRow(context, l10n),
        ],
      ),
    );
  }

  Widget _buildActionButtonsRow(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: _buildResetButton(context, l10n),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildExportButton(context, l10n),
        ),
      ],
    );
  }

  Widget _buildSecondaryActionsRow(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildImportButton(context, l10n),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildShareButton(context, l10n),
        ),
      ],
    );
  }

  Widget _buildResetButton(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _buttonAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _buttonAnimation.value,
          child: child,
        );
      },
      child: OutlinedButton.icon(
        onPressed: widget.isLoading ? null : () => _handleReset(context, l10n),
        icon: Icon(
          Icons.restart_alt_rounded,
          color: theme.colorScheme.error,
        ),
        label: Text(
          l10n.resetToDefault,
          style: TextStyle(
            color: theme.colorScheme.error,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: theme.colorScheme.error.withValues(alpha: 0.5),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildExportButton(BuildContext context, AppLocalizations l10n) {
    return ElevatedButton.icon(
      onPressed: widget.isLoading || _isExporting
          ? null
          : () => _handleExport(context, l10n),
      icon: _isExporting
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          : const Icon(Icons.download_rounded),
      label: Text(l10n.export),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }

  Widget _buildImportButton(BuildContext context, AppLocalizations l10n) {
    return FilledButton.icon(
      onPressed: widget.isLoading || _isImporting
          ? null
          : () => _handleImport(context, l10n),
      icon: _isImporting
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          : const Icon(Icons.upload_rounded),
      label: Text(l10n.import),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }

  Widget _buildShareButton(BuildContext context, AppLocalizations l10n) {
    return TextButton.icon(
      onPressed: widget.isLoading ? null : () => _handleShare(context, l10n),
      icon: const Icon(Icons.share_rounded),
      label: Text(l10n.share),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }

  Future<void> _handleReset(BuildContext context, AppLocalizations l10n) async {
    // Store all necessary data before any async operations
    final bloc = context.read<ThemeBloc>();
    final errorColor = Theme.of(context).colorScheme.error;

    await _buttonController.forward();
    await _buttonController.reverse();

    if (!mounted) return;

    // Extract all necessary data before the async operation
    final resetConfirmationTitle = l10n.resetConfirmationTitle;
    final resetConfirmationDescription = l10n.resetConfirmationDescription;
    final cancelText = l10n.cancel;
    final resetText = l10n.reset;

    // Show dialog with extracted data using global reference
    final confirmed = await showResetConfirmationDialog(
      errorColor: errorColor,
      title: resetConfirmationTitle,
      content: resetConfirmationDescription,
      cancelText: cancelText,
      resetText: resetText,
    );

    if (confirmed && mounted) {
      bloc.add(const ThemeResetToDefaultEvent());
    }
  }

  Future<void> _handleExport(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    setState(() => _isExporting = true);

    // Extract theme data before async operations
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final errorColor = Theme.of(context).colorScheme.error;
    final onErrorColor = Theme.of(context).colorScheme.onError;

    try {
      final themeData = _createThemeExportData();
      final jsonString = jsonEncode(themeData);

      // Copy to clipboard
      await Clipboard.setData(ClipboardData(text: jsonString));

      if (!mounted) return;
      // Use global reference for snackbar
      showSuccessSnackBar(
        title: l10n.exportSuccess,
        message: l10n.exportSuccessDescription,
        backgroundColor: primaryColor,
        textColor: onPrimaryColor,
      );
    } on Exception catch (e) {
      if (!mounted) return;
      // Use global reference for snackbar
      showErrorSnackBar(
        title: l10n.exportError,
        message: e.toString(),
        backgroundColor: errorColor,
        textColor: onErrorColor,
      );
    }
    if (mounted) {
      setState(() => _isExporting = false);
    }
  }

  Future<void> _handleImport(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    setState(() => _isImporting = true);

    // Extract theme data and bloc before async operations
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final errorColor = Theme.of(context).colorScheme.error;
    final onErrorColor = Theme.of(context).colorScheme.onError;
    final bloc = context.read<ThemeBloc>();

    try {
      // Get clipboard data
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (!mounted) return;
      if (clipboardData?.text == null || clipboardData!.text!.isEmpty) {
        // Extract necessary data before calling the snackbar method
        final errorMessage = l10n.noClipboardData;
        // Use global reference for snackbar
        showErrorSnackBar(
          title: 'Import Error',
          message: errorMessage,
          backgroundColor: errorColor,
          textColor: onErrorColor,
        );
        if (mounted) {
          setState(() => _isImporting = false);
        }
        return;
      }

      // Parse JSON
      final Map<String, dynamic> themeData;
      try {
        themeData = jsonDecode(clipboardData.text!) as Map<String, dynamic>;
      } on FormatException {
        if (!mounted) return;
        // Extract necessary data before calling the snackbar method
        final errorMessage = l10n.invalidThemeData;
        // Use global reference for snackbar
        showErrorSnackBar(
          title: 'Import Error',
          message: errorMessage,
          backgroundColor: errorColor,
          textColor: onErrorColor,
        );
        if (mounted) {
          setState(() => _isImporting = false);
        }
        return;
      }

      // Validate theme data
      if (!_validateThemeData(themeData)) {
        if (!mounted) return;
        // Extract necessary data before calling the snackbar method
        final errorMessage = l10n.invalidThemeFormat;
        // Use global reference for snackbar
        showErrorSnackBar(
          title: 'Import Error',
          message: errorMessage,
          backgroundColor: errorColor,
          textColor: onErrorColor,
        );
        if (mounted) {
          setState(() => _isImporting = false);
        }
        return;
      }

      // Apply theme data
      await _applyImportedThemeDataWithBloc(bloc, themeData);

      if (!mounted) return;
      // Use global reference for snackbar
      showSuccessSnackBar(
        title: l10n.importSuccess,
        message: l10n.importSuccessDescription,
        backgroundColor: primaryColor,
        textColor: onPrimaryColor,
      );
    } on Exception catch (e) {
      if (!mounted) return;
      // Use global reference for snackbar
      showErrorSnackBar(
        title: l10n.importError,
        message: e.toString(),
        backgroundColor: errorColor,
        textColor: onErrorColor,
      );
    }
    if (mounted) {
      setState(() => _isImporting = false);
    }
  }

  Future<void> _handleShare(BuildContext context, AppLocalizations l10n) async {
    // Extract theme data before async operations
    final errorColor = Theme.of(context).colorScheme.error;
    final onErrorColor = Theme.of(context).colorScheme.onError;

    try {
      final themeData = _createThemeExportData();
      final jsonString = jsonEncode(themeData);

      // Extract necessary data before async operation
      final shareText = '''
${l10n.shareThemeText}

${l10n.themeName}: ${widget.themeState.currentTheme.name}
${l10n.themeMode}: ${widget.themeState.themeMode.name}
${l10n.fontSize}: ${widget.themeState.fontSize}px
${l10n.fontFamily}: ${widget.themeState.fontFamily}

${l10n.themeConfiguration}:
$jsonString
''';
      final subject = l10n.shareThemeSubject;

      await SharePlus.instance.share(
        ShareParams(text: shareText, subject: subject),
      );
    } on Exception catch (e) {
      if (!mounted) return;
      // Use global reference for snackbar
      showErrorSnackBar(
        title: l10n.shareError,
        message: e.toString(),
        backgroundColor: errorColor,
        textColor: onErrorColor,
      );
    }
  }

  Map<String, dynamic> _createThemeExportData() {
    return {
      'version': '1.0',
      'theme': {
        'id': widget.themeState.currentTheme.id,
        'name': widget.themeState.currentTheme.name,
        'mode': widget.themeState.themeMode.name,
        'fontSize': widget.themeState.fontSize,
        'fontFamily': widget.themeState.fontFamily,
      },
      'exportedAt': DateTime.now().toIso8601String(),
      'exportedFrom': 'Flutter Core Template',
    };
  }

  bool _validateThemeData(Map<String, dynamic> data) {
    try {
      return data.containsKey('version') &&
          data.containsKey('theme') &&
          data['theme'] is Map<String, dynamic> &&
          (data['theme'] as Map<String, dynamic>).containsKey('id') &&
          (data['theme'] as Map<String, dynamic>).containsKey('mode') &&
          (data['theme'] as Map<String, dynamic>).containsKey('fontSize') &&
          (data['theme'] as Map<String, dynamic>).containsKey('fontFamily');
    } on Exception {
      return false;
    }
  }

  // New method that doesn't require BuildContext
  Future<void> _applyImportedThemeDataWithBloc(
    ThemeBloc bloc,
    Map<String, dynamic> data,
  ) async {
    final themeData = data['theme'] as Map<String, dynamic>;

    // Apply theme ID
    if (themeData['id'] != widget.themeState.currentTheme.id) {
      bloc.add(ThemeSwitchEvent(themeId: themeData['id'] as String));
    }

    // Apply theme mode
    final modeName = themeData['mode'] as String;
    final themeMode = ThemeMode.values.firstWhere(
      (mode) => mode.name == modeName,
      orElse: () => ThemeMode.system,
    );
    if (themeMode != widget.themeState.themeMode) {
      bloc.add(ThemeChangeModeEvent(themeMode: themeMode));
    }

    // Apply font size
    final fontSize = (themeData['fontSize'] as num).toDouble();
    if (fontSize != widget.themeState.fontSize) {
      bloc.add(ThemeChangeFontSizeEvent(fontSize: fontSize));
    }

    // Apply font family
    final fontFamily = themeData['fontFamily'] as String;
    if (fontFamily != widget.themeState.fontFamily) {
      bloc.add(ThemeChangeFontFamilyEvent(fontFamily: fontFamily));
    }
  }
}
