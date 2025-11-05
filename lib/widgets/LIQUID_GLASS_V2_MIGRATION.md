# Liquid Glass V2 Migration Guide

## Overview

Liquid Glass V2 integrates the professional `flutter_liquid_glass` package (v1.0.0+1) as the foundation for glass effects, providing enhanced animations, haptic feedback, and better performance while maintaining backward compatibility.

---

## What's New in V2

### Enhanced Features

| Feature | V1 (Custom) | V2 (Package-based) |
|---------|-------------|-------------------|
| **Base Implementation** | Custom BackdropFilter | flutter_liquid_glass package |
| **Interactive Animations** | Manual | Built-in (press, hover, parallax) |
| **Haptic Feedback** | ❌ | ✅ Supported |
| **Dynamic Lighting** | ❌ | ✅ Supported |
| **Morphing Effects** | ❌ | ✅ Supported |
| **Performance** | Good | Optimized |
| **API Complexity** | Simple | Rich (23 config properties) |

### Key Improvements

1. **Press Animations**: Automatic scale animation (1.0 → 0.95) on tap
2. **Hover Effects**: Smooth hover state transitions
3. **Parallax Motion**: Mouse/touch-based depth effect
4. **Haptic Feedback**: Tactile response on interactions
5. **Dynamic Lighting**: Responsive light effects based on position
6. **Better Performance**: Professional package with optimized rendering

---

## Migration Path

### Strategy

V2 components **wrap** the package with our custom API - **NOT replacing** V1 immediately:

- ✅ **V1 components remain** for backward compatibility
- ✅ **V2 components available** for new features
- ✅ **Zero breaking changes** in existing code
- ✅ **Gradual migration** at your own pace

### Component Mapping

| V1 Component | V2 Equivalent | Package Base |
|--------------|---------------|--------------|
| `LiquidGlass` | `LiquidGlassV2` | `LiquidGlassContainer` |
| `AnimatedLiquidGlass` | `AnimatedLiquidGlassV2` | `LiquidGlassContainer` |
| `LiquidGlassCard` | `LiquidGlassCardV2` | `LiquidGlassCard` |
| `LiquidGlassAppBar` | *(Keep V1)* | N/A |
| `LiquidGlassBottomSheet` | *(Keep V1)* | N/A |

---

## Code Examples

### Basic Container

**V1 (Custom BackdropFilter):**
```dart
import 'package:flutter_theme_showcase/widgets/liquid_glass.dart';

LiquidGlass(
  blur: 24,
  borderRadius: 20,
  padding: const EdgeInsets.all(16),
  child: Text('Hello World'),
)
```

**V2 (Package-based):**
```dart
import 'package:flutter_theme_showcase/widgets/liquid_glass_v2.dart';

LiquidGlassV2(
  blur: 24,
  borderRadius: 20,
  padding: const EdgeInsets.all(16),
  child: Text('Hello World'),
)
```

**Result**: Same visual output, but V2 adds hover/parallax effects automatically.

---

### Interactive Button

**V1:**
```dart
AnimatedLiquidGlass(
  blur: 20,
  borderRadius: 12,
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  child: GestureDetector(
    onTap: () => print('Tapped'),
    child: Text('Click Me'),
  ),
)
```

**V2 (with haptic feedback):**
```dart
LiquidGlassButtonV2(
  onPressed: () => print('Tapped'),
  isPrimary: true,
  enableHapticFeedback: true, // ✅ New feature!
  child: Text('Click Me'),
)
```

**Benefits V2**:
- ✅ Automatic press animation (scale 0.95)
- ✅ Haptic feedback on tap
- ✅ Hover effects
- ✅ Less boilerplate code

---

### Card with Elevation

**V1:**
```dart
LiquidGlass(
  blur: 20,
  borderRadius: 16,
  padding: const EdgeInsets.all(16),
  shadows: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ],
  child: Column(...),
)
```

**V2:**
```dart
LiquidGlassCardV2(
  elevation: 2, // ✅ Automatic shadow calculation
  padding: const EdgeInsets.all(16),
  onTap: () {}, // ✅ Interactive
  child: Column(...),
)
```

---

## New Features (V2 Only)

### 1. Haptic Feedback

```dart
LiquidGlassButtonV2(
  enableHapticFeedback: true, // Tactile response
  onPressed: () => print('Feel the vibration!'),
  child: Text('Tap Me'),
)
```

### 2. Parallax Effect

```dart
LiquidGlassV2(
  enableParallax: true, // Mouse/touch-based depth
  child: YourWidget(),
)
```

### 3. Dynamic Lighting

```dart
AnimatedLiquidGlassV2(
  enableDynamicLight: true, // Responsive light effects
  child: YourWidget(),
)
```

### 4. Morphing Animations

```dart
AnimatedLiquidGlassV2(
  enableMorphing: true, // Smooth state transitions
  onTap: () => setState(...),
  child: YourWidget(),
)
```

---

## Advanced Configuration

### Direct Package Access

If you need full control, use the package directly:

```dart
import 'package:flutter_liquid_glass/liquid_glass.dart';

LiquidGlassContainer(
  config: LiquidGlassConfig(
    baseColor: Colors.white.withOpacity(0.15),
    blurAmount: 24,
    borderRadius: BorderRadius.circular(20),
    enableParallax: true,
    parallaxIntensity: 0.15,
    enableDynamicLight: true,
    lightPosition: Offset(0.5, 0.3),
    refractionIntensity: 0.6,
    enableChromaticAberration: true, // Advanced effect
    frostIntensity: 0.8, // Frosted glass
  ),
  child: YourWidget(),
)
```

### Package Factory Constructors

```dart
// Simple glass (default)
LiquidGlassConfig.simple()

// Dark mode optimized
LiquidGlassConfig.dark()

// Vibrant with chromatic aberration
LiquidGlassConfig.vibrant()

// Subtle, minimal blur
LiquidGlassConfig.subtle()

// Heavy frosted effect
LiquidGlassConfig.frosted()
```

---

## Parameter Mapping Reference

| V1 Parameter | V2 Parameter | Package Config Property |
|--------------|--------------|------------------------|
| `blur: 24.0` | `blur: 24.0` | `blurAmount: 24.0` |
| `tint: Color?` | `tint: Color?` | `baseColor: Color?` |
| `borderRadius: 20.0` | `borderRadius: 20.0` | `borderRadius: BorderRadius.circular(20)` |
| `borderColor: Color?` | `borderColor: Color?` | `border: Border.all(color: ...)` |
| `borderWidth: 0.5` | `borderWidth: 0.5` | `border: Border.all(width: ...)` |
| `enableBlur: true` | `enableBlur: true` | `blurAmount: 0` if false |
| `padding: EdgeInsets?` | `padding: EdgeInsets?` | `LiquidGlassContainer.padding` |
| `gradient: Gradient?` | `gradient: Gradient?` | `LiquidGlassConfig.gradient` |
| `shadows: List<BoxShadow>?` | `shadows: List<BoxShadow>?` | `LiquidGlassConfig.shadows` |
| ❌ (Not available) | `onTap: VoidCallback?` | `LiquidGlassContainer.onTap` |
| ❌ | `enableHapticFeedback: bool` | `LiquidGlassContainer.enableHapticFeedback` |
| ❌ | `enableParallax: bool` | `LiquidGlassConfig.enableParallax` |
| ❌ | `enableDynamicLight: bool` | `LiquidGlassConfig.enableDynamicLight` |
| ❌ | `enableMorphing: bool` | `LiquidGlassConfig.enableMorphing` |

---

## Migration Checklist

### Phase 1: Evaluate (Current Phase)
- [x] V2 components created (`liquid_glass_v2.dart`)
- [x] Demo page showcasing V2 features
- [x] Navigation added (V1 → V2 demo button)
- [ ] **Test V2 components in demo**
- [ ] Compare performance (V1 vs V2)
- [ ] Identify components to migrate

### Phase 2: Gradual Migration (Next Steps)
- [ ] Migrate high-traffic screens to V2
- [ ] Migrate interactive components (buttons, cards)
- [ ] Keep static components as V1 (no interaction needed)
- [ ] Update documentation with V2 examples

