# Code Standards & Best Practices

## Language & Formatting

### Communication Language
- **All responses to user:** Vietnamese (Tiếng Việt)
- **All code elements:** English only
  - Variable names
  - Function names
  - Class names
  - Comments
  - Doc comments

### Example:
```dart
/// Fetches a user by their unique ID.
///
/// Throws a [UserNotFoundException] if no user is found.
Future<User> getUserById(String userId) async {
  // Implementation here
}
```

---

## Naming Conventions

### Boolean Naming
Always use meaningful prefixes:

```dart
// ✅ GOOD
bool isVisible = true;
bool hasPermission = false;
bool shouldRetry = true;
bool canEdit = false;
bool willUpdate = true;

// ❌ BAD
bool visible = true;
bool permission = false;
bool retry = true;
```

### Clarity Over Brevity
**Always prioritize clear, descriptive names:**

```dart
// ✅ GOOD
final List<User> activeSubscribedUsers = [];
Future<void> fetchUserProfileWithPreferences() async { }

// ❌ BAD
final List<User> users = [];
Future<void> fetch() async { }
```

### Avoid Magic Strings/Numbers
**Always use constants:**

```dart
// ❌ BAD
if (status == 'active') { }
await Future.delayed(Duration(seconds: 30));
const padding = 16.0;

// ✅ GOOD
class AppConstants {
  static const String statusActive = 'active';
  static const Duration networkTimeout = Duration(seconds: 30);
}

class AppSpacing {
  static const double standard = 16.0;
  static const double large = 24.0;
  static const double small = 8.0;
}

if (status == AppConstants.statusActive) { }
await Future.delayed(AppConstants.networkTimeout);
const padding = AppSpacing.standard;
```

---

## Immutability & Const Usage

### Prefer Final Variables
```dart
// ✅ GOOD
final String userId = 'user_123';
final List<String> items = ['a', 'b', 'c'];

// ❌ BAD (unless mutation is needed)
String userId = 'user_123';
List<String> items = ['a', 'b', 'c'];
```

### Aggressive Const Usage
**Use `const` whenever possible:**

```dart
// ✅ GOOD - Const constructors
class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);
}

// ✅ GOOD - Const widgets
const SizedBox(height: 16);
const Divider();
const Text('Hello');

// ✅ GOOD - Const collections
const List<String> supportedLanguages = ['en', 'vi'];
const Map<String, String> errorMessages = {
  'network': 'Network error',
  'auth': 'Authentication failed',
};
```

### Immutable Model Classes
```dart
// ✅ GOOD - Immutable with final fields
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
  });
  
  final String id;
  final String name;
  final String email;
  
  @override
  List<Object?> get props => [id, name, email];
  
  // CopyWith for modifications
  User copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
```

---

## Documentation (Doc Comments)

### Golden Rule
**All public members MUST have doc comments.**

### Format
```dart
/// Short summary (one line).
///
/// Detailed description with examples if needed.
/// Can span multiple lines.
///
/// Throws [ExceptionType] when [condition].
/// Returns [ReturnType] representing [meaning].
///
/// Example:
/// ```dart
/// final user = await getUserById('123');
/// print(user.name);
/// ```
///
/// See also:
/// * [RelatedClass] for related functionality
/// * [OtherMethod] for alternative approach
```

### Examples

#### Class Documentation
```dart
/// Manages user authentication and session handling.
///
/// This class provides methods for login, logout, and session validation.
/// It uses [SharedPreferences] for token storage and [http] for API calls.
///
/// Example:
/// ```dart
/// final authService = AuthService();
/// await authService.login('user@example.com', 'password');
/// ```
class AuthService {
  // Implementation
}
```

#### Method Documentation
```dart
/// Fetches a user by their unique ID.
///
/// The [userId] must be a valid UUID string.
///
/// Returns the [User] object if found, or `null` if not found.
/// Throws [NetworkException] if the request fails.
/// Throws [ValidationException] if [userId] is invalid.
///
/// Example:
/// ```dart
/// final user = await getUserById('550e8400-e29b-41d4-a716-446655440000');
/// if (user != null) {
///   print(user.name);
/// }
/// ```
Future<User?> getUserById(String userId) async {
  // Implementation
}
```

#### Parameter Documentation
```dart
/// Updates a user's profile information.
///
/// Parameters:
/// * [userId]: The unique identifier of the user to update
/// * [name]: The new name for the user (optional)
/// * [email]: The new email address (optional, must be valid)
/// * [avatarUrl]: URL to the user's avatar image (optional)
///
/// Returns `true` if the update was successful, `false` otherwise.
Future<bool> updateUserProfile({
  required String userId,
  String? name,
  String? email,
  String? avatarUrl,
}) async {
  // Implementation
}
```

---

## Async/Await Best Practices

### Always Handle Async Operations Properly
```dart
// ✅ GOOD
Future<User?> getUser(String id) async {
  try {
    final response = await _apiClient.get('/users/$id');
    return User.fromJson(response.data);
  } on NetworkException catch (e) {
    Log.e('Network error fetching user: $e');
    rethrow;
  } on Exception catch (e) {
    Log.e('Unexpected error: $e');
    return null;
  }
}

// ❌ BAD - Unhandled Future
Future<User?> getUser(String id) {
  return _apiClient.get('/users/$id').then((response) {
    return User.fromJson(response.data);
  }); // No error handling!
}
```

### Use Timeout for Long Operations
```dart
// ✅ GOOD
Future<User?> getUserWithTimeout(String id) async {
  try {
    final response = await _apiClient
        .get('/users/$id')
        .timeout(
          const Duration(seconds: 30),
          onTimeout: () => throw TimeoutException('Request timed out'),
        );
    return User.fromJson(response.data);
  } on TimeoutException catch (e) {
    Log.e('Request timeout: $e');
    return null;
  }
}
```

### Never Run Side Effects in Build
```dart
// ❌ BAD - Side effect in build method
@override
Widget build(BuildContext context) {
  fetchUserData(); // NEVER DO THIS!
  return Container();
}

// ✅ GOOD - Use lifecycle methods
@override
void initState() {
  super.initState();
  _fetchUserData();
}

@override
Widget build(BuildContext context) {
  return Container();
}
```

---

## Exception Handling

### Use Custom Business Exceptions
```dart
// ✅ GOOD - Custom exception
class UserNotFoundException implements Exception {
  UserNotFoundException({required this.userId});
  
  final String userId;
  
  @override
  String toString() => 'User not found: $userId';
}

// Usage in Use Case
Future<User> getUserById(String userId) async {
  final user = await _repository.getUser(userId);
  if (user == null) {
    throw UserNotFoundException(userId: userId);
  }
  return user;
}

// ❌ BAD - Generic exception
Future<User> getUserById(String userId) async {
  final user = await _repository.getUser(userId);
  if (user == null) {
    throw Exception('User not found'); // Too generic!
  }
  return user;
}
```

### Never Swallow Exceptions Silently
```dart
// ❌ BAD - Silent failure
try {
  await dangerousOperation();
} catch (e) {
  // Nothing here - exception is lost!
}

// ✅ GOOD - Log and handle
try {
  await dangerousOperation();
} catch (e, stackTrace) {
  Log.e('Dangerous operation failed', error: e, stackTrace: stackTrace);
  // Handle appropriately: rethrow, return default, show error, etc.
  rethrow;
}
```

### Prefer Result Types Over Exceptions
```dart
// ✅ BEST - Using Either/Result
Future<Either<Failure, User>> getUserById(String userId) async {
  try {
    final user = await _dataSource.getUser(userId);
    return Right(user);
  } on NetworkException catch (e) {
    return Left(NetworkFailure(message: e.toString()));
  } on CacheException catch (e) {
    return Left(CacheFailure(message: e.toString()));
  }
}

// Usage
final result = await getUserById('123');
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (user) => print('Success: ${user.name}'),
);
```

---

## Code Reusability (DRY Principle)

### Identify Duplication Early
**Proactively suggest refactoring when you see duplication.**

```dart
// ❌ BAD - Repeated code
Widget buildUserCard(User user) {
  return Card(
    margin: EdgeInsets.all(16),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(user.name),
          Text(user.email),
        ],
      ),
    ),
  );
}

