# State Management with BLoC

## BLoC Pattern Overview

This project uses **flutter_bloc** for state management following the **BLoC (Business Logic Component)** pattern.

### Flow: Events → BLoC → States

```
UI Widget → Dispatch Event → BLoC processes → Emit State → UI updates
```

---

## BLoC Structure

### Event Classes
**Events represent user intentions or system events.**

```dart
// lib/presentation/blocs/user/user_event.dart
import 'package:equatable/equatable.dart';

/// Base class for all user events
abstract class UserEvent extends Equatable {
  const UserEvent();
  
  @override
  List<Object?> get props => [];
}

/// Load user by ID
class UserLoadEvent extends UserEvent {
  const UserLoadEvent(this.userId);
  
  final String userId;
  
  @override
  List<Object?> get props => [userId];
}

/// Update user profile
class UserUpdateEvent extends UserEvent {
  const UserUpdateEvent(this.user);
  
  final User user;
  
  @override
  List<Object?> get props => [user];
}

/// Delete user
class UserDeleteEvent extends UserEvent {
  const UserDeleteEvent(this.userId);
  
  final String userId;
  
  @override
  List<Object?> get props => [userId];
}
```

### State Classes
**States represent the current status of the feature.**

```dart
// lib/presentation/blocs/user/user_state.dart
import 'package:equatable/equatable.dart';

/// Base class for all user states
abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object?> get props => [];
}

/// Initial state
class UserInitial extends UserState {
  const UserInitial();
}

/// Loading state
class UserLoading extends UserState {
  const UserLoading();
}

/// Successfully loaded user
class UserLoaded extends UserState {
  const UserLoaded({required this.user});
  
  final User user;
  
  @override
  List<Object?> get props => [user];
}

/// Error state
class UserError extends UserState {
  const UserError({required this.message});
  
  final String message;
  
  @override
  List<Object?> get props => [message];
}

/// Operation in progress
class UserOperationInProgress extends UserState {
  const UserOperationInProgress({this.previousState});
  
  final UserLoaded? previousState;
  
  @override
  List<Object?> get props => [previousState];
}

/// Operation success
class UserOperationSuccess extends UserState {
  const UserOperationSuccess({
    required this.message,
    required this.updatedState,
  });
  
  final String message;
  final UserLoaded updatedState;
  
  @override
  List<Object?> get props => [message, updatedState];
}
```

### BLoC Class
**BLoC handles events and emits states.**

```dart
// lib/presentation/blocs/user/user_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilities/logger.dart';
import '../../../domain/use_cases/user/get_user_use_case.dart';
import '../../../domain/use_cases/user/update_user_use_case.dart';
import '../../../domain/use_cases/user/delete_user_use_case.dart';
import 'user_event.dart';
import 'user_state.dart';

/// BLoC for managing user state
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required this.getUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  }) : super(const UserInitial()) {
    on<UserLoadEvent>(_onLoad);
    on<UserUpdateEvent>(_onUpdate);
    on<UserDeleteEvent>(_onDelete);
  }
  
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  
  /// Load user by ID
  Future<void> _onLoad(
    UserLoadEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(const UserLoading());
      
      AppLogger.bloc('Loading user: ${event.userId}');
      
      final user = await getUserUseCase(event.userId);
      
      emit(UserLoaded(user: user));
      
      AppLogger.bloc('User loaded successfully: ${user.id}');
    } on UserNotFoundException catch (e) {
      AppLogger.error('User not found', error: e);
      emit(UserError(message: 'User not found: ${e.userId}'));
    } on Exception catch (e) {
      AppLogger.error('Failed to load user', error: e);
      emit(UserError(message: 'Failed to load user: $e'));
    }
  }
  
  /// Update user profile
  Future<void> _onUpdate(
    UserUpdateEvent event,
    Emitter<UserState> emit,
  ) async {
    // Save current state for rollback
    final currentState = state;
    
    if (currentState is! UserLoaded) {
      emit(const UserError(message: 'Cannot update: user not loaded'));
      return;
    }
    
    try {
      emit(UserOperationInProgress(previousState: currentState));
      
      AppLogger.bloc('Updating user: ${event.user.id}');
      
      await updateUserUseCase(event.user);
      
      emit(UserOperationSuccess(
        message: 'User updated successfully',
        updatedState: UserLoaded(user: event.user),
      ));
      
      AppLogger.bloc('User updated successfully: ${event.user.id}');
    } on Exception catch (e) {
      AppLogger.error('Failed to update user', error: e);
      
      // Rollback to previous state
      emit(currentState);
      emit(UserError(message: 'Failed to update user: $e'));
    }
  }
  
  /// Delete user
  Future<void> _onDelete(
    UserDeleteEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(const UserLoading());
      
      AppLogger.bloc('Deleting user: ${event.userId}');
      
      await deleteUserUseCase(event.userId);
      
      emit(const UserInitial());
      
      AppLogger.bloc('User deleted successfully: ${event.userId}');
    } on Exception catch (e) {
      AppLogger.error('Failed to delete user', error: e);
      emit(UserError(message: 'Failed to delete user: $e'));
    }
  }
}
```

