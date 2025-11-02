# Dependency Injection Best Practices

## Overview

This project uses **GetIt** for dependency injection with **MANUAL registration**. 

**Critical:** This project does NOT use `@Injectable` annotations, despite having the `injectable` package in dependencies. All DI registration is done manually in `lib/core/di/dependency_injection.dart`.

---

## DI Golden Rules

### Rule #1: Constructor Injection Only
**ALWAYS prefer constructor injection for business logic classes.**

```dart
// ✅ GOOD - Constructor injection (testable, explicit)
class GetCurrentThemeUseCase {
  const GetCurrentThemeUseCase({
    required this.repository,
  });
  
  final ThemeRepository repository;
  
  FutureResult<ThemeEntity> call() async {
    return repository.getCurrentTheme();
  }
}
```

### Rule #2: NEVER Use Service Locator in Business Logic
**GetIt.instance<T>() is FORBIDDEN in:**
- Use Cases
- Repositories
- BLoCs
- Any business logic class

```dart
// ❌ FORBIDDEN - Service Locator pattern
class BadUseCase {
  Future<void> execute() async {
    // ❌ BAD: Hidden dependency, hard to test
    final repository = GetIt.instance<UserRepository>();
  }
}

// ✅ GOOD - Constructor injection
class GoodUseCase {
  const GoodUseCase({required this.repository});
  
  final UserRepository repository;
  
  Future<void> execute() async {
    // Use repository
  }
}
```

### Rule #3: Register in Order
**Dependencies must be registered BEFORE their dependents.**

Order: **External Services → DataSources → Repositories → Use Cases → BLoCs**

```dart
Future<void> initializeDependencies() async {
  // 1. External services first
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  // 2. Data sources
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: getIt()),
  );
  
  // 3. Repositories
  getIt.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: getIt()),
  );
  
  // 4. Use cases
  getIt.registerLazySingleton<GetCurrentThemeUseCase>(
    () => GetCurrentThemeUseCase(repository: getIt()),
  );
}
```

---

## Manual Registration Pattern

### Registration Types

#### 1. Singleton (Eager)
**Created immediately when registered. Use for:**
- External services (SharedPreferences, Database)
- Services that must be initialized at startup

```dart
// ✅ Singleton - created immediately
final sharedPreferences = await SharedPreferences.getInstance();
getIt.registerSingleton<SharedPreferences>(sharedPreferences);
```

#### 2. LazySingleton (Lazy)
**Created on first access. Use for:**
- Data sources
- Repositories
- Use cases
- Most services

```dart
// ✅ LazySingleton - created when first requested
getIt.registerLazySingleton<LocalDataSource>(
  () => LocalDataSourceImpl(sharedPreferences: getIt()),
);

getIt.registerLazySingleton<ThemeRepository>(
  () => ThemeRepositoryImpl(localDataSource: getIt()),
);

getIt.registerLazySingleton<GetCurrentThemeUseCase>(
  () => GetCurrentThemeUseCase(repository: getIt()),
);
```

#### 3. Factory
**New instance created every time. Use for:**
- BLoCs (each screen needs separate instance)
- Stateful services
- Objects with lifecycle

```dart
// ✅ Factory - new instance each time
getIt.registerFactory<UserBloc>(
  () => UserBloc(
    getUserUseCase: getIt(),
    updateUserUseCase: getIt(),
  ),
);

// Usage in widget
BlocProvider(
  create: (_) => getIt<UserBloc>()..add(UserLoadEvent('123')),
  child: UserScreen(),
)
```

---

## Complete Example from Actual Codebase

### Actual Implementation (lib/core/di/dependency_injection.dart)

```dart
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // 1. External Services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // 2. Data Sources
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: getIt()),
  );

  // 3. Repositories
  getIt.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: getIt()),
  );
  
  getIt.registerLazySingleton<LocalizationRepository>(
    () => LocalizationRepositoryImpl(localDataSource: getIt()),
  );

  // 4. Use Cases - Theme
  getIt.registerLazySingleton<GetCurrentThemeUseCase>(
    () => GetCurrentThemeUseCase(repository: getIt()),
  );
  
  getIt.registerLazySingleton<SwitchThemeUseCase>(
    () => SwitchThemeUseCase(repository: getIt()),
  );

  // 5. Use Cases - Localization
  getIt.registerLazySingleton<GetCurrentLocalizationUseCase>(
    () => GetCurrentLocalizationUseCase(repository: getIt()),
  );
  
  getIt.registerLazySingleton<SwitchLocalizationUseCase>(
    () => SwitchLocalizationUseCase(repository: getIt()),
  );
}
```

---

## Common Patterns

### Pattern 1: Multiple Dependencies