Widget buildProductCard(Product product) {
  return Card(
    margin: EdgeInsets.all(16),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(product.name),
          Text(product.price.toString()),
        ],
      ),
    ),
  );
}

// ✅ GOOD - Reusable component
Widget buildInfoCard({
  required String title,
  required String subtitle,
}) {
  return Card(
    margin: const EdgeInsets.all(16),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(title),
          Text(subtitle),
        ],
      ),
    ),
  );
}

// Usage
buildInfoCard(title: user.name, subtitle: user.email);
buildInfoCard(title: product.name, subtitle: product.price.toString());
```

### Extract Reusable Logic
```dart
// ❌ BAD - Duplicated validation
class LoginBloc {
  bool isEmailValid(String email) {
    return email.contains('@') && email.length > 5;
  }
}

class RegisterBloc {
  bool isEmailValid(String email) {
    return email.contains('@') && email.length > 5;
  }
}

// ✅ GOOD - Shared validator
class EmailValidator {
  static bool isValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

// Or as extension
extension EmailValidation on String {
  bool get isValidEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
}

// Usage
if (email.isValidEmail) { }
```

---

## Accessibility & Internationalization

### Use Semantics for Accessibility
```dart
// ✅ GOOD - Accessible image
Semantics(
  label: 'User profile photo',
  child: Image.network(user.avatarUrl),
)

// ✅ GOOD - Accessible button
Semantics(
  label: 'Submit form',
  button: true,
  child: ElevatedButton(
    onPressed: _submit,
    child: const Text('Submit'),
  ),
)
```

### Never Hardcode Strings
```dart
// ❌ BAD
Text('Welcome to our app')

// ✅ GOOD - Use localization
Text(context.l10n.welcomeMessage)

// In ARB file:
// {
//   "welcomeMessage": "Welcome to our app",
//   "@welcomeMessage": {
//     "description": "Welcome message on home screen"
//   }
// }
```

---

## Security Best Practices

### Never Log Sensitive Data
```dart
// ❌ BAD - Exposes password in logs
Log.d('User login: ${user.toJson()}'); // Contains password!

// ✅ GOOD - Log only safe data
Log.d('User logged in: {userId: ${user.id}, email: ${user.email}}');

// ✅ BETTER - Use sanitized toString()
class User {
  String id;
  String email;
  String password; // Sensitive
  
  @override
  String toString() => 'User(id: $id, email: $email)'; // No password
}
```

### Sanitize User Input
```dart
// ✅ GOOD - Validate and sanitize
String sanitizeInput(String input) {
  return input
      .trim()
      .replaceAll(RegExp(r'[<>]'), '') // Remove HTML tags
      .replaceAll(RegExp(r'[^\w\s@.-]'), ''); // Allow only safe chars
}
```

---

## Output Format Requirements

### Provide Complete, Working Code
**Every code response must be:**
1. **Complete** - Full file or method, not snippets
2. **Copy-paste ready** - Works immediately without modification
3. **Well-separated** - Clear file boundaries if multiple files

### Example Response Format:

```dart
// File: lib/domain/use_cases/get_user_use_case.dart
import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Fetches a user by their unique ID.
class GetUserUseCase {
  const GetUserUseCase(this._repository);
  
  final UserRepository _repository;
  
  Future<Either<Failure, User>> call(String userId) async {
    return _repository.getUserById(userId);
  }
}
```

---

## Interaction Principles

### Proactive Clarification
If requirements are unclear, **always ask** before implementing:

> "I need clarification on the following:
> 1. Should this endpoint use caching?
> 2. What should happen if the user is not found?
> 3. Do we need pagination for this list?"

### Proactive Improvement Suggestions
**Don't just follow instructions blindly.** If you see opportunities for:
- Better architecture
- Performance improvements
- Code quality enhancements
- Refactoring duplicated code

**Always suggest improvements** with reasoning:

> "I can implement this as requested, but I notice we have similar logic in `UserBloc`. 
> Would you like me to refactor this into a reusable `ValidationMixin` to follow DRY principle?"
