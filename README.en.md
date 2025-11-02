# Flutter Theme Showcase

[![License: MIT][license_badge]][license_link]

A Flutter template with Clean Architecture and BLoC pattern for state management

---

## Project Documentation 📖

For more detailed information on how to set up, develop, and deploy the project, please refer to:

-   [English Documentation](DOCUMENTATION_EN.md)
-   [Vietnamese Documentation](DOCUMENTATION.md)

---

## Getting Started 🚀

This project now uses a single main entry point.

_*Flutter Theme Showcase works on iOS, Android, Web, and Windows._

---

## Architecture 🏗️

This project follows **Clean Architecture** with **BLoC Pattern** for state management:

- **Domain Layer**: Pure business logic (entities, use cases, repository interfaces)
- **Data Layer**: Implementation details (repository implementations, data sources)
- **Presentation Layer**: UI logic using BLoC pattern with `flutter_bloc`

### State Management

The app uses **BLoC (Business Logic Component)** pattern:
- `ThemeBloc`: Manages theme switching, mode changes, and font customization
- `LocalizationBloc`: Handles language switching and localization

### Dependency Injection

Manual dependency injection using **GetIt**:
- All dependencies registered in `lib/core/di/dependency_injection.dart`
- Singleton pattern for repositories and use cases
- Factory pattern for BLoCs

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

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
[internationalization_link]: https://github.com/nmtuong97/flutter-core-template.git
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT