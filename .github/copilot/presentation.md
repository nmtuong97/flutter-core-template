# UI & Presentation Layer Best Practices

## Widget Granularity & Composition

### Single Responsibility per Widget
**Each widget should have ONE clear purpose.**

```dart
// ❌ BAD - Monolithic widget
class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          CircleAvatar(/* ... */),
          Text('User Name'),
          Text('user@email.com'),
          // ... 100 more lines
        ],
      ),
    );
  }
}

// ✅ GOOD - Composed from smaller widgets
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserProfileAppBar(),
      body: const UserProfileBody(),
    );
  }
}

class UserProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserProfileAppBar({super.key});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Profile'),
      actions: const [
        EditButton(),
        SettingsButton(),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UserAvatar(),
        UserInfoSection(),
        UserActionButtons(),
        UserStatisticsSection(),
      ],
    );
  }
}
```

---

## Build Method Purity

### NO Side Effects in build()
**build() must be pure - only UI rendering, no state changes.**

```dart
// ❌ BAD - Side effects in build
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    fetchUserData(); // ❌ NEVER DO THIS!
    saveToDatabase(); // ❌ NEVER DO THIS!
    showDialog(context: context, builder: (_) => AlertDialog()); // ❌ NEVER!
    
    return Container();
  }
}

// ✅ GOOD - Side effects in proper lifecycle methods
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    _fetchUserData(); // ✅ OK here
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(); // ✅ Pure rendering only
  }
  
  Future<void> _fetchUserData() async {
    // Fetch logic
  }
}
```

---

## Aggressive Const Usage

### Use const for Static Widgets
**Every widget that doesn't depend on runtime data should be const.**

```dart
// ✅ GOOD - Const widgets
class MyScreen extends StatelessWidget {
  const MyScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: Column(
        children: [
          SizedBox(height: 16), // ✅ Const
          Divider(), // ✅ Const
          Text('Static text'), // ✅ Const
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();
  
  @override
  Widget build(BuildContext context) {
    return const AppBar(
      title: Text('Title'), // ✅ Const
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
```

### When NOT to Use Const
```dart
// ❌ Cannot use const when depending on runtime data
Widget build(BuildContext context) {
  final theme = Theme.of(context); // Runtime value
  final user = context.watch<User>(); // Runtime value
  
  return Container(
    color: theme.primaryColor, // Depends on theme
    child: Text(user.name), // Depends on user
  );
}
```

---

## State Management Principles

### NO Business Logic in Widgets
**Widgets ONLY handle UI. Business logic goes in BLoC/Use Cases.**

```dart
// ❌ BAD - Business logic in widget
class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  Future<void> _login() async {
    // ❌ BAD: Business logic in widget!
    final email = emailController.text;
    final password = passwordController.text;
    
    if (email.isEmpty || !email.contains('@')) {
      // Show error
      return;
    }
    
    final response = await http.post(
      Uri.parse('https://api.example.com/login'),
      body: {'email': email, 'password': password},
    );
    
    if (response.statusCode == 200) {
      // Navigate
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _login,
      child: const Text('Login'),
    );
  }
}

// ✅ GOOD - Business logic in BLoC
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.push(/* ... */);
        }
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: const LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EmailTextField(),
        const PasswordTextField(),
        ElevatedButton(
          onPressed: () {
            // ✅ Just dispatch event - BLoC handles logic
            context.read<LoginBloc>().add(const LoginButtonPressed());
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
```

### NO StatefulWidget for Business Logic
```dart
// ❌ BAD - Using StatefulWidget for business logic
class UserListScreen extends StatefulWidget {
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  bool isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }
  
  Future<void> _loadUsers() async {
    setState(() => isLoading = true);
    // ❌ Business logic in State class
    final response = await http.get(Uri.parse('https://api.example.com/users'));
    final data = jsonDecode(response.body) as List;
    setState(() {
      users = data.map((json) => User.fromJson(json)).toList();
      isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (isLoading) return CircularProgressIndicator();
    return ListView.builder(/* ... */);
  }
}

// ✅ GOOD - Business logic in BLoC
class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state is UserError) {
          return Center(child: Text(state.message));
        }
        
        if (state is UserLoaded) {
          return UserList(users: state.users);
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}
```

---

## Responsive Design

### Use LayoutBuilder & MediaQuery
**NEVER hardcode sizes - always adapt to screen size.**

```dart
// ❌ BAD - Hardcoded sizes
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // ❌ Fixed width
      height: 200, // ❌ Fixed height
      padding: EdgeInsets.all(16), // ❌ Fixed padding
    );
  }
}

// ✅ GOOD - Responsive
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTablet = mediaQuery.size.width > 600;
    
    return Container(
      width: mediaQuery.size.width * 0.8, // ✅ Responsive
      height: isTablet ? 400 : 200, // ✅ Adaptive
      padding: EdgeInsets.all(AppSpacing.standard), // ✅ From constants
    );
  }
}

// ✅ BETTER - Using LayoutBuilder
class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const DesktopLayout();
        } else if (constraints.maxWidth > 600) {
          return const TabletLayout();
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}
```

---

## Theme & Style Consistency

### Always Use Theme Context
**NEVER hardcode colors, text styles, or spacing.**

