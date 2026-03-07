import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/theme_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../blocs/theme/theme_bloc.dart';
import '../../../blocs/theme/theme_event.dart';
import '../../../blocs/theme/theme_state.dart';
import 'common/loading_overlay.dart';
import 'common/settings_card.dart';

/// Card component for app theme selection with visual grid and previews
class AppThemeCard extends StatefulWidget {
  const AppThemeCard({
    required this.themeState,
    required this.isLoading,
    super.key,
  });

  /// Current theme state
  final ThemeLoaded themeState;

  /// Whether the card is in loading state
  final bool isLoading;

  @override
  State<AppThemeCard> createState() => _AppThemeCardState();
}

class _AppThemeCardState extends State<AppThemeCard>
    with TickerProviderStateMixin {
  late final AnimationController _gridController;
  late final Animation<double> _gridAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  @override
  void dispose() {
    _gridController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _gridController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _gridAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _gridController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start the animation
    unawaited(_gridController.forward());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SettingsCard(
      title: l10n.appTheme,
      subtitle: l10n.appThemeDescription,
      icon: Icons.color_lens_rounded,
      isLoading: widget.isLoading,
      child: AnimatedBuilder(
        animation: _gridAnimation,
        builder: (context, child) {
          return FadeTransition(
            opacity: _gridAnimation,
            child: child,
          );
        },
        child: _buildThemeGrid(context, l10n),
      ),
    );
  }

  Widget _buildThemeGrid(BuildContext context, AppLocalizations l10n) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final crossAxisCount = isTablet ? 3 : 2;
    final aspectRatio = isTablet ? 1.2 : 1.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: aspectRatio,
      ),
      itemCount: widget.themeState.availableThemes.length,
      itemBuilder: (context, index) {
        final theme = widget.themeState.availableThemes[index];
        final isSelected = theme.id == widget.themeState.currentTheme.id;

        return _buildThemePreviewCard(context, theme, isSelected, index);
      },
    );
  }

  Widget _buildThemePreviewCard(
    BuildContext context,
    ThemeEntity themeEntity,
    bool isSelected,
    int index,
  ) {
    return AnimatedBuilder(
      animation: _gridController,
      builder: (context, child) {
        final delay = index * 0.1;
        final animationValue = Curves.easeOutCubic.transform(
          (_gridAnimation.value - delay).clamp(0.0, 1.0),
        );

        return Transform.translate(
          offset: Offset(0, (1 - animationValue) * 50),
          child: Opacity(
            opacity: animationValue,
            child: child,
          ),
        );
      },
      child: ThemePreviewCard(
        themeEntity: themeEntity,
        isSelected: isSelected,
        isLoading: widget.isLoading,
        onTap: () => _handleThemeSelection(themeEntity.id),
      ),
    );
  }

  void _handleThemeSelection(String themeId) {
    if (widget.isLoading || themeId == widget.themeState.currentTheme.id) {
      return;
    }

    context.read<ThemeBloc>().add(
          ThemeSwitchEvent(themeId: themeId),
        );
  }
}

/// Individual theme preview card widget
class ThemePreviewCard extends StatefulWidget {
  const ThemePreviewCard({
    required this.themeEntity,
    required this.isSelected,
    required this.onTap,
    this.isLoading = false,
    super.key,
  });

  /// Theme entity to preview
  final ThemeEntity themeEntity;

  /// Whether this theme is currently selected
  final bool isSelected;

  /// Whether loading state is active
  final bool isLoading;

  /// Callback when card is tapped
  final VoidCallback onTap;

  @override
  State<ThemePreviewCard> createState() => _ThemePreviewCardState();
}

class _ThemePreviewCardState extends State<ThemePreviewCard>
    with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final AnimationController _selectionController;
  late final Animation<double> _hoverAnimation;
  late final Animation<double> _selectionAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    if (widget.isSelected) {
      unawaited(_selectionController.forward());
    }
  }

  @override
  void didUpdateWidget(ThemePreviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        unawaited(_selectionController.forward());
      } else {
        unawaited(_selectionController.reverse());
      }
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _selectionController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _selectionController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _hoverAnimation = Tween<double>(
      begin: 1,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeInOut,
      ),
    );

    _selectionAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _selectionController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: Listenable.merge([_hoverAnimation, _selectionAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _hoverAnimation.value,
          child: Material(
            elevation: widget.isSelected ? 8 : 2,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            color: widget.isSelected
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.surface,
            child: InkWell(
              onTap: widget.isLoading ? null : widget.onTap,
              onHover: (hovering) {
                if (hovering) {
                  unawaited(_hoverController.forward());
                } else {
                  unawaited(_hoverController.reverse());
                }
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withValues(alpha: 0.2),
                    width: widget.isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    _buildPreviewContent(context, theme),
                    _buildSelectionOverlay(context, theme),
                    if (widget.isLoading)
                      const ShimmerLoading(child: SizedBox.expand()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreviewContent(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Theme name
          Text(
            widget.themeEntity.name,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: widget.isSelected
                  ? theme.colorScheme.onPrimaryContainer
                  : theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // Theme description
          Text(
            widget.themeEntity.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: widget.isSelected
                  ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7)
                  : theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const Spacer(),

          // Color palette preview
          _buildColorPalette(context, theme),
        ],
      ),
    );
  }

  Widget _buildColorPalette(BuildContext context, ThemeData theme) {
    // Mock color palette based on theme entity
    final colors = _getThemeColors(widget.themeEntity);

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 24,
            child: Row(
              children: colors
                  .map(
                    (color) => Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: colors.indexOf(color) == 0
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                )
                              : colors.indexOf(color) == colors.length - 1
                                  ? const BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4),
                                    )
                                  : null,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionOverlay(BuildContext context, ThemeData theme) {
    return AnimatedBuilder(
      animation: _selectionAnimation,
      builder: (context, child) {
        if (!widget.isSelected && _selectionAnimation.value == 0) {
          return const SizedBox.shrink();
        }

        return Positioned(
          top: 8,
          right: 8,
          child: Opacity(
            opacity: _selectionAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(4),
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
          ),
        );
      },
    );
  }

  List<Color> _getThemeColors(ThemeEntity themeEntity) {
    // This is a mock implementation. In a real app, you would
    // extract colors from the theme entity's color scheme
    switch (themeEntity.id) {
      case 'default':
        return [
          const Color(0xFF6750A4),
          const Color(0xFF625B71),
          const Color(0xFF7D5260),
          const Color(0xFF006A6B),
        ];
      case 'cyberpunk':
        return [
          const Color(0xFFFF0080),
          const Color(0xFF00FFFF),
          const Color(0xFFFFFF00),
          const Color(0xFF8A2BE2),
        ];
      case 'neumorphism':
        return [
          const Color(0xFFE0E5EC),
          const Color(0xFFA3B1C6),
          const Color(0xFF9BAACF),
          const Color(0xFF6C7B7F),
        ];
      case 'glassmorphism':
        return [
          const Color(0x80FFFFFF),
          const Color(0x60007AFF),
          const Color(0x8000D4FF),
          const Color(0x60FF6B9D),
        ];
      default:
        return [
          const Color(0xFF6750A4),
          const Color(0xFF625B71),
          const Color(0xFF7D5260),
          const Color(0xFF006A6B),
        ];
    }
  }
}
