# Testing Patterns & Best Practices

## Testing Philosophy

This project follows **Test-Driven Development (TDD)** principles:
1. Write tests first
2. Implement code to pass tests
3. Refactor while keeping tests green

### Test Coverage Goals
- **Domain Layer**: 100% coverage (pure logic, easy to test)
- **Data Layer**: 90%+ coverage (mock external dependencies)
- **Presentation Layer**: 80%+ coverage (BLoC logic + critical widgets)

---

## Test Structure

### Organize Tests by Layer
```
test/
├── domain/
│   ├── entities/
│   │   └── user_test.dart
│   ├── use_cases/
│   │   └── get_user_use_case_test.dart
│   └── value_objects/
│       └── email_test.dart
├── data/
│   ├── models/
│   │   └── user_model_test.dart
│   ├── repositories/
│   │   └── user_repository_impl_test.dart
│   └── sources/
│       └── local_data_source_test.dart
└── presentation/
    ├── blocs/
    │   └── user/
    │       └── user_bloc_test.dart
    └── widgets/
        └── user_profile_widget_test.dart
```

---

## Unit Testing Use Cases

### Test Pattern: Arrange-Act-Assert
```dart
// test/domain/use_cases/get_user_use_case_test.dart
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../lib/core/errors/failures.dart';
import '../../../lib/domain/entities/user.dart';
import '../../../lib/domain/repositories/user_repository.dart';
import '../../../lib/domain/use_cases/get_user_use_case.dart';

@GenerateMocks([UserRepository])
import 'get_user_use_case_test.mocks.dart';

void main() {
  late MockUserRepository mockRepository;
  late GetUserUseCase useCase;
  
  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserUseCase(mockRepository);
  });
  
  group('GetUserUseCase', () {
    final testUser = User(
      id: '123',
      name: 'Test User',
      email: 'test@example.com',
    );
    
    test('should return user when repository returns success', () async {
      // Arrange
      when(mockRepository.getUserById('123')).thenAnswer(
        (_) async => Right(testUser),
      );
      
      // Act
      final result = await useCase('123');
      
      // Assert
      expect(result, equals(Right(testUser)));
      verify(mockRepository.getUserById('123')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
    
    test('should return failure when repository returns error', () async {
      // Arrange
      final failure = ServerFailure(message: 'Server error');
      when(mockRepository.getUserById('123')).thenAnswer(
        (_) async => Left(failure),
      );
      
      // Act
      final result = await useCase('123');
      
      // Assert
      expect(result, equals(Left(failure)));
      verify(mockRepository.getUserById('123')).called(1);
    });
    
    test('should validate user ID before calling repository', () async {
      // Arrange
      const invalidId = '';
      
      // Act
      final result = await useCase(invalidId);
      
      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Should return failure'),
      );
      verifyNever(mockRepository.getUserById(any));
    });
  });
}
```

---

## Testing Repositories

### Mock Data Sources
```dart
// test/data/repositories/user_repository_impl_test.dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../lib/data/models/user_model.dart';
import '../../../lib/data/repositories/user_repository_impl.dart';
import '../../../lib/data/sources/local/local_data_source.dart';
import '../../../lib/data/sources/remote/remote_data_source.dart';

@GenerateMocks([LocalDataSource, RemoteDataSource])
import 'user_repository_impl_test.mocks.dart';

void main() {
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late UserRepositoryImpl repository;
  
  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    repository = UserRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
    );
  });
  
  group('UserRepositoryImpl', () {
    final testUserModel = UserModel(
      id: '123',
      name: 'Test User',
      email: 'test@example.com',
    );
    
    group('getUserById', () {
      test('should return local data when available', () async {
        // Arrange
        when(mockLocalDataSource.getUser('123')).thenAnswer(
          (_) async => testUserModel,
        );
        
        // Act
        final result = await repository.getUserById('123');
        
        // Assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should return success'),
          (user) => expect(user.id, equals('123')),
        );
        verify(mockLocalDataSource.getUser('123')).called(1);
        verifyNever(mockRemoteDataSource.getUser(any));
      });
      
      test('should fetch from remote when local data not available', () async {
        // Arrange
        when(mockLocalDataSource.getUser('123')).thenAnswer(
          (_) async => null,
        );
        when(mockRemoteDataSource.getUser('123')).thenAnswer(
          (_) async => testUserModel,
        );
        when(mockLocalDataSource.saveUser(any)).thenAnswer(
          (_) async => Future.value(),
        );
        
        // Act
        final result = await repository.getUserById('123');
        
        // Assert
        expect(result.isRight(), true);
        verify(mockLocalDataSource.getUser('123')).called(1);
        verify(mockRemoteDataSource.getUser('123')).called(1);
        verify(mockLocalDataSource.saveUser(testUserModel)).called(1);
      });
      
      test('should return failure when both sources fail', () async {
        // Arrange
        when(mockLocalDataSource.getUser('123')).thenThrow(
          CacheException('Cache error'),
        );
        when(mockRemoteDataSource.getUser('123')).thenThrow(
          ServerException('Server error'),
        );
        
        // Act
        final result = await repository.getUserById('123');
        
        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<ServerFailure>()),
          (_) => fail('Should return failure'),
        );
      });
    });
  });
}
```

---

## Testing BLoC

### Use bloc_test Package
```dart
// test/presentation/blocs/user/user_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../lib/domain/entities/user.dart';
import '../../../../lib/domain/use_cases/get_user_use_case.dart';
import '../../../../lib/presentation/blocs/user/user_bloc.dart';
import '../../../../lib/presentation/blocs/user/user_event.dart';
import '../../../../lib/presentation/blocs/user/user_state.dart';

@GenerateMocks([GetUserUseCase])
import 'user_bloc_test.mocks.dart';

void main() {
  late MockGetUserUseCase mockGetUserUseCase;
  late UserBloc userBloc;
  
  setUp(() {
    mockGetUserUseCase = MockGetUserUseCase();
    userBloc = UserBloc(getUserUseCase: mockGetUserUseCase);
  });
  
  tearDown(() {
    userBloc.close();
  });
  
  group('UserBloc', () {
    final testUser = User(
      id: '123',
      name: 'Test User',
      email: 'test@example.com',
    );
    
    test('initial state should be UserInitial', () {
      expect(userBloc.state, equals(const UserInitial()));
    });
    
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when UserLoadEvent succeeds',
      build: () {
        when(mockGetUserUseCase('123')).thenAnswer(
          (_) async => Right(testUser),
        );
        return userBloc;
      },
      act: (bloc) => bloc.add(const UserLoadEvent('123')),
      expect: () => [
        const UserLoading(),
        UserLoaded(user: testUser),
      ],
      verify: (_) {
        verify(mockGetUserUseCase('123')).called(1);
      },
    );
    
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when UserLoadEvent fails',
      build: () {
        when(mockGetUserUseCase('123')).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Server error')),
        );
        return userBloc;
      },
      act: (bloc) => bloc.add(const UserLoadEvent('123')),
      expect: () => [
        const UserLoading(),
        isA<UserError>().having(
          (state) => state.message,
          'message',
          contains('Server error'),
        ),
      ],
    );
    
    blocTest<UserBloc, UserState>(
      'does not emit new states when event is added after bloc is closed',
      build: () => userBloc,
      act: (bloc) async {
        await bloc.close();
        bloc.add(const UserLoadEvent('123'));
      },
      expect: () => [],
    );
  });
}
```

---

## Widget Testing

### Test Widget Behavior
```dart
// test/presentation/widgets/user_profile_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/domain/entities/user.dart';
import '../../../lib/presentation/widgets/user_profile_widget.dart';

void main() {
  group('UserProfileWidget', () {
    final testUser = User(
      id: '123',
      name: 'Test User',
      email: 'test@example.com',
    );
    
    testWidgets('displays user name and email', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserProfileWidget(user: testUser),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
    });
    
    testWidgets('displays avatar when avatarUrl is provided', (tester) async {
      // Arrange
      final userWithAvatar = User(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserProfileWidget(user: userWithAvatar),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(NetworkImage), findsOneWidget);
    });
    
    testWidgets('calls onEdit when edit button is pressed', (tester) async {
      // Arrange
      var editCalled = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserProfileWidget(
              user: testUser,
              onEdit: () => editCalled = true,
            ),
          ),
        ),
      );
      
      // Act
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pump();
      
      // Assert
      expect(editCalled, true);
    });
  });
}
```

### Test Widget with BLoC
```dart
// test/presentation/pages/user_profile_page_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../lib/domain/entities/user.dart';
import '../../../lib/presentation/blocs/user/user_bloc.dart';
import '../../../lib/presentation/blocs/user/user_state.dart';
import '../../../lib/presentation/pages/user_profile_page.dart';

class MockUserBloc extends MockBloc<UserEvent, UserState>
    implements UserBloc {}

void main() {
  late MockUserBloc mockUserBloc;
  
  setUp(() {
    mockUserBloc = MockUserBloc();
  });
  
  tearDown(() {
    mockUserBloc.close();
  });
  
  group('UserProfilePage', () {
    final testUser = User(
      id: '123',
      name: 'Test User',
      email: 'test@example.com',
    );
    
    testWidgets('displays loading indicator when state is UserLoading',
        (tester) async {
      // Arrange
      when(() => mockUserBloc.state).thenReturn(const UserLoading());
      
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserBloc>.value(
            value: mockUserBloc,
            child: const UserProfilePage(),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    
    testWidgets('displays user profile when state is UserLoaded',
        (tester) async {
      // Arrange
      when(() => mockUserBloc.state).thenReturn(UserLoaded(user: testUser));
      
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserBloc>.value(
            value: mockUserBloc,
            child: const UserProfilePage(),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
    });
    
    testWidgets('displays error message when state is UserError',
        (tester) async {
      // Arrange
      when(() => mockUserBloc.state).thenReturn(
        const UserError(message: 'Failed to load user'),
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserBloc>.value(
            value: mockUserBloc,
            child: const UserProfilePage(),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Failed to load user'), findsOneWidget);
    });
  });
}
```

