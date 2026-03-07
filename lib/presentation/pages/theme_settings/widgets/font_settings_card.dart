import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../blocs/theme/theme_bloc.dart';
import '../../../blocs/theme/theme_event.dart';
import '../../../blocs/theme/theme_state.dart';
import 'common/settings_card.dart';

/// Card component for font settings including size and family selection
/// with real-time preview and professional controls
class FontSettingsCard extends StatefulWidget {
  const FontSettingsCard({
    required this.themeState,
    required this.isLoading,
    super.key,
  });

  /// Current theme state
  final ThemeLoaded themeState;

  /// Whether the card is in loading state
  final bool isLoading;

  @override
  State<FontSettingsCard> createState() => _FontSettingsCardState();
}

class _FontSettingsCardState extends State<FontSettingsCard>
    with TickerProviderStateMixin {
  late final AnimationController _previewController;
  late final Animation<double> _previewAnimation;

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
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _previewAnimation = Tween<double>(
      begin: 1,
      end: 1.1,
    ).animate(
      CurvedAnimation(
        parent: _previewController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SettingsCard(
      title: l10n.fontSettings,
      subtitle: l10n.fontSettingsDescription,
      icon: Icons.text_fields_rounded,
      isLoading: widget.isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFontSizeSection(context, l10n),
          const SizedBox(height: 24),
          _buildFontFamilySection(context, l10n),
          const SizedBox(height: 16),
          _buildPreviewSection(context, l10n),
        ],
      ),
    );
  }

  Widget _buildFontSizeSection(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.fontSize,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${widget.themeState.fontSize.round()}px',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildFontSizeSlider(context, theme),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '12px',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '24px',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFontSizeSlider(BuildContext context, ThemeData theme) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: theme.colorScheme.primary,
        inactiveTrackColor: theme.colorScheme.surfaceContainerHighest,
        thumbColor: theme.colorScheme.primary,
        overlayColor: theme.colorScheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: theme.colorScheme.primary,
        valueIndicatorTextStyle: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(),
        overlayShape: const RoundSliderOverlayShape(
          overlayRadius: 20,
        ),
      ),
      child: Slider(
        value: widget.themeState.fontSize,
        min: 12,
        max: 24,
        divisions: 24,
        label: '${widget.themeState.fontSize.round()}px',
        onChanged: widget.isLoading ? null : _handleFontSizeChange,
        onChangeStart: (_) => _previewController.forward(),
        onChangeEnd: (_) => _previewController.reverse(),
      ),
    );
  }

  Widget _buildFontFamilySection(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final fontFamilies = [
      _FontFamilyOption(
        name: 'Roboto',
        displayName: 'Roboto',
        description: l10n.robotoDescription,
        sample: 'The quick brown fox jumps',
      ),
      _FontFamilyOption(
        name: 'Poppins',
        displayName: 'Poppins',
        description: l10n.poppinsDescription,
        sample: 'The quick brown fox jumps',
      ),
      _FontFamilyOption(
        name: 'Merriweather',
        displayName: 'Merriweather',
        description: l10n.merriweatherDescription,
        sample: 'The quick brown fox jumps',
      ),
      _FontFamilyOption(
        name: 'Inter',
        displayName: 'Inter',
        description: l10n.interDescription,
        sample: 'The quick brown fox jumps',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.fontFamily,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...fontFamilies.map((font) => _buildFontFamilyOption(context, font)),
      ],
    );
  }

  Widget _buildFontFamilyOption(
    BuildContext context,
    _FontFamilyOption fontOption,
  ) {
    final theme = Theme.of(context);
    final isSelected = fontOption.name == widget.themeState.fontFamily;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: isSelected
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: widget.isLoading || isSelected
              ? null
              : () => _handleFontFamilyChange(fontOption.name),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            fontOption.displayName,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontFamily: fontOption.name,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 8),
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: theme.colorScheme.primary,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fontOption.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        fontOption.sample,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: fontOption.name,
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewSection(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.preview_rounded,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.fontPreview,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: _previewAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _previewAnimation.value,
                child: child,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.fontPreviewHeadline,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontFamily: widget.themeState.fontFamily,
                    fontSize: widget.themeState.fontSize * 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.fontPreviewBody,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontFamily: widget.themeState.fontFamily,
                    fontSize: widget.themeState.fontSize,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.fontPreviewCaption,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: widget.themeState.fontFamily,
                    fontSize: widget.themeState.fontSize * 0.85,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleFontSizeChange(double value) {
    context.read<ThemeBloc>().add(
          ThemeChangeFontSizeEvent(fontSize: value),
        );
  }

  void _handleFontFamilyChange(String fontFamily) {
    context.read<ThemeBloc>().add(
          ThemeChangeFontFamilyEvent(fontFamily: fontFamily),
        );
  }
}

/// Internal data class for font family options
class _FontFamilyOption {
  const _FontFamilyOption({
    required this.name,
    required this.displayName,
    required this.description,
    required this.sample,
  });

  final String name;
  final String displayName;
  final String description;
  final String sample;
}
