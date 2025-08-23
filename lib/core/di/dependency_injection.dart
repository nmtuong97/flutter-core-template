import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/localization_repository_impl.dart';
import '../../data/repositories/theme_repository_impl.dart';
import '../../data/sources/local/local_data_source.dart';
import '../../domain/repositories/localization_repository.dart';
import '../../domain/repositories/theme_repository.dart';
import '../../domain/use_cases/localization/get_current_localization_use_case.dart';
import '../../domain/use_cases/localization/get_supported_localizations_use_case.dart';
import '../../domain/use_cases/localization/switch_localization_use_case.dart';
import '../../domain/use_cases/theme/get_available_themes_use_case.dart';
import '../../domain/use_cases/theme/get_current_theme_use_case.dart';
import '../../domain/use_cases/theme/manage_theme_mode_use_case.dart';
import '../../domain/use_cases/theme/switch_theme_use_case.dart';

/// Global instance of GetIt service locator
final GetIt getIt = GetIt.instance;

/// Initialize dependency injection container
Future<void> initializeDependencies() async {
  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt
    ..registerSingleton<SharedPreferences>(sharedPreferences)

    // Register Data Sources
    ..registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: getIt()),
    )

    // Register Repositories
    ..registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(localDataSource: getIt()),
    )
    ..registerLazySingleton<LocalizationRepository>(
      () => LocalizationRepositoryImpl(localDataSource: getIt()),
    )

    // Register Theme Use Cases
    ..registerLazySingleton<GetCurrentThemeUseCase>(
      () => GetCurrentThemeUseCase(repository: getIt()),
    )
    ..registerLazySingleton<GetAvailableThemesUseCase>(
      () => GetAvailableThemesUseCase(repository: getIt()),
    )
    ..registerLazySingleton<SwitchThemeUseCase>(
      () => SwitchThemeUseCase(repository: getIt()),
    )
    ..registerLazySingleton<ManageThemeModeUseCase>(
      () => ManageThemeModeUseCase(repository: getIt()),
    )

    // Register Localization Use Cases
    ..registerLazySingleton<GetCurrentLocalizationUseCase>(
      () => GetCurrentLocalizationUseCase(repository: getIt()),
    )
    ..registerLazySingleton<GetSupportedLocalizationsUseCase>(
      () => GetSupportedLocalizationsUseCase(repository: getIt()),
    )
    ..registerLazySingleton<SwitchLocalizationUseCase>(
      () => SwitchLocalizationUseCase(repository: getIt()),
    );
}

/// Reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await getIt.reset();
}
