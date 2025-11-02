# Copilot Instructions - Detailed Guidelines

Thư mục này chứa các hướng dẫn chi tiết cho AI coding agents khi làm việc với Flutter Core Template project.

## 📚 Cấu trúc Documentation

### [copilot-instructions.md](../copilot-instructions.md) - Master File
File chính chứa tổng quan kiến trúc và quick reference. Đây là điểm khởi đầu cho mọi AI agent.

### Các file chuyên biệt:

1. **[architecture.md](./architecture.md)** - Architecture & Design Principles
   - Clean Architecture overview (Domain, Data, Presentation)
   - SOLID principles với examples
   - Repository Pattern implementation
   - Model separation (Entity, DTO, ViewModel)
   - Extension & Mixin usage

2. **[code-standards.md](./code-standards.md)** - Code Standards & Best Practices
   - Naming conventions (booleans, clarity over brevity)
   - Immutability & const usage
   - Documentation (doc comments format)
   - Async/await best practices
   - Exception handling patterns
   - Code reusability (DRY principle)
   - Security practices
   - Accessibility & i18n

3. **[dependency-injection.md](./dependency-injection.md)** - Dependency Injection
   - DI Golden Rules (constructor injection, service locator restrictions)
   - Manual GetIt registration (NO @Injectable annotations)
   - Registration types (Singleton, LazySingleton, Factory)
   - Complete DI examples từ Domain → Data → Presentation
   - Testing with DI and mocks

4. **[presentation.md](./presentation.md)** - UI & Presentation Layer
   - Widget granularity & composition
   - Build method purity (no side effects)
   - Aggressive const usage
   - State management principles
   - Responsive design
   - Theme & style consistency
   - State-specific widgets (Loading, Error, Empty)
   - Accessibility với Semantics

5. **[state-management.md](./state-management.md)** - State Management with BLoC
   - BLoC pattern overview
   - Event/State/BLoC structure
   - BLoC conventions
   - Selective rebuild & performance (buildWhen, BlocSelector)
   - BLoC lifecycle management
   - Testing BLoC với bloc_test

6. **[testing.md](./testing.md)** - Testing Patterns & Best Practices
   - Testing philosophy & coverage goals
   - Unit testing Use Cases
   - Testing Repositories
   - Testing BLoC với bloc_test
   - Widget testing
   - Integration testing
   - Test utilities & helpers
   - Coverage generation

---

## 🎯 Khi nào sử dụng file nào?

### Tôi cần hiểu kiến trúc tổng thể
→ Đọc [copilot-instructions.md](../copilot-instructions.md) và [architecture.md](./architecture.md)

### Tôi đang implement Use Case mới
→ Đọc [architecture.md](./architecture.md) (SOLID, Repository Pattern) và [dependency-injection.md](./dependency-injection.md)

### Tôi đang viết UI code
→ Đọc [presentation.md](./presentation.md) và [code-standards.md](./code-standards.md)

### Tôi đang setup dependency injection
→ Đọc [dependency-injection.md](./dependency-injection.md)

### Tôi đang tạo BLoC mới
→ Đọc [state-management.md](./state-management.md)

### Tôi cần viết tests
→ Đọc [testing.md](./testing.md)

### Tôi muốn biết naming conventions
→ Đọc [code-standards.md](./code-standards.md)

---

## ✅ Checklist cho New Feature

Khi implement feature mới, đảm bảo tuân thủ:

### 1. Architecture (từ [architecture.md](./architecture.md))
- [ ] Domain layer không có Flutter dependencies
- [ ] Use Cases chỉ depend vào Repository interfaces
- [ ] Repositories implemented trong Data layer
- [ ] Models tách biệt: Entity ≠ DTO ≠ ViewModel
- [ ] Return type là `FutureResult<T>` (Either<Failure, T>)

### 2. Code Standards (từ [code-standards.md](./code-standards.md))
- [ ] Tất cả code elements viết bằng tiếng Anh
- [ ] Boolean variables dùng prefix `is`, `has`, `should`, `can`
- [ ] Không có magic strings/numbers (dùng constants)
- [ ] Tất cả public members có doc comments
- [ ] Sử dụng `final` và `const` đúng cách

