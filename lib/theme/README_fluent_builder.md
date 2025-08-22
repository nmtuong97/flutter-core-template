# FluentThemeBuilder Pattern

## Tổng quan

FluentThemeBuilder là một pattern thiết kế cho phép tạo themes một cách linh hoạt và trực quan thông qua method chaining. Pattern này cải thiện đáng kể trải nghiệm developer khi tạo và tùy chỉnh themes.

## Tính năng chính

### 🔗 Method Chaining
- Tạo themes thông qua chuỗi method calls liên tiếp
- Code dễ đọc và maintain hơn
- IntelliSense support tốt

### 🎨 Predefined Palettes
- Material Design palettes
- Cupertino style palettes  
- Dark mode palettes
- Monochrome palettes

### 📝 Typography Styles
- Modern (Roboto-based)
- Classic (Times New Roman-based)
- Minimal (Helvetica-based)
- Playful (Comic Sans-based)

### 🧩 Component Styling
- Configurable border radius
- Adjustable elevation
- Custom button padding
- Flexible spacing

## Cách sử dụng cơ bản

### 1. Tạo theme đơn giản

```dart
final simpleTheme = FluentThemeBuilder.create('my_theme', 'My Theme')
    .withDescription('A simple custom theme')
    .withMaterial3Defaults()
    .buildCustomTheme();
```

### 2. Tùy chỉnh màu sắc

```dart
final colorfulTheme = FluentThemeBuilder.create('colorful_theme', 'Colorful Theme')
    .withPrimaryColors(
      primary: Colors.deepPurple,
      secondary: Colors.deepPurpleAccent,
      background: Colors.white,
      surface: Colors.grey[50]!,
    )
    .buildCustomTheme();
```

### 3. Cấu hình typography

```dart
final typographyTheme = FluentThemeBuilder.create('typography_theme', 'Typography Theme')
    .withTypography(
      fontFamily: 'Roboto',
      baseFontSize: 16.0,
      primaryTextColor: Colors.black87,
      secondaryTextColor: Colors.grey[600]!,
    )
    .buildCustomTheme();
```

### 4. Sử dụng predefined styles

```dart
final modernTheme = FluentThemeBuilder.create('modern_theme', 'Modern Theme')
    .withColorPalette(ThemeColorPalette.material)
    .withTypographyStyle(TypographyStyle.modern)
    .withMaterial3Defaults()
    .buildCustomTheme();
```

## Ví dụ nâng cao

### Theme cho Dark Mode

```dart
final darkTheme = FluentThemeBuilder.create('dark_theme', 'Dark Theme')
    .withColorPalette(ThemeColorPalette.dark)
    .withTypography(
      baseFontSize: 14.0,
      primaryTextColor: Colors.white,
      secondaryTextColor: Colors.grey[300]!,
    )
    .withComponentStyling(
      borderRadius: 12.0,
      elevation: 8.0,
    )
    .asDarkTheme()
    .buildCustomTheme();
```

### Theme với text styling nâng cao

```dart
final styledTheme = FluentThemeBuilder.create('styled_theme', 'Styled Theme')
    .withPrimaryColors(primary: Colors.blue)
    .withTextStyling(
      hasShadow: true,
      shadowColor: Colors.blue.withOpacity(0.3),
      letterSpacing: 0.5,
    )
    .buildCustomTheme();
```

### Theme responsive cho tablet

```dart
final tabletTheme = FluentThemeBuilder.create('tablet_theme', 'Tablet Theme')
    .withMaterial3Defaults()
    .withTypography(baseFontSize: 16.0) // Larger font for tablets
    .withComponentStyling(
      borderRadius: 12.0,
      buttonPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    )
    .buildCustomTheme();
```

## Extension Methods

### Quick Theme Variants

```dart
// Light-only theme
final lightTheme = FluentThemeBuilder.create('light_theme', 'Light Theme')
    .withMaterial3Defaults()
    .asLightTheme()
    .buildCustomTheme();

// Dark-only theme  
final darkTheme = FluentThemeBuilder.create('dark_theme', 'Dark Theme')
    .withColorPalette(ThemeColorPalette.dark)
    .asDarkTheme()
    .buildCustomTheme();
```

### Design System Presets

```dart
// Material Design 3
final md3Theme = FluentThemeBuilder.create('md3_theme', 'Material 3 Theme')
    .withMaterial3Defaults()
    .buildCustomTheme();

// Minimalist design
final minimalTheme = FluentThemeBuilder.create('minimal_theme', 'Minimal Theme')
    .withMinimalistDesign()
    .buildCustomTheme();
```

## Tích hợp với App