---

## Integration Testing

### Test Complete Flows
```dart
// integration_test/user_flow_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_theme_showcase/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('User Flow Integration Tests', () {
    testWidgets('complete user profile update flow', (tester) async {
      // Start app
      app.main();
      await tester.pumpAndSettle();
      
      // Navigate to profile page
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();
      
      // Verify profile page loaded
      expect(find.text('User Profile'), findsOneWidget);
      
      // Tap edit button
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      
      // Update name field
      await tester.enterText(
        find.byKey(const Key('name_field')),
        'Updated Name',
      );
      
      // Save changes
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      
      // Verify success message
      expect(find.text('Profile updated successfully'), findsOneWidget);
      
      // Verify updated name displayed
      expect(find.text('Updated Name'), findsOneWidget);
    });
  });
}
```

---

## Test Utilities

### Create Test Helpers
```dart
// test/helpers/test_helpers.dart

/// Creates a testable MaterialApp wrapper
Widget createTestableWidget(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: child,
    ),
  );
}

/// Creates a BLoC wrapper for testing
Widget createBlocTestableWidget<B extends BlocBase<S>, S>({
  required B bloc,
  required Widget child,
}) {
  return MaterialApp(
    home: BlocProvider<B>.value(
      value: bloc,
      child: Scaffold(body: child),
    ),
  );
}

/// Pumps and settles with custom duration
Future<void> pumpAndSettleWithDuration(
  WidgetTester tester, {
  Duration duration = const Duration(seconds: 5),
}) async {
  await tester.pumpAndSettle(duration);
}

/// Find by key helper
Finder findByKey(String key) => find.byKey(Key(key));

/// Find by text helper with partial match
Finder findByTextContaining(String text) {
  return find.byWidgetPredicate(
    (widget) => widget is Text && widget.data?.contains(text) == true,
  );
}
```

---

## Test Coverage

### Generate Coverage Report
```bash
# Run tests with coverage
flutter test --coverage --test-randomize-ordering-seed random

# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# Open report
open coverage/html/index.html
```

### Coverage Configuration
```dart
// test/coverage_helper_test.dart
// Imports all files to ensure coverage tracking

// Domain
import 'package:flutter_theme_showcase/domain/entities/user.dart';
import 'package:flutter_theme_showcase/domain/repositories/user_repository.dart';
import 'package:flutter_theme_showcase/domain/use_cases/get_user_use_case.dart';

// Data
import 'package:flutter_theme_showcase/data/models/user_model.dart';
import 'package:flutter_theme_showcase/data/repositories/user_repository_impl.dart';
import 'package:flutter_theme_showcase/data/sources/local/local_data_source.dart';

// Presentation
import 'package:flutter_theme_showcase/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_theme_showcase/presentation/pages/user_profile_page.dart';

void main() {
  // This file exists only to improve coverage tracking
}
```

---

## Testing Best Practices Summary

✅ **DO:**
- Write tests before implementation (TDD)
- Test each layer independently
- Mock all external dependencies
- Use descriptive test names
- Follow Arrange-Act-Assert pattern
- Test both success and failure cases
- Test edge cases and validation
- Achieve high coverage (80%+ overall)
- Use bloc_test for BLoC testing
- Create test helpers for common patterns

❌ **DON'T:**
- Test implementation details
- Write flaky tests
- Skip error case testing
- Mock what you own (mock dependencies, not your code)
- Test UI layout details (test behavior instead)
- Write tests that depend on each other
- Ignore test failures
- Write tests without assertions

---

## Test Naming Conventions

```dart
// ✅ GOOD - Descriptive test names
test('should return user when repository returns success', () {});
test('should throw UserNotFoundException when user does not exist', () {});
test('should validate email format before saving', () {});

// ❌ BAD - Vague test names
test('test user', () {});
test('works', () {});
test('test1', () {});
```

---

## Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/domain/use_cases/get_user_use_case_test.dart

# Run tests with coverage
flutter test --coverage

# Run tests in watch mode (requires package)
flutter test --watch

# Run tests with specific seed for reproducibility
flutter test --test-randomize-ordering-seed 12345
```