### 3. Dependency Injection (từ [dependency-injection.md](./dependency-injection.md))
- [ ] Constructor injection cho tất cả dependencies
- [ ] KHÔNG sử dụng `GetIt.instance<T>()` trong business logic
- [ ] Dependencies đã register manually trong `dependency_injection.dart`
- [ ] Depend vào abstractions, không phải concrete classes
- [ ] KHÔNG dùng @Injectable annotations (project dùng manual registration)

### 4. Presentation (từ [presentation.md](./presentation.md))
- [ ] Widget nhỏ, single responsibility
- [ ] `build()` method pure (no side effects)
- [ ] Sử dụng `const` cho static widgets
- [ ] KHÔNG có business logic trong widgets
- [ ] UI responsive (MediaQuery/LayoutBuilder)
- [ ] Sử dụng theme cho colors/styles
- [ ] Strings được localize (không hardcode)

### 5. State Management (từ [state-management.md](./state-management.md))
- [ ] Events trigger Use Cases (không gọi repository trực tiếp)
- [ ] States sử dụng `Equatable`
- [ ] Handle tất cả state types (loading/success/error)
- [ ] Sử dụng `buildWhen` cho selective rebuild
- [ ] BLoC provided via `BlocProvider`

### 6. Testing (từ [testing.md](./testing.md))
- [ ] Unit tests cho Use Cases
- [ ] Repository tests với mock data sources
- [ ] BLoC tests với `bloc_test`
- [ ] Widget tests cho critical UI
- [ ] Coverage ≥ 80%

---

## 🚫 Common Mistakes to Avoid

### Architecture Violations
```dart
// ❌ BAD: Domain importing from Data layer
// lib/domain/entities/user.dart
import '../../data/models/user_model.dart'; // NEVER!

### Layer Violations
```dart
// ❌ BAD: Domain importing Flutter
import 'package:flutter/material.dart'; // In domain layer!

// ❌ BAD: BLoC calling Repository directly
Future<void> _onLoad(event, emit) async {
  final user = await _userRepository.getUser(id); // Should call Use Case!
}

// ❌ BAD: Not handling Result type
Future<User> getUser(String id) async {
  final user = await repository.getUser(id); // Returns FutureResult<User>, not User!
  return user; // Type error!
}
```
```

### DI Violations
```dart
// ❌ BAD: Service Locator in business logic
class GetUserUseCase {
  Future<User> call(String id) async {
    final repo = GetIt.instance<UserRepository>(); // FORBIDDEN!
    return repo.getUser(id);
  }
}
```

### UI Violations
```dart
// ❌ BAD: Business logic in widget
@override
Widget build(BuildContext context) {
  fetchUserData(); // Side effect in build!
  return Container();
}

// ❌ BAD: Hardcoded strings
Text('Welcome to our app') // Should be localized!
```

---

## 📖 Đọc thêm

- **Master Instructions**: [copilot-instructions.md](../copilot-instructions.md)
- **Project Documentation**: [DOCUMENTATION.md](../../DOCUMENTATION.md) (Vietnamese), [DOCUMENTATION_EN.md](../../DOCUMENTATION_EN.md) (English)
- **Theme System**: [lib/theme/README.md](../../lib/theme/README.md)

---

## 🤖 Dành cho AI Agents

Khi nhận request từ user:

1. **Xác định scope** - Feature thuộc layer nào? (Domain/Data/Presentation)
2. **Load relevant docs** - Đọc file chuyên biệt tương ứng
3. **Follow patterns** - Tuân thủ conventions và best practices
4. **Validate architecture** - Check không vi phạm Clean Architecture
5. **Suggest improvements** - Proactively đề xuất optimization nếu có
6. **Respond in Vietnamese** - Trả lời user bằng tiếng Việt, code bằng tiếng Anh

**Ưu tiên:**
1. Correctness (đúng logic, không bug)
2. Architecture compliance (tuân thủ Clean Architecture)
3. Code quality (readable, maintainable)
4. Performance (optimization hợp lý)
5. Documentation (doc comments đầy đủ)
