import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../blocs/theme/theme_state.dart';
import 'common/settings_card.dart';

/// Comprehensive preview card showing how the current theme looks
/// with various UI components and typography
class PreviewCard extends StatefulWidget {
  const PreviewCard({
    required this.themeState,
    super.key,
  });

  /// Current theme state
  final ThemeLoaded themeState;

  @override
  State<PreviewCard> createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard>
    with TickerProviderStateMixin {
  late final AnimationController _previewController;
  late final Animation<double> _slideAnimation;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  @override
  void dispose() {
    _previewController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _previewController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _previewController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start the animation
    unawaited(_previewController.forward());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SettingsCard(
      title: l10n.preview,
      subtitle: l10n.previewDescription,
      icon: Icons.preview_rounded,
      child: AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(_slideAnimation),
            child: FadeTransition(
              opacity: _slideAnimation,
              child: child,
            ),
          );
        },
        child: Column(
          children: [
            _buildPreviewTabs(context, l10n),
            const SizedBox(height: 16),
            _buildPreviewContent(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewTabs(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    final tabs = [
      _PreviewTab(
        label: l10n.components,
        icon: Icons.widgets_rounded,
      ),
      _PreviewTab(
        label: l10n.typography,
        icon: Icons.text_fields_rounded,
      ),
      _PreviewTab(
        label: l10n.colors,
        icon: Icons.palette_rounded,
      ),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == _selectedTab;

          return Expanded(
            child: Material(
              color:
                  isSelected ? theme.colorScheme.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () => setState(() => _selectedTab = index),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tab.icon,
                        size: 16,
                        color: isSelected
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        tab.label,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: isSelected
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurfaceVariant,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPreviewContent(BuildContext context, AppLocalizations l10n) {
    switch (_selectedTab) {
      case 0:
        return _buildComponentsPreview(context, l10n);
      case 1:
        return _buildTypographyPreview(context, l10n);
      case 2:
        return _buildColorsPreview(context, l10n);
      default:
        return _buildComponentsPreview(context, l10n);
    }
  }

  Widget _buildComponentsPreview(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Buttons
          Text(
            l10n.buttons,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(l10n.primary),
              ),
              FilledButton(
                onPressed: () {},
                child: Text(l10n.filled),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text(l10n.outlined),
              ),
              TextButton(
                onPressed: () {},
                child: Text(l10n.text),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Input Fields
          Text(
            l10n.inputFields,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.sampleTextField,
              prefixIcon: const Icon(Icons.search_rounded),
              border: const OutlineInputBorder(),
            ),
            enabled: false,
          ),
          const SizedBox(height: 16),

          // Cards and Lists
          Text(
            l10n.cardsAndLists,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.star_rounded,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              title: Text(l10n.sampleListTile),
              subtitle: Text(l10n.sampleSubtitle),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Progress Indicators
          Text(
            l10n.progressIndicators,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              LinearProgressIndicator(
                value: 0.7,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      l10n.loadingIndicator,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypographyPreview(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display Large
          Text(
            l10n.displayLarge,
            style: theme.textTheme.displayLarge?.copyWith(
              fontFamily: widget.themeState.fontFamily,
              fontSize: (theme.textTheme.displayLarge?.fontSize ?? 57) *
                  (widget.themeState.fontSize / 14),
            ),
          ),
          const SizedBox(height: 8),

          // Headline
          Text(
            l10n.headlineMedium,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontFamily: widget.themeState.fontFamily,
              fontSize: (theme.textTheme.headlineMedium?.fontSize ?? 28) *
                  (widget.themeState.fontSize / 14),
            ),
          ),
          const SizedBox(height: 8),

          // Title
          Text(
            l10n.titleLarge,
            style: theme.textTheme.titleLarge?.copyWith(
              fontFamily: widget.themeState.fontFamily,
              fontSize: (theme.textTheme.titleLarge?.fontSize ?? 22) *
                  (widget.themeState.fontSize / 14),
            ),
          ),
          const SizedBox(height: 8),

          // Body Large
          Text(
            l10n.bodyLarge,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontFamily: widget.themeState.fontFamily,
              fontSize: widget.themeState.fontSize,
            ),
          ),
          const SizedBox(height: 8),

          // Body Medium
          Text(
            l10n.bodyMedium,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: widget.themeState.fontFamily,
              fontSize: widget.themeState.fontSize * 0.9,
            ),
          ),
          const SizedBox(height: 8),

          // Body Small
          Text(
            l10n.bodySmall,
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: widget.themeState.fontFamily,
              fontSize: widget.themeState.fontSize * 0.8,
            ),
          ),
          const SizedBox(height: 8),

          // Label
          Text(
            l10n.labelMedium,
            style: theme.textTheme.labelMedium?.copyWith(
              fontFamily: widget.themeState.fontFamily,
              fontSize: widget.themeState.fontSize * 0.85,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorsPreview(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primary Colors
          _buildColorSection(
            context,
            l10n.primaryColors,
            [
              _ColorSwatch('Primary', theme.colorScheme.primary),
              _ColorSwatch('On Primary', theme.colorScheme.onPrimary),
              _ColorSwatch(
                'Primary Container',
                theme.colorScheme.primaryContainer,
              ),
              _ColorSwatch(
                'On Primary Container',
                theme.colorScheme.onPrimaryContainer,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Secondary Colors
          _buildColorSection(
            context,
            l10n.secondaryColors,
            [
              _ColorSwatch('Secondary', theme.colorScheme.secondary),
              _ColorSwatch('On Secondary', theme.colorScheme.onSecondary),
              _ColorSwatch(
                'Secondary Container',
                theme.colorScheme.secondaryContainer,
              ),
              _ColorSwatch(
                'On Secondary Container',
                theme.colorScheme.onSecondaryContainer,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Surface Colors
          _buildColorSection(
            context,
            l10n.surfaceColors,
            [
              _ColorSwatch('Surface', theme.colorScheme.surface),
              _ColorSwatch('On Surface', theme.colorScheme.onSurface),
              _ColorSwatch(
                'Surface Variant',
                theme.colorScheme.surfaceContainerHighest,
              ),
              _ColorSwatch(
                'On Surface Variant',
                theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorSection(
    BuildContext context,
    String title,
    List<_ColorSwatch> colors,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: colors.map((colorSwatch) {
            return _buildColorSwatch(context, colorSwatch);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColorSwatch(BuildContext context, _ColorSwatch colorSwatch) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorSwatch.color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            colorSwatch.name,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Internal data class for preview tabs
class _PreviewTab {
  const _PreviewTab({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

/// Internal data class for color swatches
class _ColorSwatch {
  const _ColorSwatch(this.name, this.color);

  final String name;
  final Color color;
}
