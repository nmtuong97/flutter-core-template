import 'package:flutter/material.dart';
import '../../widgets/glass_demo_background.dart';
import '../../widgets/liquid_glass_v2.dart';

/// Liquid Glass V2 Demo Page - Enhanced with flutter_liquid_glass package
///
/// This page showcases the new V2 components that use the professional
/// flutter_liquid_glass package as their foundation. Key improvements:
/// - Better interactive animations (press, hover, parallax)
/// - Optimized performance with built-in effects
/// - Haptic feedback support
/// - Dynamic lighting effects
class LiquidGlassV2DemoPage extends StatelessWidget {
  const LiquidGlassV2DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedGlassDemoBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton: _buildFAB(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const LiquidGlassV2(
        blur: 20,
        borderRadius: 12,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          'Liquid Glass V2',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: LiquidGlassV2(
            blur: 20,
            borderRadius: 12,
            padding: const EdgeInsets.all(8),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings tapped')),
              );
            },
            child: const Icon(Icons.settings, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFeatureOverview(context),
        const SizedBox(height: 24),
        _buildButtonShowcase(context),
        const SizedBox(height: 24),
        _buildCardShowcase(context),
        const SizedBox(height: 24),
        _buildInteractiveDemo(context),
        const SizedBox(height: 24),
        _buildComparisonSection(context),
      ],
    );
  }

  Widget _buildFeatureOverview(BuildContext context) {
    final theme = Theme.of(context);

    return LiquidGlassCardV2(
      padding: const EdgeInsets.all(20),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Enhanced Features',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(
            context,
            icon: Icons.touch_app,
            title: 'Interactive Animations',
            description: 'Press, hover, and parallax effects built-in',
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            context,
            icon: Icons.vibration,
            title: 'Haptic Feedback',
            description: 'Tactile response on interactions',
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            context,
            icon: Icons.flash_on,
            title: 'Dynamic Lighting',
            description: 'Responsive light effects based on position',
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            context,
            icon: Icons.speed,
            title: 'Optimized Performance',
            description: 'Professional package with better rendering',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.primary.withValues(alpha: 0.8),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonShowcase(BuildContext context) {
    final theme = Theme.of(context);

    return LiquidGlassCardV2(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Button Variants',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LiquidGlassButtonV2(
                  onPressed: () {},
                  isPrimary: true,
                  child: const Text('Primary'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LiquidGlassButtonV2(
                  onPressed: () {},
                  child: const Text('Secondary'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LiquidGlassButtonV2(
            onPressed: () {},
            width: double.infinity,
            isPrimary: true,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.rocket_launch, size: 20),
                SizedBox(width: 8),
                Text('Full Width Button'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardShowcase(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Card Variants',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: LiquidGlassCardV2(
                elevation: 1,
                onTap: () {},
                child: Column(
                  children: [
                    Icon(
                      Icons.wb_sunny_outlined,
                      size: 32,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Low Elevation',
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LiquidGlassCardV2(
                elevation: 3,
                onTap: () {},
                child: Column(
                  children: [
                    Icon(
                      Icons.nights_stay_outlined,
                      size: 32,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'High Elevation',
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInteractiveDemo(BuildContext context) {
    final theme = Theme.of(context);

    return LiquidGlassCardV2(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.gesture,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Try Interactive Effects',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedLiquidGlassV2(
            borderRadius: 16,
            padding: const EdgeInsets.all(20),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feel the haptic feedback! 🎉'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            onLongPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Long press detected! ⏱️'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: Column(
              children: [
                Icon(
                  Icons.touch_app,
                  size: 48,
                  color: theme.colorScheme.primary.withValues(alpha: 0.8),
                ),
                const SizedBox(height: 12),
                Text(
                  'Tap or Long Press',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Notice the press animation and haptic feedback',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection(BuildContext context) {
    final theme = Theme.of(context);

    return LiquidGlassCardV2(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'V1 vs V2 Comparison',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildComparisonRow(
            context,
            feature: 'Base Implementation',
            v1: 'Custom BackdropFilter',
            v2: 'flutter_liquid_glass package',
          ),
          const Divider(height: 24),
          _buildComparisonRow(
            context,
            feature: 'Animations',
            v1: 'Manual',
            v2: 'Built-in (press, hover, parallax)',
          ),
          const Divider(height: 24),
          _buildComparisonRow(
            context,
            feature: 'Haptic Feedback',
            v1: '❌',
            v2: '✅',
          ),
          const Divider(height: 24),
          _buildComparisonRow(
            context,
            feature: 'Dynamic Lighting',
            v1: '❌',
            v2: '✅',
          ),
          const Divider(height: 24),
          _buildComparisonRow(
            context,
            feature: 'Performance',
            v1: 'Good',
            v2: 'Optimized',
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    BuildContext context, {
    required String feature,
    required String v1,
    required String v2,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            feature,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            v1,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            v2,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFAB(BuildContext context) {
    return AnimatedLiquidGlassV2(
      blur: 20,
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(Icons.arrow_back, size: 24),
    );
  }
}