---

## BLoC Conventions

### 1. One BLoC per Feature
```
lib/presentation/blocs/
├── auth/
│   ├── auth_bloc.dart
│   ├── auth_event.dart
│   └── auth_state.dart
├── user/
│   ├── user_bloc.dart
│   ├── user_event.dart
│   └── user_state.dart
└── theme/
    ├── theme_bloc.dart
    ├── theme_event.dart
    └── theme_state.dart
```

### 2. Events Trigger Use Cases
**BLoCs never call repositories directly - always through use cases.**

```dart
// ✅ GOOD
Future<void> _onLoad(
  UserLoadEvent event,
  Emitter<UserState> emit,
) async {
  emit(const UserLoading());
  
  final result = await getUserUseCase(event.userId); // ✅ Through use case
  
  await result.fold(
    (failure) async => emit(UserError(message: failure.message)),
    (user) async => emit(UserLoaded(user: user)),
  );
}

// ❌ BAD
Future<void> _onLoad(
  UserLoadEvent event,
  Emitter<UserState> emit,
) async {
  final result = await userRepository.getUser(event.userId); // ❌ Direct repository call
  // ... handle result
}
```

### 3. States Use Equatable
**Always implement Equatable for proper state comparison.**

```dart
class UserLoaded extends UserState {
  const UserLoaded({required this.user});
  
  final User user;
  
  @override
  List<Object?> get props => [user]; // ✅ Equatable for comparison
}
```

### 4. Handle All State Types
**Explicitly handle loading/success/error states.**

```dart
BlocBuilder<UserBloc, UserState>(
  builder: (context, state) {
    if (state is UserInitial) {
      return const Center(child: Text('Press button to load'));
    }
    
    if (state is UserLoading) {
      return const LoadingView();
    }
    
    if (state is UserError) {
      return ErrorView(message: state.message);
    }
    
    if (state is UserLoaded) {
      return UserProfileView(user: state.user);
    }
    
    // Fallback
    return const SizedBox.shrink();
  },
)
```

---

## Selective Rebuild & Performance

### Use buildWhen for Selective Rebuild
**Only rebuild when specific conditions are met.**

```dart
// ✅ GOOD - Selective rebuild
BlocBuilder<UserBloc, UserState>(
  buildWhen: (previous, current) {
    // Only rebuild when user data actually changes
    if (previous is UserLoaded && current is UserLoaded) {
      return previous.user != current.user;
    }
    return true; // Rebuild for state type changes
  },
  builder: (context, state) {
    if (state is UserLoaded) {
      return UserProfileView(user: state.user);
    }
    return const SizedBox.shrink();
  },
)
```

### Use BlocSelector for Granular Rebuilds
**Rebuild only when specific property changes.**

```dart
// ✅ GOOD - Only rebuild when user name changes
BlocSelector<UserBloc, UserState, String>(
  selector: (state) {
    if (state is UserLoaded) {
      return state.user.name;
    }
    return '';
  },
  builder: (context, userName) {
    return Text(userName);
  },
)
```

### Use BlocListener for Side Effects
**Handle navigation, dialogs, snackbars without rebuilding.**

