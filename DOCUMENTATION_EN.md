# Flutter Core Template Project Documentation

This is a comprehensive documentation for the Flutter Core Template project, providing detailed guidance on how to set up, develop, and deploy the application.

## 1. Project Overview

-   **Purpose**: A foundational platform for Flutter applications, focusing on modular structure, scalability, and core features such as theme management and internationalization.
-   **Technologies Used**: Flutter, Dart.

## 2. Quick Start

### 2.1. System Requirements

-   Flutter SDK (recommended version: 3.x.x)
-   Dart SDK (included with Flutter SDK)
-   Code editor (VS Code, Android Studio)

### 2.2. Installation

1.  Clone the repository:

    ```bash
    git clone https://github.com/nmtuong97/flutter-core-template.git
    cd flutter-core-template
    ```

2.  Fetch dependencies:

    ```bash
    flutter pub get
    ```

### 2.3. Running the Application

To run the application on a device or emulator:

```bash
flutter run
```

## 3. Project Structure

The project is organized with a modular structure, facilitating easy management and scalability:

```
lib/
├── app/                  # Main application configuration
├── bootstrap.dart        # Application initialization
├── constants/            # Constants and fixed strings
├── l10n/                 # Localization
├── pages/                # Application pages (screens)
├── providers/            # State and data management
├── theme/                # Theming
└── widgets/              # Reusable widgets
```

## 4. Testing

To run all unit and widget tests:

```bash
flutter test --coverage --test-randomize-ordering-seed random
```

To view the code coverage report:

```bash
# Generate report
genhtml coverage/lcov.info -o coverage/

# Open report
open coverage/index.html
```

## 5. Internationalization (Localization)

The project uses `flutter_localizations` and follows the [official internationalization guide for Flutter](https://flutter.dev/docs/development/accessibility-and-localization/internationalization).

### 5.1. Adding Strings

1.  Open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.
2.  Add a new key/value pair and description:

    ```arb
    {
        "@@locale": "en",
        "helloWorld": "Hello World",
        "@helloWorld": {
            "description": "Hello World Text"
        }
    }
    ```

3.  Use the new string in code:

    ```dart
    import 'package:flutter_core_template/l10n/l10n.dart';

    @override
    Widget build(BuildContext context) {
      final l10n = context.l10n;
      return Text(l10n.helloWorld);
    }
    ```

### 5.2. Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale:

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### 5.3. Adding Translations

1.  For each supported locale, add a new ARB file in `lib/l10n/arb` (e.g., `app_es.arb`).
2.  Add the translated strings to each `.arb` file.

### 5.4. Generating Translations

To use the latest translation changes, you will need to generate them:

```bash
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run`, and code generation will take place automatically.

## 6. Theming

The project supports various themes. You can customize or add new themes in the `lib/theme/` directory.

### 6.1. Theme Structure

-   `app_themes.dart`: Defines available themes.
-   `theme_provider.dart`: Manages theme switching.
-   `themes/`: Contains specific theme definitions (e.g., `cyberpunk_theme.dart`).

### 6.2. Adding a New Theme

1.  Create a new Dart file in `lib/theme/themes/` (e.g., `my_custom_theme.dart`).
2.  Define `ThemeData` for your theme.
3.  Add the theme to the `AppTheme` enum in `app_themes.dart`.
4.  Update `ThemeProvider` to support the new theme.

## 7. UI Components

The project provides several reusable widgets in the `lib/widgets/` directory:

-   `language_selector.dart`: Language selection widget.
-   `theme_selector.dart`: Theme selection widget.
-   `theme_settings_bottom_sheet.dart`: Theme settings bottom sheet.

You can reuse or extend these components.

## 8. Deployment

To deploy your application to different platforms, refer to the official Flutter documentation:

-   [Deploying Android apps](https://docs.flutter.dev/deployment/android)
-   [Deploying iOS apps](https://docs.flutter.dev/deployment/ios)
-   [Deploying Web apps](https://docs.flutter.dev/deployment/web)
-   [Deploying Windows apps](https://docs.flutter.dev/deployment/windows)

---

**Note**: This documentation will be updated regularly. Please check for the latest versions.