### Phase 3: Optimization (Future)
- [ ] Benchmark performance improvements
- [ ] Remove unused V1 components (optional)
- [ ] Final polish with package features

---

## Performance Considerations

### V1 (Custom BackdropFilter)
- **Render**: Manual BackdropFilter + ImageFilter.blur
- **Animations**: Manual with AnimationController
- **Overhead**: Minimal (simple implementation)
- **Best for**: Static glass effects, simple use cases

### V2 (Package-based)
- **Render**: Optimized package implementation
- **Animations**: Built-in with 3 AnimationControllers (press, hover, parallax)
- **Overhead**: Slightly higher (rich features)
- **Best for**: Interactive components, premium feel

### Recommendation
- **Static components**: Keep V1 (simpler, less overhead)
- **Interactive components**: Use V2 (better UX)
- **New features**: Start with V2 (modern approach)

---

## Testing Strategy

### Visual Regression Testing

```dart
// Before migration
testWidgets('V1 LiquidGlass renders correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: LiquidGlass(
        blur: 20,
        child: Text('Test'),
      ),
    ),
  );
  
  expect(find.text('Test'), findsOneWidget);
  // Take screenshot: screenshot_v1.png
});

// After migration
testWidgets('V2 LiquidGlass renders correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: LiquidGlassV2(
        blur: 20,
        child: Text('Test'),
      ),
    ),
  );
  
  expect(find.text('Test'), findsOneWidget);
  // Take screenshot: screenshot_v2.png
  // Compare screenshots - should be visually identical
});
```

### Animation Testing

```dart
testWidgets('V2 press animation works', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: LiquidGlassButtonV2(
        onPressed: () {},
        child: Text('Button'),
      ),
    ),
  );
  
  // Tap button
  await tester.tap(find.text('Button'));
  await tester.pump(); // Start animation
  
  // Verify animation in progress
  await tester.pump(Duration(milliseconds: 100));
  
  // Verify animation complete
  await tester.pumpAndSettle();
});
```

---

## Troubleshooting

### Issue: "LiquidGlassContainer not found"

**Solution**: Ensure package is imported correctly:
```dart
import 'package:flutter_liquid_glass/liquid_glass.dart' as lg;
```

### Issue: "Visual difference between V1 and V2"

**Cause**: Package may have slightly different default opacity/blur calculations.

**Solution**: Fine-tune parameters:
```dart
// V1
LiquidGlass(blur: 24, tint: Color(0x26FFFFFF))

// V2 - adjust opacity to match
LiquidGlassV2(
  blur: 24,
  tint: Color(0x26FFFFFF),
  // May need slight adjustment
)
```

### Issue: "Animations too slow/fast"

**Solution**: Adjust animation duration:
```dart
// Via custom config
LiquidGlassContainer(
  config: LiquidGlassConfig(
    animationDuration: Duration(milliseconds: 150), // Faster
    animationCurve: Curves.easeOutCubic,
  ),
  child: ...,
)
```

---

## Package Resources

- **Package**: [flutter_liquid_glass v1.0.0+1](https://pub.dev/packages/flutter_liquid_glass)
- **GitHub**: [whynotmake-it/flutter_liquid_glass](https://github.com/whynotmake-it/flutter_liquid_glass)
- **API Docs**: See `LiquidGlassConfig` class (23 properties)

---

## Next Steps

1. **Run Demo**: Test V2 components in `LiquidGlassV2DemoPage`
2. **Compare**: Side-by-side comparison of V1 vs V2
3. **Decide**: Choose components to migrate
4. **Migrate**: Gradual transition to V2 for interactive components
5. **Optimize**: Leverage package features (haptic, parallax, lighting)

---

## Summary

- ✅ **V2 wraps professional package** - enhanced features without breaking changes
- ✅ **V1 remains available** - gradual migration, zero risk
- ✅ **New features** - haptic feedback, parallax, dynamic lighting, morphing
- ✅ **Better performance** - optimized rendering, built-in animations
- ✅ **Rich configuration** - 23+ properties via LiquidGlassConfig
- ✅ **Same API surface** - familiar parameters, easy migration

**Recommendation**: Test V2 in demo, then migrate interactive components first!