```dart
class ComplexUseCase {
  const ComplexUseCase({
    required this.userRepository,
    required this.themeRepository,
  });
  
  final UserRepository userRepository;
  final ThemeRepository themeRepository;
}

// Registration
getIt.registerLazySingleton<ComplexUseCase>(
  () => ComplexUseCase(
    userRepository: getIt(),
    themeRepository: getIt(),
  ),
);
```

### Pattern 2: Optional Dependencies

```dart
class UserService {
  const UserService({
    required this.repository,
    this.cache, // Optional
  });
  
  final UserRepository repository;
  final CacheService? cache;
}

// Registration with optional
getIt.registerLazySingleton<UserService>(
  () => UserService(
    repository: getIt(),
    cache: getIt.isRegistered<CacheService>() ? getIt() : null,
  ),
);
```

### Pattern 3: BLoC Registration

```dart
// Register BLoC as Factory (new instance each time)
getIt.registerFactory<ThemeBloc>(
  () => ThemeBloc(
    getCurrentThemeUseCase: getIt(),
    switchThemeUseCase: getIt(),
    manageThemeModeUseCase: getIt(),
  ),
);

// Usage in screen
class ThemeSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ThemeBloc>()..add(ThemeLoadCurrentEvent()),
      child: ThemeSettingsView(),
    );
  }
}
```

---

## Testing with Mocks

### Use Mockito for Testing

```dart
// test/domain/use_cases/get_theme_use_case_test.dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateMocks([ThemeRepository])
import 'get_theme_use_case_test.mocks.dart';

void main() {
  late MockThemeRepository mockRepository;
  late GetCurrentThemeUseCase useCase;
  
  setUp(() {
    mockRepository = MockThemeRepository();
    useCase = GetCurrentThemeUseCase(repository: mockRepository);
  });
  
  test('should return theme when repository succeeds', () async {
    // Arrange
    final testTheme = ThemeEntity(id: 'modern', name: 'Modern');
    when(mockRepository.getCurrentTheme()).thenAnswer(
      (_) async => Right(testTheme),
    );
    
    // Act
    final result = await useCase();
    
    // Assert
    expect(result, equals(Right(testTheme)));
    verify(mockRepository.getCurrentTheme()).called(1);
  });
}
```

---

## Anti-Patterns to Avoid

### ❌ DON'T: Use Service Locator in Business Logic

```dart
// ❌ BAD - Hidden dependency
class GetUserUseCase {
  Future<User?> call(String userId) async {
    final repo = GetIt.instance<UserRepository>(); // Hidden!
    return repo.getUser(userId);
  }
}

// ✅ GOOD - Explicit dependency
class GetUserUseCase {
  const GetUserUseCase({required this.repository});
  
  final UserRepository repository;
  
  Future<User?> call(String userId) async {
    return repository.getUser(userId);
  }
}
```

### ❌ DON'T: Register in Wrong Order

```dart
// ❌ BAD - Repository registered before DataSource
getIt.registerLazySingleton<UserRepository>(
  () => UserRepositoryImpl(dataSource: getIt()), // Will fail!
);

getIt.registerLazySingleton<LocalDataSource>(
  () => LocalDataSourceImpl(prefs: getIt()),
);

// ✅ GOOD - Correct order
getIt.registerLazySingleton<LocalDataSource>(
  () => LocalDataSourceImpl(prefs: getIt()),
);

getIt.registerLazySingleton<UserRepository>(
  () => UserRepositoryImpl(dataSource: getIt()),
);
```

### ❌ DON'T: Use Singleton for BLoCs

```dart
// ❌ BAD - BLoCs should be Factory
getIt.registerLazySingleton<UserBloc>(
  () => UserBloc(getUserUseCase: getIt()),
);

// ✅ GOOD - Use Factory for BLoCs
getIt.registerFactory<UserBloc>(
  () => UserBloc(getUserUseCase: getIt()),
);
```

---

## Best Practices Summary

✅ **DO:**
- Use constructor injection for ALL business logic
- Register dependencies in correct order
- Use LazySingleton for stateless services
- Use Factory for stateful services (BLoCs)
- Mock dependencies in tests
- Keep all registration in one file (dependency_injection.dart)

❌ **DON'T:**
- Use GetIt.instance<T>() in business logic
- Use @Injectable annotations (project doesn't use them)
- Register in wrong order
- Use Singleton for BLoCs
- Mix service locator with constructor injection

---

## Actual Implementation Reference

See complete working examples in:
- `lib/core/di/dependency_injection.dart` - All manual registrations
- `lib/domain/use_cases/theme/get_current_theme_use_case.dart` - Use case example
- `lib/data/repositories/theme_repository_impl.dart` - Repository example  
- `lib/presentation/blocs/theme/theme_bloc.dart` - BLoC example
