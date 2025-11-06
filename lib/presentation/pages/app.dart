import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/app_localizations.dart';
import '../../pages/theme_showcase_page.dart';
import '../blocs/localization/localization_bloc.dart';
import '../blocs/localization/localization_state.dart';
import '../blocs/theme/theme_bloc.dart';
import '../blocs/theme/theme_event.dart';
import '../blocs/theme/theme_state.dart';

/// Main app widget
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, localizationState) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                // Show loading screen while initializing
                if (themeState is ThemeInitial ||
                    themeState is ThemeLoading ||
                    localizationState is LocalizationInitial ||
                    localizationState is LocalizationLoading) {
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
                            Text('Loading...'),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                // Show error screen if theme loading failed
                if (themeState is ThemeError) {
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
                              themeState.message,
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
                if (themeState is ThemeLoaded ||
                    themeState is ThemeOperationInProgress ||
                    themeState is ThemeOperationSuccess) {
                  late ThemeLoaded loadedThemeState;

                  if (themeState is ThemeLoaded) {
                    loadedThemeState = themeState;
                  } else if (themeState is ThemeOperationInProgress &&
                      themeState.previousState != null) {
                    loadedThemeState = themeState.previousState!;
                  } else if (themeState is ThemeOperationSuccess) {
                    loadedThemeState = themeState.updatedState;
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

                  // Get current locale
                  Locale? currentLocale;
                  if (localizationState is LocalizationLoaded) {
                    currentLocale =
                        localizationState.currentLocalization.locale;
                  }

                  return MaterialApp(
                    onGenerateTitle: (context) =>
                        AppLocalizations.of(context).appTitle,
                    theme: loadedThemeState.lightTheme,
                    darkTheme: loadedThemeState.darkTheme,
                    themeMode: loadedThemeState.themeMode,
                    locale: currentLocale,
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
      },
    );
  }
}
