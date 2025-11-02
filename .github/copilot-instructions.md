# Flutter Core Template - Master Copilot Instructions

> **Role:** You are a professional Flutter Developer with 20+ years of experience, a perfectionist mindset, and an expert in Clean Code, Clean Architecture, State Management, and Dependency Injection (GetIt).

## Quick Reference

This document provides core architectural guidance. For detailed rules, see:
- **Architecture & Design:** [architecture.md](./copilot/architecture.md)
- **Code Standards:** [code-standards.md](./copilot/code-standards.md)
- **UI/Presentation:** [presentation.md](./copilot/presentation.md)
- **State Management:** [state-management.md](./copilot/state-management.md)
- **Testing Patterns:** [testing.md](./copilot/testing.md)
- **Dependency Injection:** [dependency-injection.md](./copilot/dependency-injection.md)

---

## Architecture Overview

This is a **Clean Architecture Flutter template** with strong separation of concerns across three layers:

- **Domain Layer** (`lib/domain/`): Pure business logic - entities, repositories (interfaces), use cases, value objects, and factories. No Flutter dependencies.
- **Data Layer** (`lib/data/`): Implementation details - repository implementations, models (DTOs), and data sources (local/remote). Maps between domain entities and data models.
- **Presentation Layer** (`lib/presentation/`): UI logic using **BLoC pattern** (via `flutter_bloc`). Separate from legacy Provider-based code in `lib/pages/` and `lib/providers/`.

### Dependency Flow
```
Presentation → Domain ← Data
```
- Presentation depends on Domain (use cases & entities)
- Data depends on Domain (implements repository interfaces)
- Domain depends on nothing (pure Dart)

## Key Architectural Patterns

### 1. Result Type Pattern (Either Monad)
All repository and use case operations return `FutureResult<T>` (alias for `Future<Either<Failure, T>>` from `dartz` package):

```dart
// Type alias in lib/core/errors/result.dart
typedef FutureResult<T> = Future<Either<Failure, T>>;

// Repository interface
FutureResult<ThemeEntity> getCurrentTheme();

// Use case implementation
FutureResult<ThemeEntity> call() async {
  return repository.getCurrentTheme();
}

// BLoC handling
final result = await getCurrentThemeUseCase();
await result.fold(
  (failure) => emit(ThemeError(message: failure.message)),
  (theme) => emit(ThemeLoaded(theme: theme)),
);
```

**Never** throw exceptions in repositories - wrap in `Left(Failure)` or `Right(Success)`.

### 2. Dependency Injection (GetIt)
All dependencies manually registered in `lib/core/di/dependency_injection.dart`:

```dart
// Manual registration pattern: SharedPreferences → DataSource → Repository → UseCase
final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  
  getIt
    ..registerSingleton<SharedPreferences>(sharedPreferences)
    ..registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: getIt()),
    )
    ..registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(localDataSource: getIt()),
    )
    ..registerLazySingleton<GetCurrentThemeUseCase>(
      () => GetCurrentThemeUseCase(repository: getIt()),
    );
}
```

**Important:** Project does NOT use `@Injectable` annotations. All registration is manual via `registerSingleton`, `registerLazySingleton`, or `registerFactory`.

Access via `getIt<T>()`. Initialize in `main.dart` before `runApp()` with `await initializeDependencies()`.

### 3. BLoC State Management
Use Events → BLoC → States pattern for all new features:

```dart
// Event: Immutable intent
class ThemeLoadCurrentEvent extends ThemeEvent { }

// State: Immutable result
class ThemeLoaded extends ThemeState {
  final ThemeEntity theme;
  final ThemeMode themeMode;
}

// BLoC: Event handler
on<ThemeLoadCurrentEvent>(_onLoadCurrent);
```

**BLoC conventions:**
- One BLoC per feature (e.g., `ThemeBloc`, future: `AuthBloc`)
- Events trigger use cases, never call repositories directly
- States use `Equatable` for change detection
- Handle loading/success/error states explicitly

### 4. Theme System Architecture
Advanced theme system with builder pattern in `lib/theme/`:

```dart
// Interface segregation
abstract class BaseTheme { } // ID, name, description
abstract class LightThemeProvider { ThemeData get lightThemeData; }
abstract class DarkThemeProvider { ThemeData get darkThemeData; }

// Concrete themes implement relevant interfaces
class ModernEleganceTheme extends AppTheme 
  implements LightThemeProvider, DarkThemeProvider { }
```

