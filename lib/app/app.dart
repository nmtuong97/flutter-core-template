import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_theme_showcase/l10n/l10n.dart';
import 'package:flutter_theme_showcase/l10n/localization_provider.dart';
import 'package:flutter_theme_showcase/pages/theme_showcase_page.dart';
import 'package:flutter_theme_showcase/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Consumer2<ThemeProvider, LocalizationProvider>(
            builder: (context, themeProvider, localizationProvider, _) {
              return MaterialApp(
                theme: themeProvider.lightTheme,
                darkTheme: themeProvider.darkTheme,
                themeMode: themeProvider.themeMode,
                locale: localizationProvider.currentLocale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en'), Locale('vi')],
                home: const ThemeShowcasePage(),
              );
            },
          );
        },
      ),
    );
  }
}
