# Flutter Theme System Documentation

## Tổng quan

Hệ thống theme này được thiết kế theo các nguyên tắc Clean Architecture và SOLID principles, cung cấp một giải pháp linh hoạt và có thể mở rộng cho việc quản lý theme trong ứng dụng Flutter.

## Cấu trúc thư mục

```
lib/theme/
├── base/                    # Interfaces và base classes
│   ├── theme_interfaces.dart
│   └── app_theme.dart
├── builders/               # Theme builders
│   └── theme_builder.dart
├── colors/                 # Color management
│   ├── color_palette.dart
│   └── color_extensions.dart
├── constants/              # Theme constants
│   └── theme_constants.dart
├── extensions/             # Theme extensions
│   └── theme_extensions.dart
├── themes/                 # Concrete theme implementations
│   ├── exaggerated_minimalism_theme.dart
│   ├── modern_elegance_theme.dart
│   └── vibrant_creativity_theme.dart
├── typography/             # Typography system
│   └── theme_typography.dart
├── validators/             # Theme validation
│   └── theme_validator.dart
├── theme_preferences.dart  # Theme preferences
└── theme_provider.dart     # Theme provider
```

## Kiến trúc

### 1. Interface Segregation Principle (ISP)

Hệ thống sử dụng các interface riêng biệt để tách biệt các chức năng:

```dart
// Base interface
abstract class BaseTheme {
  String get id;
  String get name;
  String get description;
  bool get isDefault;
}

// Light theme support
abstract class LightThemeProvider {
  ThemeData get lightThemeData;
  bool get supportsLightMode;
}

// Dark theme support
abstract class DarkThemeProvider {
  ThemeData get darkThemeData;
  bool get supportsDarkMode;
}
```

### 2. Builder Pattern

`ThemeBuilder` cung cấp một cách nhất quán để tạo theme:

```dart
class ThemeBuilder {
  static ThemeData buildLightTheme({
    required ColorPalette colorPalette,
    required ThemeTypography typography,
  }) {
    // Implementation
  }
  
  static ThemeData buildDarkTheme({
    required ColorPalette colorPalette,
    required ThemeTypography typography,
  }) {
    // Implementation
  }
}
```

### 3. Type-Safe Color Management

`ColorPalette` cung cấp quản lý màu sắc an toàn:

```dart
class ColorPalette {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color error;
  
  // Validation methods
  bool get isValid => _validateColors();
  
  // Color scheme generation
  ColorScheme toLightColorScheme() => ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.light,
  );
}
```

## Sử dụng

### 1. Tạo Theme mới

```dart
class MyCustomTheme extends BaseTheme 
    with LightThemeProvider, DarkThemeProvider {
  @override
  String get id => 'my_custom_theme';
  
  @override
  String get name => 'My Custom Theme';
  
  @override
  String get description => 'A beautiful custom theme';
  
  @override
  ThemeData get lightThemeData => ThemeBuilder.buildLightTheme(
    colorPalette: _colorPalette,
    typography: _typography,
  );
  
  @override
  ThemeData get darkThemeData => ThemeBuilder.buildDarkTheme(
    colorPalette: _colorPalette,
    typography: _typography,
  );
  
  final ColorPalette _colorPalette = ColorPalette(
    primary: Colors.blue,
    secondary: Colors.orange,
    // ...
  );
  
  final ThemeTypography _typography = ThemeTypography();
}
```

### 2. Sử dụng ThemeProvider

```dart
// Trong main.dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

// Trong widget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: themeProvider.currentLightTheme,
          darkTheme: themeProvider.currentDarkTheme,
          themeMode: themeProvider.themeMode,
          // ...
        );
      },
    );
  }
}
```

### 3. Thay đổi Theme

```dart
// Thay đổi theme
context.read<ThemeProvider>().setTheme('modern_elegance');

// Thay đổi theme mode
context.read<ThemeProvider>().setThemeMode(ThemeMode.dark);

// Lấy danh sách themes có sẵn
final availableThemes = context.read<ThemeProvider>().availableThemes;
```

## Tính năng nâng cao

