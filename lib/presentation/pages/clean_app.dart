import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/app_localizations.dart';
import '../../pages/theme_showcase_page.dart';
import '../blocs/theme/theme_bloc.dart';
import '../blocs/theme/theme_event.dart';
import '../blocs/theme/theme_state.dart';

/// Clean Architecture version of the main app widget
class CleanApp extends StatelessWidget {
  const CleanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            // Show loading screen while initializing
            if (state is ThemeInitial || state is ThemeLoading) {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Theme Showcase',
                home: Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Loading theme...'),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Show error screen if theme loading failed
            if (state is ThemeError) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
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
                        Text(
                          'Theme Error',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Retry loading theme
                            context.read<ThemeBloc>().add(
                                  const ThemeLoadCurrentEvent(),
                                );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Show main app when theme is loaded
            if (state is ThemeLoaded ||
                state is ThemeOperationInProgress ||
                state is ThemeOperationSuccess) {
              late ThemeLoaded themeState;

              if (state is ThemeLoaded) {
                themeState = state;
              } else if (state is ThemeOperationInProgress &&
                  state.previousState != null) {
                themeState = state.previousState!;
              } else if (state is ThemeOperationSuccess) {
                themeState = state.updatedState;
              } else {
                // Fallback to default theme
                return const MaterialApp(
                  home: Scaffold(
                    body: Center(
                      child: Text('Theme state error'),
                    ),
                  ),
                );
              }

              return MaterialApp(
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context).appTitle,
                theme: themeState.lightTheme,
                darkTheme: themeState.darkTheme,
                themeMode: themeState.themeMode,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                home: const ThemeShowcasePage(),
              );
            }

            // Fallback for unknown states
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Unknown theme state'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