```dart
// ✅ GOOD - Side effects without rebuild
BlocListener<UserBloc, UserState>(
  listener: (context, state) {
    if (state is UserOperationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
    
    if (state is UserError) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(state.message),
        ),
      );
    }
  },
  child: BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      // Only builds for UI changes
      if (state is UserLoaded) {
        return UserProfileView(user: state.user);
      }
      return const LoadingView();
    },
  ),
)
```

### Use BlocConsumer for Both
**Combine listener and builder.**

```dart
// ✅ GOOD - Both side effects and UI updates
BlocConsumer<UserBloc, UserState>(
  listener: (context, state) {
    // Side effects
    if (state is UserOperationSuccess) {
      Navigator.pop(context);
    }
  },
  builder: (context, state) {
    // UI rendering
    if (state is UserLoading) {
      return const LoadingView();
    }
    
    if (state is UserLoaded) {
      return UserForm(user: state.user);
    }
    
    return const SizedBox.shrink();
  },
)
```

---

## BLoC Lifecycle Management

### Provide BLoC at Appropriate Level
```dart
// ✅ GOOD - Screen-level BLoC
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.userId});
  
  final String userId;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserBloc>()..add(UserLoadEvent(userId)),
      child: const UserProfileView(),
    );
  }
}

// ✅ GOOD - App-level BLoC (for global state)
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ThemeBloc>()..add(const ThemeLoadCurrentEvent()),
        ),
        BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(const AuthCheckStatusEvent()),
        ),
      ],
      child: const MaterialApp(/* ... */),
    );
  }
}
```

### Close BLoC Properly
**BlocProvider automatically disposes BLoC when widget is disposed.**

```dart
// ✅ GOOD - Auto-disposal via BlocProvider
BlocProvider(
  create: (_) => getIt<UserBloc>(),
  child: const UserScreen(),
) // BLoC.close() called automatically when widget disposed

// ❌ BAD - Manual creation without disposal
class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _bloc = getIt<UserBloc>(); // ❌ Won't be disposed!
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _bloc,
      builder: (context, state) => Container(),
    );
  }
}
```

---

## Testing BLoC

### Use bloc_test Package
```dart
// test/presentation/blocs/user/user_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateMocks([GetUserUseCase, UpdateUserUseCase, DeleteUserUseCase])
import 'user_bloc_test.mocks.dart';

void main() {
  late MockGetUserUseCase mockGetUserUseCase;
  late MockUpdateUserUseCase mockUpdateUserUseCase;
  late MockDeleteUserUseCase mockDeleteUserUseCase;
  late UserBloc userBloc;
  
  setUp(() {
    mockGetUserUseCase = MockGetUserUseCase();
    mockUpdateUserUseCase = MockUpdateUserUseCase();
    mockDeleteUserUseCase = MockDeleteUserUseCase();
    
    userBloc = UserBloc(
      getUserUseCase: mockGetUserUseCase,
      updateUserUseCase: mockUpdateUserUseCase,
      deleteUserUseCase: mockDeleteUserUseCase,
    );
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
    
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when UserLoadEvent succeeds',
      build: () {
        when(mockGetUserUseCase('123')).thenAnswer(
          (_) async => testUser,
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
        when(mockGetUserUseCase('123')).thenThrow(
          UserNotFoundException(userId: '123'),
        );
        return userBloc;
      },
      act: (bloc) => bloc.add(const UserLoadEvent('123')),
      expect: () => [
        const UserLoading(),
        isA<UserError>().having(
          (state) => state.message,
          'message',
          contains('User not found'),
        ),
      ],
    );
  });
}
```

---

## BLoC Best Practices Summary

✅ **DO:**
- One BLoC per feature
- Events trigger use cases (never repositories)
- States use Equatable
- Handle all state types explicitly
- Use buildWhen for selective rebuild
- Use BlocListener for side effects
- Provide BLoC via BlocProvider
- Test BLoC with bloc_test

❌ **DON'T:**
- Call repositories directly from BLoC
- Put business logic in widgets
- Forget to handle error states
- Create BLoC manually without BlocProvider
- Use setState in StatefulWidget for business logic
- Skip testing BLoC logic
