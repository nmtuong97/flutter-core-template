# Phân Tích Chi Tiết Dự Án Flutter Core Template

## 📋 Mục Lục

1. [Tổng Quan Dự Án](#tổng-quan-dự-án)
2. [Kiến Trúc Dự Án](#kiến-trúc-dự-án)
3. [Cấu Trúc Thư Mục](#cấu-trúc-thư-mục)
4. [Tính Năng Chính](#tính-năng-chính)
5. [Công Nghệ Sử Dụng](#công-nghệ-sử-dụng)
6. [Hệ Thống Theme](#hệ-thống-theme)
7. [Hệ Thống Đa Ngôn Ngữ](#hệ-thống-đa-ngôn-ngữ)
8. [Quản Lý Trạng Thái](#quản-lý-trạng-thái)
9. [Testing](#testing)
10. [Hướng Dẫn Sử Dụng](#hướng-dẫn-sử-dụng)

---

## 🎯 Tổng Quan Dự Án

### Mục Đích
**Flutter Theme Showcase** là một dự án template Flutter được thiết kế để làm nền tảng cho các ứng dụng Flutter chuyên nghiệp. Dự án tập trung vào:

- **Kiến trúc sạch (Clean Architecture)**: Tách biệt rõ ràng giữa logic nghiệp vụ, dữ liệu và giao diện
- **Quản lý Theme linh hoạt**: Hệ thống theme đa dạng với 8 theme khác nhau
- **Đa ngôn ngữ**: Hỗ trợ đa ngôn ngữ (hiện tại: Tiếng Anh và Tiếng Việt)
- **Tính mở rộng**: Cấu trúc module giúp dễ dàng mở rộng và bảo trì
- **Best Practices**: Tuân thủ các nguyên tắc SOLID và Flutter best practices

### Thông Tin Cơ Bản

- **Tên dự án**: Flutter Theme Showcase
- **Phiên bản**: 1.0.0+1
- **Giấy phép**: MIT License
- **Tác giả**: Mạnh Tường (nmtuong97)
- **Repository**: https://github.com/nmtuong97/flutter-core-template
- **Nền tảng hỗ trợ**: iOS, Android, Web, Windows, MacOS
- **Flutter SDK**: ^3.5.0
- **Dart SDK**: ^3.5.0

### Quy Mô Dự Án

- **Tổng số dòng code**: ~20,487 dòng Dart
- **Số lượng file Dart**: 84+ files
- **Số lượng theme**: 8 themes
- **Số lượng ngôn ngữ**: 2 (English, Vietnamese)
- **Test coverage**: Có badge coverage

---

## 🏗️ Kiến Trúc Dự Án

### Clean Architecture

Dự án được xây dựng dựa trên **Clean Architecture** của Uncle Bob, với các layer rõ ràng:

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│   (UI, Widgets, Pages, BLoC)            │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│          Domain Layer                   │
│   (Entities, Use Cases, Repositories)   │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│           Data Layer                    │
│   (Models, Repository Impl, Sources)    │
└─────────────────────────────────────────┘
```

#### 1. **Presentation Layer** (lib/presentation, lib/pages, lib/widgets)
- **Chức năng**: Xử lý giao diện người dùng và tương tác
- **Thành phần**:
  - Pages: Các màn hình chính của ứng dụng
  - Widgets: Các component UI tái sử dụng
  - BLoC: Business Logic Components để quản lý state

#### 2. **Domain Layer** (lib/domain)
- **Chức năng**: Chứa logic nghiệp vụ thuần túy, độc lập với framework
- **Thành phần**:
  - **Entities**: Đối tượng nghiệp vụ cốt lõi (ThemeEntity, LocalizationEntity)
  - **Use Cases**: Các trường hợp sử dụng cụ thể (GetCurrentThemeUseCase, SwitchThemeUseCase)
  - **Repositories**: Interface định nghĩa cách truy xuất dữ liệu
  - **Factories**: Tạo đối tượng phức tạp (ThemeFactory)
  - **Value Objects**: Đối tượng giá trị (ThemeColors, ThemeTypography)

#### 3. **Data Layer** (lib/data)
- **Chức năng**: Implement việc truy xuất và lưu trữ dữ liệu
- **Thành phần**:
  - **Models**: Data models (ThemeModel, LocalizationModel, PreferencesModel)
  - **Repository Implementations**: Implement các repository interface
  - **Data Sources**: Local data source sử dụng SharedPreferences

#### 4. **Core Layer** (lib/core)
- **Chức năng**: Các utilities và services dùng chung
- **Thành phần**:
  - **Dependency Injection**: Sử dụng GetIt để quản lý dependencies
  - **Error Handling**: Xử lý lỗi toàn cục (Exceptions, Failures, Result)
  - **Utilities**: Logger, Constants, Extensions, Validators

### SOLID Principles

Dự án tuân thủ các nguyên tắc SOLID:

1. **Single Responsibility Principle (SRP)**
   - Mỗi class chỉ có một trách nhiệm duy nhất
   - Ví dụ: `GetCurrentThemeUseCase` chỉ lo việc lấy theme hiện tại

2. **Open/Closed Principle (OCP)**
   - Dễ dàng thêm theme mới mà không sửa code cũ
   - Sử dụng interface và abstract classes

3. **Liskov Substitution Principle (LSP)**
   - Các implementation có thể thay thế cho interface
   - Ví dụ: `ThemeRepositoryImpl` thay thế `ThemeRepository`

4. **Interface Segregation Principle (ISP)**
   - Interface nhỏ và tập trung
   - `LightThemeProvider` và `DarkThemeProvider` tách biệt

5. **Dependency Inversion Principle (DIP)**
   - Phụ thuộc vào abstraction, không phụ thuộc vào concrete implementation
   - Sử dụng dependency injection

---

## 📁 Cấu Trúc Thư Mục

```
flutter-core-template/
│
├── lib/                          # Source code chính
│   ├── app.dart                  # App widget (version cũ với Provider)
│   ├── main.dart                 # Entry point (Clean Architecture version)
│   ├── bootstrap.dart            # Bootstrap configuration
│   │
│   ├── core/                     # Core utilities
│   │   ├── di/                   # Dependency Injection
│   │   │   └── dependency_injection.dart
│   │   ├── errors/               # Error handling
│   │   │   ├── error_handler.dart
│   │   │   ├── exceptions.dart
│   │   │   ├── failures.dart
│   │   │   └── result.dart
│   │   └── utilities/            # Utilities
│   │       ├── constants.dart
│   │       ├── extensions/
│   │       ├── logger.dart
│   │       └── validators.dart
│   │
│   ├── data/                     # Data layer
│   │   ├── models/               # Data models
│   │   │   ├── localization_model.dart
│   │   │   ├── preferences_model.dart
│   │   │   └── theme_model.dart
│   │   ├── repositories/         # Repository implementations
│   │   │   ├── localization_repository_impl.dart
│   │   │   └── theme_repository_impl.dart
│   │   └── sources/              # Data sources
│   │       └── local/            # Local storage (SharedPreferences)
│   │
│   ├── domain/                   # Domain layer (Business logic)
│   │   ├── entities/             # Business entities
│   │   │   ├── localization_entity.dart
│   │   │   └── theme_entity.dart
│   │   ├── factories/            # Object factories
│   │   │   └── theme_factory.dart
│   │   ├── repositories/         # Repository interfaces
│   │   │   ├── localization_repository.dart
│   │   │   └── theme_repository.dart
│   │   ├── use_cases/            # Use cases (business logic)
│   │   │   ├── localization/     # Localization use cases
│   │   │   │   ├── get_current_localization_use_case.dart
│   │   │   │   ├── get_supported_localizations_use_case.dart
│   │   │   │   └── switch_localization_use_case.dart
│   │   │   └── theme/            # Theme use cases
│   │   │       ├── get_available_themes_use_case.dart
│   │   │       ├── get_current_theme_use_case.dart
│   │   │       ├── manage_theme_mode_use_case.dart
│   │   │       └── switch_theme_use_case.dart
│   │   └── value_objects/        # Value objects
│   │       ├── theme_colors.dart
│   │       └── theme_typography.dart
│   │
│   ├── presentation/             # Presentation layer (Clean Architecture)
│   │   ├── blocs/                # BLoC state management
│   │   │   └── theme/            # Theme BLoC
│   │   │       ├── theme_bloc.dart
│   │   │       ├── theme_event.dart
│   │   │       └── theme_state.dart
│   │   └── pages/                # Pages
│   │       └── clean_app.dart    # Clean Architecture app widget
│   │
│   ├── pages/                    # Application pages/screens
│   │   ├── component_showcase/   # Component showcase pages
│   │   │   ├── button_component_page.dart
│   │   │   ├── input_component_page.dart
│   │   │   ├── layout_component_page.dart
│   │   │   ├── list_component_page.dart
│   │   │   └── text_component_page.dart
│   │   └── theme_showcase_page.dart  # Main showcase page
│   │
│   ├── providers/                # Legacy providers (for backward compatibility)
│   │   └── language_provider.dart
│   │
│   ├── theme/                    # Theme system
│   │   ├── base/                 # Base theme classes
│   │   │   ├── app_theme.dart
│   │   │   ├── theme_factory.dart
│   │   │   └── theme_interfaces.dart
│   │   ├── builders/             # Theme builders
│   │   │   ├── base_theme_builder.dart
│   │   │   ├── fluent_theme_builder.dart
│   │   │   └── theme_builder.dart
│   │   ├── colors/               # Color management
│   │   │   └── color_palette.dart
│   │   ├── configurations/       # Theme configurations
│   │   │   ├── cyberpunk_theme_configuration.dart
│   │   │   ├── default_theme_configuration.dart
│   │   │   ├── glassmorphism_theme_configuration.dart
│   │   │   ├── neumorphism_theme_configuration.dart
│   │   │   └── theme_configuration.dart
│   │   ├── constants/            # Theme constants
│   │   │   └── theme_constants.dart
│   │   ├── extensions/           # Theme extensions
│   │   │   └── app_theme_extension.dart
│   │   ├── performance/          # Performance optimization
│   │   │   ├── lazy_theme_loader.dart
│   │   │   ├── theme_cache_manager.dart
│   │   │   ├── theme_performance_manager.dart
│   │   │   └── theme_preloader.dart
│   │   ├── themes/               # Concrete theme implementations
│   │   │   ├── cyberpunk_theme.dart
│   │   │   ├── default_theme.dart
│   │   │   ├── exaggerated_minimalism_theme.dart
│   │   │   ├── glassmorphism_theme.dart
│   │   │   ├── neumorphism_theme.dart
│   │   │   ├── night_sky_theme.dart
│   │   │   ├── organic_natural_theme.dart
│   │   │   └── retro_vintage_theme.dart
│   │   ├── typography/           # Typography system
│   │   │   ├── font_configuration.dart
│   │   │   ├── font_sizes.dart
│   │   │   └── theme_typography.dart
│   │   ├── utilities/            # Theme utilities
│   │   │   ├── consistency_validator.dart
│   │   │   ├── theme_consistency_report.dart
│   │   │   ├── theme_factory.dart
│   │   │   ├── theme_helper.dart
│   │   │   ├── theme_refactor_utility.dart
│   │   │   ├── theme_standardization.dart
│   │   │   └── theme_utilities.dart
│   │   ├── validators/           # Theme validators
│   │   │   └── theme_validator.dart
│   │   ├── theme_preferences.dart
│   │   └── theme_provider.dart
│   │
│   ├── widgets/                  # Reusable widgets
│   │   └── theme_settings_bottom_sheet.dart
│   │
│   └── l10n/                     # Localization
│       ├── arb/                  # ARB files
│       │   ├── app_en.arb        # English translations
│       │   └── app_vi.arb        # Vietnamese translations
│       ├── app_localizations.dart
│       ├── app_localizations_en.dart
│       ├── app_localizations_vi.dart
│       └── l10n.dart
│
├── test/                         # Test files
│   ├── domain/
│   │   ├── entities/
│   │   │   └── theme_entity_test.dart
│   │   └── use_cases/
│   │       ├── get_current_theme_use_case_test.dart
│   │       └── get_current_theme_use_case_test.mocks.dart
│   ├── presentation/
│   │   └── blocs/
│   │       ├── theme_bloc_test.dart
│   │       └── theme_bloc_test.mocks.dart
│   ├── language_provider_test.dart
│   └── theme_provider_test.dart
│
├── android/                      # Android platform code
├── ios/                          # iOS platform code
├── web/                          # Web platform code
├── windows/                      # Windows platform code
├── macos/                        # MacOS platform code
│
├── .qoder/                       # Qoder AI agent configuration
│   └── quests/                   # Quest templates
│
├── pubspec.yaml                  # Dependencies configuration
├── analysis_options.yaml         # Dart analyzer configuration
├── l10n.yaml                     # Localization configuration
├── coverage_badge.svg            # Coverage badge
├── README.md                     # Main README
├── README.en.md                  # English README
├── README.vi.md                  # Vietnamese README
├── DOCUMENTATION.md              # Vietnamese documentation
├── DOCUMENTATION_EN.md           # English documentation
└── LICENSE                       # MIT License
```

---

## ✨ Tính Năng Chính

### 1. **Hệ Thống Theme Đa Dạng**

Dự án cung cấp **8 theme độc đáo**, mỗi theme có phong cách riêng biệt:

1. **Default Theme** - Theme mặc định, cân bằng và thân thiện
2. **Cyberpunk Theme** - Phong cách tương lai, neon, công nghệ cao
3. **Glassmorphism Theme** - Hiệu ứng kính mờ, hiện đại
4. **Neumorphism Theme** - Soft UI, gần gũi và tinh tế
5. **Night Sky Theme** - Tối, dịu nhẹ, thích hợp ban đêm
6. **Organic Natural Theme** - Tự nhiên, màu sắc đất
7. **Retro Vintage Theme** - Hoài cổ, phong cách retro
8. **Exaggerated Minimalism Theme** - Tối giản nhưng táo bạo

Mỗi theme hỗ trợ cả **Light Mode** và **Dark Mode**.

### 2. **Đa Ngôn Ngữ (Internationalization)**

- Hỗ trợ đa ngôn ngữ sử dụng `flutter_localizations`
- Hiện tại: **Tiếng Anh** và **Tiếng Việt**
- Dễ dàng thêm ngôn ngữ mới thông qua file ARB
- Tự động tạo code localization

### 3. **Component Showcase**

Dự án showcase các component UI cơ bản của Flutter:

- **Text Components**: Hiển thị các style text khác nhau
- **Button Components**: Các loại button (Elevated, Outlined, Text, Icon)
- **Input Components**: TextField, Checkbox, Radio, Switch, Slider
- **Layout Components**: Card, Container, Divider, Spacer
- **List Components**: ListView, ListTile với các variants

### 4. **State Management với BLoC**

- Sử dụng **flutter_bloc** để quản lý state
- Pattern BLoC (Business Logic Component) rõ ràng
- Event-driven architecture
- Dễ dàng test và maintain

### 5. **Dependency Injection**

- Sử dụng **GetIt** cho dependency injection
- Tách biệt dependencies
- Dễ dàng mock trong testing
- Cấu trúc clean và maintainable

### 6. **Error Handling**

- Global error handler
- Custom exceptions và failures
- Result type để xử lý success/failure
- Logger cho debugging

### 7. **Performance Optimization**

- **Theme caching**: Cache theme data để tăng performance
- **Lazy loading**: Load theme khi cần thiết
- **Typography caching**: Cache text styles
- **Theme preloader**: Preload themes phổ biến

### 8. **Theme Validation**

- Validate theme consistency
- Check accessibility (contrast ratio)
- Performance validation
- Consistency reports

---

## 🔧 Công Nghệ Sử Dụng

### Core Dependencies

```yaml
dependencies:
  # Framework
  flutter: sdk: flutter
  flutter_localizations: sdk: flutter
  
  # Clean Architecture
  bloc: ^8.1.2              # BLoC pattern
  flutter_bloc: ^8.1.3      # Flutter BLoC
  dartz: ^0.10.1            # Functional programming (Either, Option)
  equatable: ^2.0.5         # Value equality
  
  # Dependency Injection
  get_it: ^7.6.7            # Service locator
  injectable: ^2.3.2        # Code generation for DI
  
  # Data & Storage
  shared_preferences: ^2.5.3 # Local storage
  json_annotation: ^4.8.1    # JSON serialization
  
  # UI
  flutter_screenutil: ^5.9.3 # Responsive UI
  google_fonts: ^6.3.0       # Google Fonts
  provider: ^6.1.5           # State management (backward compatibility)
  
  # Localization
  intl: ^0.20.2              # Internationalization
  
  # Code Generation
  freezed_annotation: ^2.4.1 # Immutable classes
```

### Dev Dependencies

```yaml
dev_dependencies:
  # Testing
  flutter_test: sdk: flutter
  bloc_test: ^9.1.5          # BLoC testing utilities
  mockito: ^5.4.4            # Mocking framework
  
  # Code Generation
  build_runner: ^2.4.7       # Code generation runner
  freezed: ^2.4.6            # Generate immutable classes
  json_serializable: ^6.7.1  # JSON serialization
  injectable_generator: ^2.4.1 # DI code generation
  
  # Linting
  flutter_lints: ^6.0.0      # Flutter linting rules
  very_good_analysis: ^9.0.0 # Strict analysis
```

### Tools & Utilities

- **Flutter ScreenUtil**: Responsive design
- **Google Fonts**: Custom fonts
- **Dartz**: Functional programming (Either for error handling)
- **Equatable**: Value equality for entities
- **Injectable**: Dependency injection code generation
- **Freezed**: Immutable data classes

---

## 🎨 Hệ Thống Theme

### Kiến Trúc Theme

Hệ thống theme được thiết kế theo các nguyên tắc:

1. **Interface Segregation**: Tách biệt Light và Dark theme providers
2. **Builder Pattern**: Sử dụng ThemeBuilder để tạo theme nhất quán
3. **Factory Pattern**: ThemeFactory để tạo và quản lý themes
4. **Type Safety**: ColorPalette type-safe cho màu sắc

### Theme Structure

```dart
// Base theme interface
abstract class BaseTheme {
  String get id;
  String get name;
  String get description;
  bool get isDefault;
}

// Light theme provider
abstract class LightThemeProvider {
  ThemeData get lightThemeData;
  bool get supportsLightMode;
}

// Dark theme provider
abstract class DarkThemeProvider {
  ThemeData get darkThemeData;
  bool get supportsDarkMode;
}

// Concrete theme implementation
class MyTheme extends BaseTheme 
    with LightThemeProvider, DarkThemeProvider {
  // Implementation
}
```

### Theme Components

1. **ColorPalette**: Quản lý màu sắc
   - Primary, secondary, surface, background colors
   - Validation methods
   - ColorScheme generation

2. **ThemeTypography**: Quản lý typography
   - Font families
   - Font sizes (với ScreenUtil)
   - Text styles caching
   - Performance optimization

3. **ThemeBuilder**: Build theme data
   - Consistent theme creation
   - Material 3 support
   - Component themes (AppBar, Button, Card, etc.)

4. **ThemeValidator**: Validate themes
   - Color consistency
   - Accessibility check
   - Performance validation

### Performance Features

- **Theme Caching**: Cache theme data để tránh rebuild
- **Lazy Loading**: Load theme khi cần
- **Typography Caching**: Cache text styles
- **Preloader**: Preload popular themes

### Available Themes

#### 1. Default Theme
- **Phong cách**: Cân bằng, professional
- **Màu chủ đạo**: Blue
- **Đặc điểm**: Thân thiện, dễ nhìn

#### 2. Cyberpunk Theme
- **Phong cách**: Tương lai, high-tech
- **Màu chủ đạo**: Neon pink, cyan
- **Đặc điểm**: Táo bạo, nổi bật

#### 3. Glassmorphism Theme
- **Phong cách**: Hiện đại, trong suốt
- **Màu chủ đạo**: Semi-transparent
- **Đặc điểm**: Tinh tế, sang trọng

#### 4. Neumorphism Theme
- **Phong cách**: Soft UI
- **Màu chủ đạo**: Neutral tones
- **Đặc điểm**: Mềm mại, gần gũi

#### 5. Night Sky Theme
- **Phong cách**: Dark, peaceful
- **Màu chủ đạo**: Deep blue, purple
- **Đặc điểm**: Thích hợp ban đêm

#### 6. Organic Natural Theme
- **Phong cách**: Natural, earthy
- **Màu chủ đạo**: Green, brown
- **Đặc điểm**: Thân thiện với thiên nhiên

#### 7. Retro Vintage Theme
- **Phong cách**: Nostalgic, retro
- **Màu chủ đạo**: Warm tones
- **Đặc điểm**: Hoài cổ, ấm áp

#### 8. Exaggerated Minimalism Theme
- **Phong cách**: Bold minimalism
- **Màu chủ đạo**: Black & white với accent
- **Đặc điểm**: Tối giản nhưng táo bạo

---

## 🌍 Hệ Thống Đa Ngôn Ngữ

### Localization Architecture

Dự án sử dụng Flutter's official localization system:

```
lib/l10n/
├── arb/                    # ARB translation files
│   ├── app_en.arb         # English translations
│   └── app_vi.arb         # Vietnamese translations
├── app_localizations.dart  # Generated base class
├── app_localizations_en.dart # Generated English class
├── app_localizations_vi.dart # Generated Vietnamese class
└── l10n.dart              # Extensions
```

### Supported Languages

Hiện tại hỗ trợ 2 ngôn ngữ:
- **English (en)** - Default
- **Vietnamese (vi)**

### Usage

```dart
// Get localization
final l10n = AppLocalizations.of(context);

// Use translation
Text(l10n.appTitle)
Text(l10n.textComponents)
Text(l10n.buttonComponents)
```

### Adding New Language

1. Tạo file ARB mới: `lib/l10n/arb/app_xx.arb`
2. Thêm translations
3. Chạy code generation: `flutter gen-l10n --arb-dir="lib/l10n/arb"`
4. Update `Info.plist` cho iOS

### Key Features

- Auto-generated type-safe code
- Hot reload support
- Easy to maintain
- Pluralization support
- Date/number formatting

---

## 🔄 Quản Lý Trạng Thái

### BLoC Pattern

Dự án sử dụng **BLoC (Business Logic Component)** pattern:

```
User Action → Event → BLoC → State → UI Update
```

### Theme BLoC

#### Events
```dart
// Load current theme
ThemeLoadCurrentEvent()

// Switch theme
ThemeSwitchEvent(themeId: 'cyberpunk')

// Change theme mode
ThemeChangeModeEvent(themeMode: ThemeMode.dark)

// Get available themes
ThemeLoadAvailableEvent()
```

#### States
```dart
// Initial state
ThemeInitial()

// Loading state
ThemeLoading()

// Loaded state
ThemeLoaded(
  lightTheme: ThemeData,
  darkTheme: ThemeData,
  themeMode: ThemeMode,
  currentThemeId: String,
)

// Operation in progress
ThemeOperationInProgress(previousState: ThemeLoaded)

// Operation success
ThemeOperationSuccess(updatedState: ThemeLoaded)

// Error state
ThemeError(message: String)
```

### Use Cases

Mỗi business logic được đóng gói trong Use Case:

```dart
// Get current theme
class GetCurrentThemeUseCase {
  Future<Result<ThemeEntity>> call();
}

// Switch theme
class SwitchThemeUseCase {
  Future<Result<ThemeEntity>> call(String themeId);
}

// Manage theme mode
class ManageThemeModeUseCase {
  Future<Result<void>> call(ThemeMode mode);
}

// Get available themes
class GetAvailableThemesUseCase {
  Future<Result<List<ThemeEntity>>> call();
}
```

### Benefits

- **Separation of concerns**: UI và logic tách biệt
- **Testability**: Dễ dàng test từng phần
- **Reusability**: Use cases có thể tái sử dụng
- **Maintainability**: Code clean và dễ maintain

---

## 🧪 Testing

### Test Structure

```
test/
├── domain/
│   ├── entities/
│   │   └── theme_entity_test.dart
│   └── use_cases/
│       └── get_current_theme_use_case_test.dart
├── presentation/
│   └── blocs/
│       └── theme_bloc_test.dart
├── language_provider_test.dart
└── theme_provider_test.dart
```

### Testing Tools

- **flutter_test**: Framework testing cơ bản
- **bloc_test**: Testing BLoC
- **mockito**: Mocking dependencies

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage --test-randomize-ordering-seed random

# Generate coverage report
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

### Test Types

1. **Unit Tests**: Test logic nghiệp vụ, use cases
2. **Widget Tests**: Test UI components
3. **BLoC Tests**: Test BLoC events và states
4. **Integration Tests**: Test flows hoàn chỉnh (nếu có)

### Coverage

Dự án có coverage badge để theo dõi test coverage:
![coverage][coverage_badge]

---

## 📖 Hướng Dẫn Sử Dụng

### Prerequisites

- Flutter SDK (3.5.0 trở lên)
- Dart SDK (included with Flutter)
- IDE: VS Code hoặc Android Studio
- Git

### Installation

1. **Clone repository**:
```bash
git clone https://github.com/nmtuong97/flutter-core-template.git
cd flutter-core-template
```

2. **Install dependencies**:
```bash
flutter pub get
```

3. **Generate code** (nếu cần):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Generate localizations**:
```bash
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

### Running the App

```bash
# Run on default device
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Run in release mode
flutter run --release
```

### Development

#### 1. Adding a New Theme

```dart
// 1. Create theme file: lib/theme/themes/my_theme.dart
class MyCustomTheme extends BaseTheme 
    with LightThemeProvider, DarkThemeProvider {
  
  @override
  String get id => 'my_custom';
  
  @override
  String get name => 'My Custom Theme';
  
  @override
  String get description => 'A beautiful custom theme';
  
  @override
  ThemeData get lightThemeData => ThemeBuilder.buildLightTheme(
    colorPalette: _lightPalette,
    typography: _typography,
  );
  
  @override
  ThemeData get darkThemeData => ThemeBuilder.buildDarkTheme(
    colorPalette: _darkPalette,
    typography: _typography,
  );
  
  final ColorPalette _lightPalette = ColorPalette(
    primary: Colors.purple,
    secondary: Colors.amber,
    // ... other colors
  );
  
  final ColorPalette _darkPalette = ColorPalette(
    primary: Colors.deepPurple,
    secondary: Colors.orangeAccent,
    // ... other colors
  );
  
  final ThemeTypography _typography = ThemeTypography();
}

// 2. Register in ThemeFactory
```

#### 2. Adding a New Language

```bash
# 1. Create ARB file
touch lib/l10n/arb/app_fr.arb

# 2. Add translations to app_fr.arb
{
    "@@locale": "fr",
    "appTitle": "Vitrine de Thème Flutter",
    "@appTitle": {
        "description": "Titre de l'application"
    }
    // ... more translations
}

# 3. Generate code
flutter gen-l10n --arb-dir="lib/l10n/arb"

# 4. Update iOS Info.plist
# Add 'fr' to CFBundleLocalizations array
```

#### 3. Adding a New Use Case

```dart
// 1. Create use case file
class MyNewUseCase {
  final MyRepository _repository;
  
  MyNewUseCase({required MyRepository repository})
      : _repository = repository;
  
  Future<Result<MyData>> call(MyParams params) async {
    try {
      final result = await _repository.getData(params);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(Failure.fromException(e));
    }
  }
}

// 2. Register in DI
getIt.registerLazySingleton<MyNewUseCase>(
  () => MyNewUseCase(repository: getIt()),
);

// 3. Use in BLoC
```

### Building for Production

#### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

#### Windows
```bash
flutter build windows --release
```

#### MacOS
```bash
flutter build macos --release
```

### Code Quality

#### Linting
```bash
# Run analyzer
flutter analyze

# Fix lint issues
dart fix --apply
```

#### Formatting
```bash
# Format code
dart format .
```

#### Testing
```bash
# Run all tests
flutter test

# Run specific test
flutter test test/path/to/test.dart

# Run with coverage
flutter test --coverage
```

---

## 🎯 Best Practices

### 1. Code Organization
- Tuân thủ Clean Architecture layers
- Single Responsibility Principle
- Dependency Inversion
- Small, focused functions

### 2. Naming Conventions
- Classes: PascalCase
- Files: snake_case
- Variables/Functions: camelCase
- Constants: UPPER_SNAKE_CASE

### 3. State Management
- Use BLoC for business logic
- Keep UI dumb (presentation only)
- Events for user actions
- States for UI representation

### 4. Error Handling
- Use Result type for operations
- Custom exceptions for specific errors
- Global error handler for uncaught errors
- User-friendly error messages

### 5. Performance
- Use const constructors
- Cache expensive computations
- Lazy load resources
- Profile regularly

### 6. Testing
- Write tests for business logic
- Test BLoC events and states
- Widget tests for UI
- Mock external dependencies

### 7. Documentation
- Comment complex logic
- Update README when adding features
- Document public APIs
- Use meaningful variable names

---

## 🚀 Tính Năng Nổi Bật

### 1. **Clean Architecture Implementation**
- Tách biệt rõ ràng presentation, domain, và data layers
- Dependency injection với GetIt
- SOLID principles
- Dễ dàng test và maintain

### 2. **Rich Theme System**
- 8 themes độc đáo
- Light/Dark mode support
- Theme validation
- Performance optimization
- Easy to extend

### 3. **Type-Safe Localization**
- Generated type-safe code
- No string keys
- Compile-time safety
- Easy to add languages

### 4. **BLoC State Management**
- Predictable state changes
- Event-driven
- Easy to test
- Separation of concerns

### 5. **Developer-Friendly**
- Well-documented code
- Clear structure
- Multiple README files (EN, VI)
- Example implementations

### 6. **Production-Ready**
- Error handling
- Logging
- Testing infrastructure
- Performance optimizations

---

## 📚 Tài Nguyên Học Tập

### Documentation Files
- `README.md` - Overview chung
- `README.en.md` - English documentation
- `README.vi.md` - Vietnamese documentation
- `DOCUMENTATION.md` - Chi tiết tiếng Việt
- `DOCUMENTATION_EN.md` - Chi tiết tiếng Anh
- `lib/theme/README.md` - Theme system docs
- `lib/theme/README_fluent_builder.md` - Fluent builder docs
- `lib/theme/performance/README_performance.md` - Performance docs
- `lib/theme/utilities/migration_guide.md` - Migration guide

### Learning Path

#### Beginner
1. Đọc README files
2. Explore project structure
3. Run the app
4. Try switching themes
5. Change language

#### Intermediate
1. Understand Clean Architecture
2. Study BLoC pattern
3. Explore theme system
4. Add a simple theme
5. Write unit tests

#### Advanced
1. Implement new use cases
2. Add complex themes
3. Optimize performance
4. Contribute to codebase
5. Refactor and improve

### External Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Material Design 3](https://m3.material.io/)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)

---

## 🤝 Contributing

### How to Contribute

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write/update tests
5. Update documentation
6. Submit a pull request

### Guidelines

- Follow existing code style
- Write meaningful commit messages
- Add tests for new features
- Update documentation
- Run `flutter analyze` and `flutter test` before submitting

### Code Review

All contributions will be reviewed for:
- Code quality
- Test coverage
- Documentation
- Performance impact
- Consistency with project structure

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 Mạnh Tường

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files...
```

---

## 👨‍💻 Author

**Mạnh Tường (nmtuong97)**
- GitHub: [@nmtuong97](https://github.com/nmtuong97)
- Repository: [flutter-core-template](https://github.com/nmtuong97/flutter-core-template)

---

## 🔮 Future Plans

### Planned Features
- [ ] More themes (10+ themes)
- [ ] Theme marketplace
- [ ] Animation showcase
- [ ] More component examples
- [ ] Advanced state management examples
- [ ] GraphQL integration example
- [ ] Firebase integration example
- [ ] CI/CD setup
- [ ] More language support

### Improvements
- [ ] Better documentation
- [ ] Video tutorials
- [ ] Interactive documentation
- [ ] Performance benchmarks
- [ ] Accessibility improvements

---

## 📞 Support

### Getting Help
- Read the documentation files
- Check existing issues on GitHub
- Create a new issue with detailed description
- Join discussions

### Bug Reports
When reporting bugs, please include:
- Flutter version
- Device/Platform
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable

### Feature Requests
When requesting features:
- Describe the use case
- Explain why it's needed
- Provide examples if possible
- Consider implementation complexity

---

## 🎓 Kết Luận

**Flutter Theme Showcase** là một dự án template xuất sắc cho việc khởi đầu ứng dụng Flutter professional. Với:

✅ **Clean Architecture** - Cấu trúc rõ ràng, dễ maintain
✅ **Rich Theme System** - 8 themes đa dạng, dễ extend
✅ **BLoC Pattern** - State management mạnh mẽ
✅ **Type-Safe** - Compile-time safety
✅ **Well-Tested** - Test infrastructure sẵn sàng
✅ **Well-Documented** - Tài liệu đầy đủ
✅ **Production-Ready** - Sẵn sàng cho production

Dự án này là điểm khởi đầu tuyệt vời cho:
- Developers muốn học Clean Architecture
- Teams cần một template mạnh mẽ
- Projects cần hệ thống theme linh hoạt
- Anyone muốn best practices trong Flutter

**Chúc bạn code vui vẻ! 🚀**

---

*Tài liệu này được tạo ngày 2025-11-02*