### 1. Theme Validation

```dart
final validator = ThemeValidator();
final result = validator.validateTheme(myTheme);

if (!result.isValid) {
  print('Theme validation errors:');
  result.errors.forEach(print);
}

if (result.warnings.isNotEmpty) {
  print('Theme validation warnings:');
  result.warnings.forEach(print);
}
```

### 2. Performance Optimization

Hệ thống typography sử dụng caching để tối ưu hiệu suất:

```dart
// Typography với caching tự động
final typography = ThemeTypography();
final textStyle = typography.getTextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

// Kiểm tra cache stats
final stats = typography.cacheStats;
print('Cache hit rate: ${stats['hitRate']}%');
```

### 3. Theme Consistency

```dart
// Validate theme consistency
final consistencyResult = validator.validateThemeConsistency(myTheme);

// Validate performance
final performanceResult = validator.validateThemePerformance(myTheme);
```

## Best Practices

### 1. Theme Design

- **Consistency**: Sử dụng `ThemeValidator` để đảm bảo tính nhất quán
- **Accessibility**: Đảm bảo contrast ratio tối thiểu 4.5:1
- **Performance**: Sử dụng `const` constructors khi có thể
- **Modularity**: Tách biệt colors, typography, và components

### 2. Code Organization

- **Single Responsibility**: Mỗi class chỉ có một trách nhiệm
- **Interface Segregation**: Sử dụng các interface nhỏ, cụ thể
- **Dependency Injection**: Inject dependencies thông qua constructor
- **Immutability**: Sử dụng immutable objects khi có thể

### 3. Testing

```dart
// Test theme creation
void main() {
  group('Theme Tests', () {
    test('should create valid light theme', () {
      final theme = MyCustomTheme();
      expect(theme.lightThemeData, isNotNull);
      expect(theme.supportsLightMode, isTrue);
    });
    
    test('should validate theme correctly', () {
      final theme = MyCustomTheme();
      final validator = ThemeValidator();
      final result = validator.validateTheme(theme);
      expect(result.isValid, isTrue);
    });
  });
}
```

## Troubleshooting

### Lỗi thường gặp

1. **Theme không load được**
   - Kiểm tra theme ID có đúng không
   - Đảm bảo theme đã được register trong ThemeProvider

2. **Performance issues**
   - Sử dụng ThemeValidator để kiểm tra performance
   - Kiểm tra cache statistics của typography

3. **Color contrast warnings**
   - Sử dụng ThemeValidator để kiểm tra accessibility
   - Điều chỉnh màu sắc để đạt contrast ratio tối thiểu

### Debug Tools

```dart
// Enable debug mode
ThemeProvider.debugMode = true;

// Check theme validation
final validator = ThemeValidator();
final result = validator.validateTheme(currentTheme);
print(result.debugInfo);

// Monitor performance
final typography = ThemeTypography();
print('Cache stats: ${typography.cacheStats}');
```

## Migration Guide

### Từ phiên bản cũ

1. **Update imports**:
   ```dart
   // Old
   import 'package:app/theme/app_theme.dart';
   
   // New
   import 'package:app/theme/base/app_theme.dart';
   import 'package:app/theme/providers/theme_provider.dart';
   ```

2. **Update theme creation**:
   ```dart
   // Old
   class MyTheme extends AppTheme {
     // Implementation
   }
   
   // New
   class MyTheme extends BaseTheme 
       with LightThemeProvider, DarkThemeProvider {
     // Implementation
   }
   ```

3. **Update theme usage**:
   ```dart
   // Old
   Theme.of(context)
   
   // New
   context.read<ThemeProvider>().currentTheme
   ```

## Đóng góp

Khi thêm theme mới hoặc cải thiện hệ thống:

1. Tuân thủ coding standards
2. Thêm tests cho code mới
3. Cập nhật documentation
4. Chạy `flutter analyze` và `flutter test`
5. Sử dụng ThemeValidator để validate themes

## Tài liệu tham khảo

- [Flutter Theme Documentation](https://docs.flutter.dev/cookbook/design/themes)
- [Material Design 3](https://m3.material.io/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)