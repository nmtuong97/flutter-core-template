# Architecture & Design Principles

## Clean Architecture Overview

This project strictly follows **Clean Architecture** with 3 layers:

### 1. Domain Layer (`lib/domain/`)
- **Pure business logic** - NO Flutter dependencies
- Contains:
  - **Entities**: Immutable business objects with `Equatable`
  - **Repositories**: Abstract interfaces defining data contracts
  - **Use Cases**: Single-responsibility business operations
  - **Value Objects**: Type-safe wrappers (e.g., Email, UserId)
  - **Factories**: Object creation logic

### 2. Data Layer (`lib/data/`)
- **Implementation details** - handles data persistence
- Contains:
  - **Repository Implementations**: Concrete implementations of domain repositories
  - **Models (DTOs)**: Data Transfer Objects with JSON serialization
  - **Data Sources**: Local (SharedPreferences/DB) and Remote (API) access
  - **Mappers**: Convert between Models ↔ Entities

### 3. Presentation Layer (`lib/presentation/`)
- **UI logic** using **BLoC pattern**
- Contains:
  - **BLoCs**: State management (Events → BLoC → States)
  - **Pages/Screens**: UI components
  - **Widgets**: Reusable UI elements

### Dependency Flow
```
Presentation → Domain ← Data
```

**Critical Rules:**
- ✅ Presentation depends on Domain (use cases & entities)
- ✅ Data depends on Domain (implements repository interfaces)
- ✅ Domain depends on **NOTHING** (pure Dart)
- ❌ Domain NEVER imports Flutter or Data layer

---

## SOLID Principles

### 1. Single Responsibility Principle (SRP)
**Each class/file has ONE reason to change.**

❌ **BAD - God Class:**
```dart
class UserManager {
  Future<User> getUser() { }
  Future<void> saveUser() { }
  Widget buildUserWidget() { }
  String validateEmail() { }
}
```

✅ **GOOD - Separated Concerns:**
```dart
// Domain
class GetUserUseCase { }
class SaveUserUseCase { }

// Presentation
class UserProfileWidget extends StatelessWidget { }

// Utilities
extension EmailValidator on String {
  bool get isValidEmail => /* validation */;
}
```

### 2. Open/Closed Principle (OCP)
**Open for extension, closed for modification.**

Use **abstract classes** and **interfaces**:
```dart
abstract class DataSource {
  Future<User> getUser(String id);
}

class RemoteDataSource implements DataSource { }
class LocalDataSource implements DataSource { }
```

### 3. Liskov Substitution Principle (LSP)
**Subclasses must be substitutable for their base classes.**

```dart
abstract class Repository {
  Future<User> getUser(String id);
}

// Both implementations must fulfill the contract
class UserRepositoryImpl implements Repository { }
class CachedUserRepository implements Repository { }
```

### 4. Interface Segregation Principle (ISP)
**Clients should not depend on interfaces they don't use.**

❌ **BAD:**
```dart
abstract class DataStorage {
  Future<void> saveToDatabase();
  Future<void> saveToFile();
  Future<void> saveToCloud();
}
```

✅ **GOOD:**
```dart
abstract class DatabaseStorage {
  Future<void> saveToDatabase();
}

abstract class FileStorage {
  Future<void> saveToFile();
}

abstract class CloudStorage {
  Future<void> saveToCloud();
}
```

### 5. Dependency Inversion Principle (DIP)
**Depend on abstractions, not concretions.**

✅ **Always:**
```dart
class GetUserUseCase {
  GetUserUseCase(this._repository); // Depend on interface
  
  final UserRepository _repository; // Abstract interface
}
```

❌ **Never:**
```dart
class GetUserUseCase {
  GetUserUseCase() {
    _repository = UserRepositoryImpl(); // Concrete dependency!
  }
}
```

---

## Repository Pattern

Repositories implement the **Repository Pattern** to abstract data access:

```dart
// Domain: Abstract repository interface
abstract class ThemeRepository {
  FutureResult<ThemeEntity> getCurrentTheme();
  FutureResult<void> saveTheme(ThemeEntity theme);
}

// Data: Implementation with LocalDataSource
class ThemeRepositoryImpl implements ThemeRepository {
  const ThemeRepositoryImpl({required this.localDataSource});
  
  final LocalDataSource localDataSource;
  
  @override
  FutureResult<ThemeEntity> getCurrentTheme() async {
    try {
      final themeId = await localDataSource.loadString(AppConstants.themeIdKey);
      final currentThemeId = themeId ?? AppConstants.defaultThemeId;
      return await getThemeById(currentThemeId);
    } on Exception catch (e) {
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }
  
  @override
  FutureResult<void> saveTheme(ThemeEntity theme) async {
    try {
      await localDataSource.saveString(AppConstants.themeIdKey, theme.id);
      return ResultHelper.success(null);
    } on Exception catch (e) {
      return ResultHelper.failure(GlobalErrorHandler.handleException(e));
    }
  }
}
```

---

## Separation of Concerns

### Model Separation (CRITICAL)

**NEVER mix models between layers:**

```dart
// Domain Entity
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
  });
  
  final String id;
  final String name;
  final String email;
}

// Data Model (DTO)
class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });
  
  final String id;
  final String name;
  final String email;
  
  // JSON serialization
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
  };
  
  // Mapper to Domain Entity
  User toEntity() => User(
    id: id,
    name: name,
    email: email,
  );
}

// Presentation Model (if needed)
class UserViewModel {
  UserViewModel(User user)
    : displayName = user.name,
      formattedEmail = user.email.toLowerCase();
  
  final String displayName;
  final String formattedEmail;
}
```

**Mapping Flow:**
```
Data Model (UserModel) → Domain Entity (User) → Presentation Model (UserViewModel)
```

---

## Extension & Mixin Usage

### When to Use Extensions
Use **extensions** for helper logic that doesn't belong in the class:

```dart
// ✅ GOOD: Extension for helper methods
extension StringValidation on String {
  bool get isValidEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  bool get isValidPhone => length >= 10 && RegExp(r'^[0-9]+$').hasMatch(this);
}

// Usage
if (email.isValidEmail) { }
```

### When to Use Mixins
Use **mixins** for reusable behaviors across multiple classes:

```dart
// ✅ GOOD: Mixin for shared behavior
mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  }
}

class LoginBloc with ValidationMixin {
  // Can use validateEmail() method
}

class RegisterBloc with ValidationMixin {
  // Can also use validateEmail() method
}
```

### Avoid Unnecessary Inheritance
❌ **BAD:**
```dart
class BaseScreen extends StatelessWidget {
  // Forcing inheritance for shared logic
}

class LoginScreen extends BaseScreen { }
```

✅ **GOOD:**
```dart
// Use composition instead
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.analytics});
  
  final Analytics analytics;
}
```

---

## Critical Anti-Patterns to Avoid

❌ **God Classes** - Classes with too many responsibilities
❌ **Layer Violations** - Domain importing from Data/Presentation
❌ **Tight Coupling** - Depending on concrete implementations
❌ **Magic Strings/Numbers** - Use constants instead
❌ **Mixed Concerns** - Business logic in UI widgets
❌ **Service Locator in Business Logic** - Use constructor injection

---

## Architecture Validation Checklist

Before committing code, verify:

- [ ] Domain layer has ZERO Flutter/Data imports
- [ ] Use Cases only depend on Repository interfaces
- [ ] Repositories are implemented in Data layer
- [ ] Models are separated: Entity ≠ DTO ≠ ViewModel
- [ ] All dependencies are injected via constructor
- [ ] Each class has single responsibility
- [ ] No business logic in Widgets/BLoCs
- [ ] Proper error handling with FutureResult<T> types
- [ ] All async operations have proper error handling
