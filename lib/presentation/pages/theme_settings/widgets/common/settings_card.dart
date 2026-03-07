import 'package:flutter/material.dart';

/// Base settings card widget that provides consistent styling and behavior
/// for all theme settings sections
class SettingsCard extends StatelessWidget {
  const SettingsCard({
    required this.title,
    required this.child,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
    this.isLoading = false,
    this.elevation,
    this.margin,
    this.padding,
    super.key,
  });

  /// The main title of the settings card
  final String title;

  /// Optional subtitle for additional information
  final String? subtitle;

  /// Optional icon to display at the beginning of the title
  final IconData? icon;

  /// Optional trailing widget (e.g., switch, button)
  final Widget? trailing;

  /// Main content of the card
  final Widget child;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  /// Whether the card is in loading state
  final bool isLoading;

  /// Card elevation
  final double? elevation;

  /// Card margin
  final EdgeInsetsGeometry? margin;

  /// Card padding
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        elevation: elevation ?? 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, theme),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  _buildSubtitle(context, theme),
                ],
                const SizedBox(height: 16),
                AnimatedOpacity(
                  opacity: isLoading ? 0.5 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the header section with title, icon, and trailing widget
  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        ?trailing,
        if (isLoading) ...[
          const SizedBox(width: 8),
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Builds the subtitle section
  Widget _buildSubtitle(BuildContext context, ThemeData theme) {
    return Text(
      subtitle!,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

/// Specialized settings card for sections with multiple options
class OptionsSettingsCard extends SettingsCard {
  const OptionsSettingsCard({
    required super.title,
    required this.options,
    this.selectedValue,
    this.onSelectionChanged,
    super.subtitle,
    super.icon,
    super.isLoading = false,
    super.key,
  }) : super(child: const SizedBox.shrink());

  /// List of available options
  final List<SettingsOption> options;

  /// Currently selected value
  final dynamic selectedValue;

  /// Callback when selection changes
  final ValueChanged<dynamic>? onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      isLoading: isLoading,
      child: _buildOptionsList(context),
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    return Column(
      children: options.map((option) {
        final isSelected = option.value == selectedValue;
        return _buildOptionTile(context, option, isSelected);
      }).toList(),
    );
  }

  Widget _buildOptionTile(
    BuildContext context,
    SettingsOption option,
    bool isSelected,
  ) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: isSelected
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: isLoading || option.value == selectedValue
              ? null
              : () => onSelectionChanged?.call(option.value),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              children: [
                if (option.icon != null) ...[
                  Icon(
                    option.icon,
                    size: 20,
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                      if (option.subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          option.subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Data class representing a settings option
class SettingsOption {
  const SettingsOption({
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
  });

  /// Display title for the option
  final String title;

  /// Subtitle for additional information
  final String? subtitle;

  /// Icon for the option
  final IconData? icon;

  /// Value associated with this option
  final dynamic value;
}
