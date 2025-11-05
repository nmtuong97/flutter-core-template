import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/glass_demo_background.dart';
import '../../widgets/liquid_glass.dart';
import 'liquid_glass_components_page.dart';
import 'liquid_glass_v2_demo_page.dart';

/// Liquid Glass Demo Page
///
/// Demonstrates all Liquid Glass components and use cases:
/// - Basic LiquidGlass containers
/// - Interactive AnimatedLiquidGlass
/// - Pre-configured variants (Card, AppBar, BottomSheet)
/// - Performance optimizations
/// - Best practices and anti-patterns
class LiquidGlassDemoPage extends StatefulWidget {
  const LiquidGlassDemoPage({super.key});

  @override
  State<LiquidGlassDemoPage> createState() => _LiquidGlassDemoPageState();
}

class _LiquidGlassDemoPageState extends State<LiquidGlassDemoPage> {
  bool _enableBlur = true;
  double _blurIntensity = 24.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedGlassDemoBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Let background show through
        // Demo: Liquid Glass App Bar
        appBar: LiquidGlassAppBar(
          title: Text(
            'Liquid Glass Demo',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.auto_awesome),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const LiquidGlassV2DemoPage(),
                  ),
                );
              },
              tooltip: 'See V2 (Package-based)',
            ),
            IconButton(
              icon: Icon(_enableBlur ? Icons.blur_on : Icons.blur_off),
              onPressed: () {
                setState(() => _enableBlur = !_enableBlur);
              },
            ),
          ],
          blur: _blurIntensity,
          elevation: true,
        ),

        // Main content with ListView
        body: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            // Performance Controls
            _buildPerformanceControls(),
            SizedBox(height: 24.h),

            // Section 1: Basic Glass Containers
            _buildSectionTitle('Basic Glass Containers'),
            SizedBox(height: 16.h),
            _buildBasicGlassExamples(),
            SizedBox(height: 24.h),

            // Section 2: Interactive Cards
            _buildSectionTitle('Interactive Cards'),
            SizedBox(height: 16.h),
            _buildInteractiveCards(),
            SizedBox(height: 24.h),

            // Section 3: Pre-configured Variants
            _buildSectionTitle('Pre-configured Components'),
            SizedBox(height: 16.h),
            _buildPreConfiguredVariants(),
            SizedBox(height: 24.h),

            // Section 4: Advanced Effects
            _buildSectionTitle('Advanced Effects'),
            SizedBox(height: 16.h),
            _buildAdvancedEffects(),
            SizedBox(height: 24.h),

            // Section 5: Use Cases
            _buildSectionTitle('Recommended Use Cases'),
            SizedBox(height: 16.h),
            _buildUseCases(),
            SizedBox(height: 24.h),

            // Section 6: Performance Tips
            _buildSectionTitle('Performance & Best Practices'),
            SizedBox(height: 16.h),
            _buildPerformanceTips(),
          ],
        ),

        // Demo: Floating Action Button with glass effect
        floatingActionButton: AnimatedLiquidGlass(
          blur: _blurIntensity,
          enableBlur: _enableBlur,
          borderRadius: 28.r,
          hoverScale: 1.05,
          onTap: () {
            _showLiquidGlassBottomSheet();
          },
          child: Container(
            width: 56.w,
            height: 56.h,
            alignment: Alignment.center,
            child: const Icon(Icons.info_outline, color: Colors.white),
          ),
        ),
      ), // Close Scaffold
    ); // Close AnimatedGlassDemoBackground
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildPerformanceControls() {
    return LiquidGlass(
      blur: _blurIntensity,
      enableBlur: _enableBlur,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Controls',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Text('Enable Blur: ${_enableBlur ? "ON" : "OFF"}'),
              ),
              Switch(
                value: _enableBlur,
                onChanged: (value) {
                  setState(() => _enableBlur = value);
                },
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text('Blur Intensity: ${_blurIntensity.toStringAsFixed(1)}'),
          Slider(
            value: _blurIntensity,
            min: 0,
            max: 30,
            divisions: 30,
            onChanged: (value) {
              setState(() => _blurIntensity = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBasicGlassExamples() {
    return Row(
      children: [
        // Low blur
        Expanded(
          child: LiquidGlass(
            blur: 16.0,
            enableBlur: _enableBlur,
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                const Icon(Icons.opacity, size: 32),
                SizedBox(height: 8.h),
                Text(
                  'Low Blur',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Sigma: 16',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        // Medium blur
        Expanded(
          child: LiquidGlass(
            blur: 24.0,
            enableBlur: _enableBlur,
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                const Icon(Icons.blur_on, size: 32),
                SizedBox(height: 8.h),
                Text(
                  'Medium Blur',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Sigma: 24',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        // High blur
        Expanded(
          child: LiquidGlass(
            blur: 30.0,
            enableBlur: _enableBlur,
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                const Icon(Icons.blur_circular, size: 32),
                SizedBox(height: 8.h),
                Text(
                  'High Blur',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Sigma: 30',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveCards() {
    return Column(
      children: [
        // Interactive hover card
        AnimatedLiquidGlass(
          blur: _blurIntensity,
          enableBlur: _enableBlur,
          hoverScale: 1.03,
          padding: EdgeInsets.all(16.w),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Card tapped!')),
            );
          },
          child: Row(
            children: [
              const Icon(Icons.touch_app, size: 48),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interactive Card',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Hover or tap to see micro-motion feedback',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        // Long press card
        AnimatedLiquidGlass(
          blur: _blurIntensity,
          enableBlur: _enableBlur,
          hoverScale: 1.02,
          padding: EdgeInsets.all(16.w),
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Long press detected!')),
            );
          },
          child: Row(
            children: [
              const Icon(Icons.touch_app_outlined, size: 48),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Long Press Card',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Long press to trigger action',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreConfiguredVariants() {
    return Column(
      children: [
        // Navigation to Components Page
        LiquidGlassCard(
          blur: _blurIntensity,
          enableBlur: _enableBlur,
          onTap: () {
            // Import at top of file
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const LiquidGlassComponentsPage(),
              ),
            );
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete UI Components',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'TextField, Button, Dialog, Navigation & more',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // LiquidGlassCard
        LiquidGlassCard(
          blur: _blurIntensity,
          enableBlur: _enableBlur,
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LiquidGlassCard',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              Text(
                'Pre-configured card with padding, margin, and elevation',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdvancedEffects() {
    return Column(
      children: [
        // Gradient overlay effect
        LiquidGlass(
          blur: _blurIntensity,
          enableBlur: _enableBlur,
          padding: EdgeInsets.all(16.w),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.1),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.gradient, size: 48),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Specular Highlight',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Gradient overlay simulates light reflection',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        // Shadow elevation effect
        LiquidGlass(
          blur: _blurIntensity,
          enableBlur: _enableBlur,
          padding: EdgeInsets.all(16.w),
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          child: Row(
            children: [
              const Icon(Icons.layers, size: 48),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elevation Shadow',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Soft shadow creates depth perception',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUseCases() {
    final useCases = [
      {
        'icon': Icons.dashboard,
        'title': 'System Overlays',
        'desc': 'Status bars, navigation bars, dock',
      },
      {
        'icon': Icons.music_note,
        'title': 'Floating Controls',
        'desc': 'Music player, chat heads',
      },
      {
        'icon': Icons.dialpad,
        'title': 'Dialogs & Modals',
        'desc': 'Alert dialogs, bottom sheets',
      },
      {
        'icon': Icons.layers,
        'title': 'Cards & Tiles',
        'desc': 'Interactive content cards',
      },
    ];

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: useCases.map((useCase) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 48.w) / 2,
          child: LiquidGlassCard(
            blur: _blurIntensity,
            enableBlur: _enableBlur,
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Icon(useCase['icon'] as IconData, size: 32),
                SizedBox(height: 8.h),
                Text(
                  useCase['title'] as String,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Text(
                  useCase['desc'] as String,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPerformanceTips() {
    final tips = [
      {
        'icon': Icons.speed,
        'title': 'Disable on Low-end',
        'desc': 'Set enableBlur=false for devices with FPS < 50',
      },
      {
        'icon': Icons.visibility_off,
        'title': 'Avoid Complex Backgrounds',
        'desc': "Don't use on videos or complex animations",
      },
      {
        'icon': Icons.text_fields,
        'title': 'Dense Text Areas',
        'desc': 'Use solid backgrounds for forms and text-heavy content',
      },
    ];

    return Column(
      children: tips.map((tip) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: LiquidGlass(
            blur: _blurIntensity,
            enableBlur: _enableBlur,
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Icon(tip['icon'] as IconData, size: 32),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip['title'] as String,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        tip['desc'] as String,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showLiquidGlassBottomSheet() {
    LiquidGlassBottomSheet.show<void>(
      context: context,
      blur: _blurIntensity,
      enableBlur: _enableBlur,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Liquid Glass Bottom Sheet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 16.h),
          Text(
            'This is a modal bottom sheet with glass effect. '
            'It uses stronger blur (sigma: 30) to separate from background content.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
