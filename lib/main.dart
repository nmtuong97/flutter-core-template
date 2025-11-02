import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/dependency_injection.dart';
import 'core/errors/error_handler.dart';
import 'core/utilities/logger.dart';
import 'presentation/blocs/localization/localization_bloc.dart';
import 'presentation/blocs/localization/localization_event.dart';
import 'presentation/blocs/theme/theme_bloc.dart';
import 'presentation/blocs/theme/theme_event.dart';
import 'presentation/pages/clean_app.dart';

/// Main entry point for the Clean Architecture version
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize global error handling
  GlobalErrorHandler.initialize();

  try {
    // Initialize dependency injection
    AppLogger.info('Initializing dependencies...');
    await initializeDependencies();
    AppLogger.info('Dependencies initialized successfully');

    // Run the app
    runApp(const CleanArchitectureApp());
  } on Exception catch (e, stackTrace) {
    AppLogger.error(
      'Failed to initialize application',
      error: e,
      stackTrace: stackTrace,
    );

    // Run a fallback app
    runApp(
      MaterialApp(
        title: 'Flutter Theme Showcase - Error',
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Failed to initialize application',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Error: $e',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Main app widget using Clean Architecture
class CleanArchitectureApp extends StatelessWidget {
  const CleanArchitectureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            AppLogger.info('Creating ThemeBloc from DI...');
            return getIt<ThemeBloc>()..add(const ThemeLoadCurrentEvent());
          },
        ),
        BlocProvider(
          create: (context) {
            AppLogger.info('Creating LocalizationBloc from DI...');
            return getIt<LocalizationBloc>()
              ..add(const LocalizationLoadCurrentEvent());
          },
        ),
      ],
      child: const CleanApp(),
    );
  }
}