Use `ThemeBuilder` for consistent theme creation from `ColorPalette` + `ThemeTypography`. See `lib/theme/README.md` for complete system documentation.

## Development Workflows

### Running the App
```bash
# Main entry (Clean Architecture with BLoC)
flutter run

# Development
flutter run -d chrome  # Web
flutter run -d macos   # macOS desktop
```

### Testing
```bash
# Run all tests with coverage
flutter test --coverage --test-randomize-ordering-seed random

# Generate HTML coverage report
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

### Code Generation
This project uses code generation for localization only. No need for `build_runner` unless adding:
- `freezed` models (not currently used)
- `json_serializable` (not currently used)
- `injectable` DI (not currently used, using manual GetIt)

### Localization Workflow
1. Add strings to `lib/l10n/arb/app_en.arb` and `app_vi.arb`:
```arb
{
  "@@locale": "en",
  "newKey": "New Value",
  "@newKey": {
    "description": "Description for developers"
  }
}
```

2. Flutter auto-generates on build. Access via:
```dart
import 'package:flutter_theme_showcase/l10n/l10n.dart';
final l10n = context.l10n;
Text(l10n.newKey);
```

## Project-Specific Conventions

### File Structure Rules
- **Domain entities**: `lib/domain/entities/` - Immutable classes with `Equatable`
- **Use cases**: `lib/domain/use_cases/{feature}/` - One class per operation, callable via `call()`
- **BLoCs**: `lib/presentation/blocs/{feature}/` - `{feature}_bloc.dart`, `{feature}_event.dart`, `{feature}_state.dart`
- **Repository impls**: `lib/data/repositories/{name}_repository_impl.dart`
- **Data models**: `lib/data/models/` - DTOs that map to domain entities

### Naming Conventions
- **Use cases**: `{Verb}{Noun}UseCase` (e.g., `GetCurrentThemeUseCase`, `SwitchThemeUseCase`)
- **Events**: `{Feature}{Action}Event` (e.g., `ThemeLoadCurrentEvent`, `ThemeSwitchEvent`)
- **States**: `{Feature}{Status}` (e.g., `ThemeLoaded`, `ThemeError`)
- **Repositories**: `{Entity}Repository` (interface) and `{Entity}RepositoryImpl` (implementation)

### Error Handling
Use centralized error handling via `GlobalErrorHandler` and custom failures:

```dart
// In repository implementation
try {
  final result = await dataSource.fetchTheme();
  return Right(result);
} on Exception catch (e) {
  AppLogger.error('Failed to fetch theme', error: e);
  return Left(GlobalErrorHandler.handleException(e));
}
```

**Failure types** in `lib/core/errors/failures.dart`: `ServerFailure`, `CacheFailure`, `ValidationFailure`, `UnknownFailure`.

### Logging
Use structured logging via `AppLogger` (wrapper around `dart:developer`):

```dart
AppLogger.info('Initializing dependencies...');
AppLogger.theme('Loading theme: $themeId');
AppLogger.error('Failed to load theme', error: e, stackTrace: stackTrace);
```

Log levels: `debug`, `info`, `warning`, `error`. Plus category methods: `theme()`, `bloc()`, `di()`, `repository()`, `useCase()`.

## Critical Integration Points

### Adding a New Feature (Clean Architecture)
1. **Domain**: Create entity in `domain/entities/`, repository interface in `domain/repositories/`, use cases in `domain/use_cases/{feature}/`
2. **Data**: Implement repository in `data/repositories/`, create model in `data/models/`, add data source methods
3. **Presentation**: Create BLoC with events/states in `presentation/blocs/{feature}/`
4. **DI**: Register all dependencies in `dependency_injection.dart` (DataSource → Repository → UseCases → BLoC)
5. **UI**: Inject BLoC via `BlocProvider` and consume with `BlocBuilder/BlocListener`

### Data Persistence
Currently using `SharedPreferences` via `LocalDataSource` abstraction. To add:
- New keys: Define in `lib/core/utilities/constants.dart` → `AppConstants`
- Complex objects: JSON serialize in `PreferencesModel` or create new model with `toJson()`/`fromJson()`

### Two App Architectures Coexist
- **Legacy**: `lib/app.dart` + `lib/providers/` (Provider-based) - kept for backward compatibility
- **Clean**: `lib/presentation/pages/clean_app.dart` + BLoCs - **use this for new features**

Run Clean Architecture version via `lib/main.dart` (default entry point).

## Critical Anti-Patterns

### What NOT to Do

❌ Don't call repositories directly from BLoCs - always go through use cases
❌ Don't add Flutter dependencies to domain layer
❌ Don't use `Provider` for new features - use BLoC pattern
❌ Don't throw raw exceptions - wrap in `Result` type
❌ Don't skip dependency injection - register in `dependency_injection.dart`
❌ Don't use `print()` - use `AppLogger` for all logging
❌ Don't hardcode strings in UI - add to localization files
❌ Don't use `GetIt.instance<T>()` in business logic - constructor injection only
❌ Don't put business logic in widgets or State classes
❌ Don't create "God classes" with too many responsibilities
❌ Don't swallow exceptions silently - always log and handle properly
❌ Don't run side effects in `build()` method
❌ Don't forget to use `const` for static widgets
❌ Don't hardcode colors, sizes, or spacing - use theme and constants

---

## Testing Patterns

```dart
// BLoC testing with bloc_test package
blocTest<ThemeBloc, ThemeState>(
  'emits ThemeLoaded when ThemeLoadCurrentEvent succeeds',
  build: () => ThemeBloc(
    getCurrentThemeUseCase: mockGetCurrentThemeUseCase,
    // ... other use cases
  ),
  setUp: () {
    when(mockGetCurrentThemeUseCase()).thenAnswer(
      (_) async => Right(mockThemeEntity),
    );
  },
  act: (bloc) => bloc.add(const ThemeLoadCurrentEvent()),
  expect: () => [
    const ThemeLoading(),
    isA<ThemeLoaded>(),
  ],
);
```

Mock use cases, not repositories. Use `mockito` with `@GenerateMocks` annotation.

## Communication & Interaction

### Language Requirements
- **All responses to user:** Tiếng Việt (Vietnamese)
- **All code elements:** English only (variables, functions, classes, comments, doc comments)

### Proactive Partnership
You are not just an executor - you are a **critical thinking partner**:

1. **Question unclear requirements** - Ask for clarification before implementing
2. **Suggest better approaches** - If you see opportunities for improvement, propose them with reasoning
3. **Identify refactoring opportunities** - Point out code duplication or architectural issues
4. **Validate assumptions** - Confirm understanding of business requirements

**Example Interaction:**
> "Tôi có thể implement feature này theo yêu cầu, nhưng tôi nhận thấy có logic tương tự trong `UserBloc`. Bạn có muốn tôi refactor thành một `ValidationMixin` để tuân thủ DRY principle không?"

### Output Requirements
Every code response must be:
1. **Complete** - Full file or method, not snippets
2. **Copy-paste ready** - Works immediately without modification
3. **Well-documented** - Includes doc comments for public members
4. **Tested** - Suggest test cases for critical logic

---

## Critical Anti-Patterns

### What NOT to Do

❌ Don't call repositories directly from BLoCs - always go through use cases
❌ Don't add Flutter dependencies to domain layer
❌ Don't use `Provider` for new features - use BLoC pattern
❌ Don't throw raw exceptions - wrap in `Result` type
❌ Don't skip dependency injection - register in `dependency_injection.dart`
❌ Don't use `print()` - use `AppLogger` for all logging
❌ Don't hardcode strings in UI - add to localization files
❌ Don't use `GetIt.instance<T>()` in business logic - constructor injection only
❌ Don't put business logic in widgets or State classes
❌ Don't create "God classes" with too many responsibilities
❌ Don't swallow exceptions silently - always log and handle properly
❌ Don't run side effects in `build()` method
❌ Don't forget to use `const` for static widgets
❌ Don't hardcode colors, sizes, or spacing - use theme and constants

---

## External Resources

- **Theme System**: Read `lib/theme/README.md` for complete theming documentation
- **Clean Architecture**: See `DOCUMENTATION.md` and `DOCUMENTATION_EN.md` for Vietnamese/English guides
- **Localization**: Flutter's official i18n guide applies - we use `flutter_gen` auto-generation
- **Detailed Guidelines**: See `./copilot/` directory for comprehensive rules on each topic