### 1. Sử dụng trong MaterialApp

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customTheme = FluentThemeBuilder.create('app_theme', 'App Theme')
        .withMaterial3Defaults()
        .withPrimaryColors(primary: Colors.deepPurple)
        .buildCustomTheme();
    
    return MaterialApp(
      title: 'My App',
      theme: customTheme.lightThemeData,
      darkTheme: customTheme.darkThemeData,
      home: MyHomePage(),
    );
  }
}
```

### 2. Theme switching

```dart
class ThemeManager {
  static final List<CustomFluentTheme> availableThemes = [
    FluentThemeBuilder.create('light_theme', 'Light')
        .withMaterial3Defaults()
        .buildCustomTheme(),
    
    FluentThemeBuilder.create('dark_theme', 'Dark')
        .withColorPalette(ThemeColorPalette.dark)
        .buildCustomTheme(),
    
    FluentThemeBuilder.create('nature_theme', 'Nature')
        .withPrimaryColors(primary: Colors.green)
        .buildCustomTheme(),
  ];
  
  static CustomFluentTheme getThemeById(String id) {
    return availableThemes.firstWhere((theme) => theme.id == id);
  }
}
```

## Best Practices

### 1. Naming Convention
- Sử dụng descriptive names cho theme IDs
- Prefix theo feature hoặc module nếu cần
- Avoid special characters trong IDs

```dart
// Good
FluentThemeBuilder.create('user_profile_theme', 'User Profile Theme')
FluentThemeBuilder.create('dashboard_dark_theme', 'Dashboard Dark Theme')

// Avoid
FluentThemeBuilder.create('theme1', 'Theme')
FluentThemeBuilder.create('my-theme!', 'My Theme!')
```

### 2. Color Consistency
- Sử dụng predefined palettes khi có thể
- Maintain contrast ratios cho accessibility
- Test themes với different screen sizes

```dart
// Consistent color usage
final theme = FluentThemeBuilder.create('consistent_theme', 'Consistent Theme')
    .withColorPalette(ThemeColorPalette.material) // Use predefined palette
    .withPrimaryColors(
      primary: Colors.blue[700]!, // Ensure good contrast
      secondary: Colors.blue[300]!,
    )
    .buildCustomTheme();
```

### 3. Typography Hierarchy
- Maintain clear font size hierarchy
- Use appropriate font weights
- Consider reading accessibility

```dart
final readableTheme = FluentThemeBuilder.create('readable_theme', 'Readable Theme')
    .withTypography(
      baseFontSize: 16.0, // Good base size for readability
      fontFamily: 'Roboto', // Web-safe font
    )
    .withTextStyling(
      letterSpacing: 0.25, // Improve readability
    )
    .buildCustomTheme();
```

### 4. Performance Considerations
- Cache themes khi có thể
- Avoid tạo themes trong build methods
- Use const values cho static properties

```dart
class ThemeCache {
  static final Map<String, CustomFluentTheme> _cache = {};
  
  static CustomFluentTheme getOrCreate(String id, CustomFluentTheme Function() factory) {
    return _cache.putIfAbsent(id, factory);
  }
}
```

## Troubleshooting

### Common Issues

1. **Theme không apply đúng cách**
   - Kiểm tra theme có được set trong MaterialApp
   - Verify theme ID uniqueness
   - Check theme mode support (light/dark)

2. **Colors không hiển thị như mong đợi**
   - Verify color contrast ratios
   - Check Material 3 color system compatibility
   - Test với different brightness settings

3. **Typography issues**
   - Ensure font family availability
   - Check font size calculations
   - Verify text color contrast

### Debug Tips

```dart
// Enable theme debugging
final debugTheme = FluentThemeBuilder.create('debug_theme', 'Debug Theme')
    .withMaterial3Defaults()
    .buildCustomTheme();

// Print theme information
print('Theme ID: ${debugTheme.id}');
print('Supports Light: ${debugTheme.supportsLightMode}');
print('Supports Dark: ${debugTheme.supportsDarkMode}');
```

## Migration từ Legacy Themes

Nếu bạn có existing themes, có thể migrate sang FluentThemeBuilder:

```dart
// Legacy theme
class OldTheme extends AppTheme {
  // ... existing implementation
}

// Migrated theme
final migratedTheme = FluentThemeBuilder.create('migrated_theme', 'Migrated Theme')
    .withPrimaryColors(
      primary: oldTheme.primaryColor,
      secondary: oldTheme.secondaryColor,
    )
    .withTypography(
      fontFamily: oldTheme.fontFamily,
      baseFontSize: oldTheme.fontSize,
    )
    .buildCustomTheme();
```

## Kết luận

FluentThemeBuilder pattern cung cấp một cách tiếp cận hiện đại và linh hoạt để tạo themes trong Flutter. Với method chaining và predefined presets, việc tạo và maintain themes trở nên đơn giản và trực quan hơn nhiều.

Pattern này đặc biệt hữu ích cho:
- Apps với multiple themes
- Dynamic theme switching
- Brand-specific theming
- Accessibility-focused applications
- Responsive design requirements