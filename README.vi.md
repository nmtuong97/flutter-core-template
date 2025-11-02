# Flutter Theme Showcase

[![License: MIT][license_badge]][license_link]

Template Flutter với Clean Architecture và BLoC pattern cho quản lý state

---

## Tài liệu dự án 📖

Để biết thêm thông tin chi tiết về cách thiết lập, phát triển và triển khai dự án, vui lòng tham khảo:

-   [English Documentation](DOCUMENTATION_EN.md)
-   [Tài liệu tiếng Việt](DOCUMENTATION.md)

---

## Getting Started 🚀

This project now uses a single main entry point.

_\*Flutter Theme Showcase works on iOS, Android, Web, and Windows._

---

## Kiến trúc 🏗️

Dự án tuân theo **Clean Architecture** với **BLoC Pattern** cho quản lý state:

- **Domain Layer**: Logic nghiệp vụ thuần túy (entities, use cases, repository interfaces)
- **Data Layer**: Chi tiết triển khai (repository implementations, data sources)
- **Presentation Layer**: Logic UI sử dụng BLoC pattern với `flutter_bloc`

### Quản lý State

Ứng dụng sử dụng **BLoC (Business Logic Component)** pattern:
- `ThemeBloc`: Quản lý chuyển theme, thay đổi mode, và tùy chỉnh font
- `LocalizationBloc`: Xử lý chuyển đổi ngôn ngữ và localization

### Dependency Injection

Dependency injection thủ công sử dụng **GetIt**:
- Tất cả dependencies đăng ký trong `lib/core/di/dependency_injection.dart`
- Singleton pattern cho repositories và use cases
- Factory pattern cho BLoCs

---

## Làm việc với Đa ngôn ngữ 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

[internationalization_link]: https://github.com/nmtuong97/flutter-core-template.git

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:flutter_theme_showcase/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