```dart
// ❌ BAD - Hardcoded styles
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello',
      style: TextStyle(
        color: Color(0xFF2196F3), // ❌ Hardcoded color
        fontSize: 16, // ❌ Hardcoded size
        fontWeight: FontWeight.bold, // ❌ Hardcoded weight
      ),
    );
  }
}

// ✅ GOOD - Using theme
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Text(
      'Hello',
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.primary,
      ),
    );
  }
}

// ✅ BETTER - Using theme extensions
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello',
      style: context.textTheme.titleMedium?.copyWith(
        color: context.colorScheme.primary,
      ),
    );
  }
}

// Extension for convenience
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
}
```

### Define Theme Constants
```dart
// lib/core/theme/app_spacing.dart
class AppSpacing {
  static const double xs = 4.0;
  static const double small = 8.0;
  static const double standard = 16.0;
  static const double large = 24.0;
  static const double xl = 32.0;
}

// lib/core/theme/app_colors.dart
class AppColors {
  // Light theme
  static const Color primaryLight = Color(0xFF2196F3);
  static const Color secondaryLight = Color(0xFF03DAC6);
  
  // Dark theme
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color secondaryDark = Color(0xFF018786);
}

// Usage
Container(
  padding: const EdgeInsets.all(AppSpacing.standard),
  color: AppColors.primaryLight,
)
```

---

## State-Specific Widgets

### Create Reusable State Widgets
**Common states should have dedicated widgets.**

```dart
// lib/presentation/widgets/common/loading_view.dart
class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message});
  
  final String? message;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.standard),
            Text(message!, style: context.textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}

// lib/presentation/widgets/common/error_view.dart
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
  });
  
  final String message;
  final VoidCallback? onRetry;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.standard),
            Text(
              message,
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.large),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// lib/presentation/widgets/common/empty_view.dart
class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.message,
    this.icon = Icons.inbox,
  });
  
  final String message;
  final IconData icon;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: context.colorScheme.onSurface.withOpacity(0.5),
          ),
          const SizedBox(height: AppSpacing.standard),
          Text(
            message,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Usage in screens
BlocBuilder<UserBloc, UserState>(
  builder: (context, state) {
    if (state is UserLoading) {
      return const LoadingView(message: 'Loading users...');
    }
    
    if (state is UserError) {
      return ErrorView(
        message: state.message,
        onRetry: () {
          context.read<UserBloc>().add(const UserLoadEvent());
        },
      );
    }
    
    if (state is UserLoaded && state.users.isEmpty) {
      return const EmptyView(
        message: 'No users found',
        icon: Icons.people_outline,
      );
    }
    
    if (state is UserLoaded) {
      return UserList(users: state.users);
    }
    
    return const SizedBox.shrink();
  },
)
```

---

## Accessibility

### Use Semantics Widgets
**Every interactive element must be accessible.**

```dart
// ✅ GOOD - Accessible image
Semantics(
  label: 'User profile photo',
  image: true,
  child: CircleAvatar(
    backgroundImage: NetworkImage(user.avatarUrl),
  ),
)

// ✅ GOOD - Accessible button
Semantics(
  label: 'Submit form',
  hint: 'Double tap to submit',
  button: true,
  child: ElevatedButton(
    onPressed: _submit,
    child: const Text('Submit'),
  ),
)

// ✅ GOOD - Accessible icon
Semantics(
  label: 'Delete item',
  button: true,
  child: IconButton(
    icon: const Icon(Icons.delete),
    onPressed: _delete,
  ),
)

// ✅ GOOD - Exclude decorative elements
ExcludeSemantics(
  child: Container(
    decoration: BoxDecoration(/* decorative only */),
  ),
)
```

---

## Internationalization

### NEVER Hardcode Strings
**All user-facing text must be localized.**

```dart
// ❌ BAD - Hardcoded strings
Text('Welcome to our app')
AppBar(title: Text('Settings'))
SnackBar(content: Text('Login successful'))

// ✅ GOOD - Localized strings
Text(context.l10n.welcomeMessage)
AppBar(title: Text(context.l10n.settingsTitle))
SnackBar(content: Text(context.l10n.loginSuccessMessage))

// In ARB files:
// lib/l10n/arb/app_en.arb
{
  "welcomeMessage": "Welcome to our app",
  "@welcomeMessage": {
    "description": "Welcome message on home screen"
  },
  "settingsTitle": "Settings",
  "@settingsTitle": {
    "description": "Title for settings screen"
  },
  "loginSuccessMessage": "Login successful",
  "@loginSuccessMessage": {
    "description": "Success message after login"
  }
}
```

---

## UI Best Practices Summary

✅ **DO:**
- Break down screens into small, focused widgets
- Use const for all static widgets
- Keep build() pure (no side effects)
- Always use theme for colors/styles
- Create reusable state widgets (Loading, Error, Empty)
- Make UI accessible with Semantics
- Localize all user-facing strings
- Make UI responsive with MediaQuery/LayoutBuilder

❌ **DON'T:**
- Put business logic in widgets
- Hardcode sizes, colors, or strings
- Use StatefulWidget for business logic
- Call async operations in build()
- Forget accessibility
- Skip responsive design considerations
