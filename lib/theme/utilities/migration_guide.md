# Theme System Migration Guide

## Tổng quan

Hướng dẫn này giúp bạn chuyển đổi từ hệ thống theme builder cũ sang hệ thống configuration-based mới để:
- Loại bỏ code duplication
- Tập trung hóa theme settings
- Cải thiện performance và maintainability

## Kiến trúc mới

### 1. Theme Configuration System
```dart
// Thay vì hardcode values
final theme = CyberpunkThemeBuilder().build();

// Sử dụng configuration
final config = ThemeConfiguration.cyberpunk();
final theme = ThemeFactory.createTheme(config);
```

### 2. Centralized Utilities
- `ThemeHelper`: Text styles và component themes
- `ThemeFactory`: Theme creation từ configurations
- `ThemeUtilities`: Validation và performance tools

## Migration Steps

### Bước 1: Update Theme Creation

**Trước:**
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DefaultThemeBuilder().build(Brightness.light),
      darkTheme: DefaultThemeBuilder().build(Brightness.dark),
    );
  }
}
```

**Sau:**
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = ThemeConfiguration.defaultTheme();
    return MaterialApp(
      theme: ThemeFactory.createLightTheme(config),
      darkTheme: ThemeFactory.createDarkTheme(config),
    );
  }
}
```

### Bước 2: Replace Custom Text Styles

**Trước:**
```dart
TextStyle _getTextStyle(String fontFamily, double fontSize) {
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    // ... duplicate logic
  );
}
```

**Sau:**
```dart
final config = ThemeConfiguration.defaultTheme();
final textStyle = ThemeHelper.createTextStyle(
  config: config,
  fontSize: 16,
  fontWeight: FontWeight.normal,
);
```

### Bước 3: Update Component Themes

**Trước:**
```dart
ElevatedButtonThemeData _buildButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // ... hardcoded values
    ),
  );
}
```

**Sau:**
```dart
final config = ThemeConfiguration.defaultTheme();
final buttonTheme = ThemeHelper.createElevatedButtonTheme(config);
```

## Configuration Options

### Available Themes
1. `ThemeConfiguration.defaultTheme()` - Clean, modern design
2. `ThemeConfiguration.cyberpunk()` - Neon, futuristic style
3. `ThemeConfiguration.glassmorphism()` - Glass-like effects
4. `ThemeConfiguration.neumorphism()` - Soft, elevated appearance

### Custom Configuration
```dart
final customConfig = ThemeConfiguration(
  colors: ColorConfiguration.cyberpunk(),
  fonts: FontFamilyConfiguration.defaultConfig(),
  typography: TypographyConfiguration.cyberpunk(),
  components: ComponentConfiguration.cyberpunk(),
  shadows: ShadowConfiguration.cyberpunk(),
  animations: AnimationConfiguration.cyberpunk(),
);
```

## Performance Benefits

### Before Migration
- Code duplication across 4+ theme builders
- Hardcoded magic numbers
- Inconsistent styling patterns
- Manual theme switching logic

### After Migration
- Single source of truth for configurations
- Reusable utility methods
- Consistent theming patterns
- Optimized theme creation

## Validation

### Run Analysis
```dart
final validator = ThemeUtilities();
final issues = validator.validateTheme(theme);
print('Theme validation: ${issues.isEmpty ? "PASSED" : "FAILED"}');
```

### Performance Benchmarking
```dart
final benchmark = ThemeUtilities.benchmarkThemeCreation(
  () => ThemeFactory.createTheme(config),
);
print('Theme creation time: ${benchmark.inMilliseconds}ms');
```

## Migration Checklist

- [ ] Replace theme builders với ThemeFactory
- [ ] Update hardcoded values với ThemeConfiguration
- [ ] Migrate custom text styles sang ThemeHelper
- [ ] Update component themes
- [ ] Run theme validation
- [ ] Test performance improvements
- [ ] Update documentation
- [ ] Remove deprecated builder classes

## Troubleshooting

### Common Issues
1. **Missing imports**: Ensure all new utility classes are imported
2. **Configuration mismatch**: Verify theme configuration matches expected style
3. **Performance regression**: Use ThemeUtilities.benchmarkThemeCreation() to identify bottlenecks

### Support
Nếu gặp vấn đề trong quá trình migration, hãy:
1. Kiểm tra theme validation results
2. So sánh performance benchmarks
3. Xem lại configuration settings
4. Tham khảo example implementations trong `/lib/theme/examples/`