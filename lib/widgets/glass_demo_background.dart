import 'package:flutter/material.dart';

/// Background widget for Liquid Glass demo pages
///
/// Provides a beautiful gradient or image background to showcase
/// the glass effect more clearly.
class GlassDemoBackground extends StatelessWidget {
  const GlassDemoBackground({
    required this.child,
    this.useImage = false,
    super.key,
  });

  final Widget child;
  final bool useImage;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        // Gradient background for glass effect visibility
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF0F0F23), // Deep indigo
                  const Color(0xFF1A1A2E), // Dark blue
                  const Color(0xFF16213E), // Navy
                  const Color(0xFF0F3460), // Deep blue
                ]
              : [
                  const Color(0xFFE3F2FD), // Light blue
                  const Color(0xFFBBDEFB), // Sky blue
                  const Color(0xFF90CAF9), // Medium blue
                  const Color(0xFF64B5F6), // Bright blue
                ],
          stops: const [0.0, 0.3, 0.6, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Optional: Add decorative shapes for depth
          if (useImage) ..._buildDecorativeShapes(isDark),

          // Main content
          child,
        ],
      ),
    );
  }

  List<Widget> _buildDecorativeShapes(bool isDark) {
    return [
      // Top-left circle
      Positioned(
        top: -100,
        left: -100,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: isDark
                  ? [
                      const Color(0x40FF6B9D), // Pink
                      const Color(0x00FF6B9D),
                    ]
                  : [
                      const Color(0x60FFC371), // Orange
                      const Color(0x00FFC371),
                    ],
            ),
          ),
        ),
      ),

      // Bottom-right circle
      Positioned(
        bottom: -120,
        right: -120,
        child: Container(
          width: 350,
          height: 350,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: isDark
                  ? [
                      const Color(0x40C471ED), // Purple
                      const Color(0x00C471ED),
                    ]
                  : [
                      const Color(0x6042A5F5), // Blue
                      const Color(0x0042A5F5),
                    ],
            ),
          ),
        ),
      ),

      // Middle-left floating circle
      Positioned(
        top: 250,
        left: -50,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: isDark
                  ? [
                      const Color(0x3012D8FA), // Cyan
                      const Color(0x0012D8FA),
                    ]
                  : [
                      const Color(0x5026C6DA), // Teal
                      const Color(0x0026C6DA),
                    ],
            ),
          ),
        ),
      ),

      // Middle-right small circle
      Positioned(
        top: 400,
        right: 50,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: isDark
                  ? [
                      const Color(0x30FF9800), // Orange
                      const Color(0x00FF9800),
                    ]
                  : [
                      const Color(0x50FF6E40), // Deep orange
                      const Color(0x00FF6E40),
                    ],
            ),
          ),
        ),
      ),

      // Scattered small circles for depth
      Positioned(
        top: 150,
        right: 100,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: isDark
                  ? [
                      const Color(0x20FFFFFF),
                      const Color(0x00FFFFFF),
                    ]
                  : [
                      const Color(0x30FFFFFF),
                      const Color(0x00FFFFFF),
                    ],
            ),
          ),
        ),
      ),
    ];
  }
}

/// Animated background for more dynamic glass demo
class AnimatedGlassDemoBackground extends StatefulWidget {
  const AnimatedGlassDemoBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<AnimatedGlassDemoBackground> createState() =>
      _AnimatedGlassDemoBackgroundState();
}

class _AnimatedGlassDemoBackgroundState
    extends State<AnimatedGlassDemoBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      Color.lerp(
                        const Color(0xFF0F0F23),
                        const Color(0xFF1A1A2E),
                        _controller.value,
                      )!,
                      Color.lerp(
                        const Color(0xFF1A1A2E),
                        const Color(0xFF16213E),
                        _controller.value,
                      )!,
                      Color.lerp(
                        const Color(0xFF16213E),
                        const Color(0xFF0F3460),
                        _controller.value,
                      )!,
                      Color.lerp(
                        const Color(0xFF0F3460),
                        const Color(0xFF0F0F23),
                        _controller.value,
                      )!,
                    ]
                  : [
                      Color.lerp(
                        const Color(0xFFE3F2FD),
                        const Color(0xFFBBDEFB),
                        _controller.value,
                      )!,
                      Color.lerp(
                        const Color(0xFFBBDEFB),
                        const Color(0xFF90CAF9),
                        _controller.value,
                      )!,
                      Color.lerp(
                        const Color(0xFF90CAF9),
                        const Color(0xFF64B5F6),
                        _controller.value,
                      )!,
                      Color.lerp(
                        const Color(0xFF64B5F6),
                        const Color(0xFFE3F2FD),
                        _controller.value,
                      )!,
                    ],
              stops: const [0.0, 0.3, 0.6, 1.0],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
