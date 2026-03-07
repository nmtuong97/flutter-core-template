import '../../../core/errors/result.dart';
import '../../entities/localization_entity.dart';
import '../../repositories/localization_repository.dart';

/// Use case for getting all supported localizations
class GetSupportedLocalizationsUseCase {
  const GetSupportedLocalizationsUseCase({
    required this.repository,
  });

  final LocalizationRepository repository;

  /// Execute the use case
  FutureResult<List<LocalizationEntity>> call() async {
    return repository.getSupportedLocalizations();
  }

  /// Get only default localization
  FutureResult<LocalizationEntity?> getDefaultLocalization() async {
    final result = await repository.getSupportedLocalizations();

    return result.fold(
      ResultHelper.failure,
      (localizations) {
        final defaultLoc =
            localizations.where((loc) => loc.isDefault).firstOrNull;
        return ResultHelper.success(defaultLoc);
      },
    );
  }

  /// Get RTL localizations
  FutureResult<List<LocalizationEntity>> getRtlLocalizations() async {
    final result = await repository.getSupportedLocalizations();

    return result.fold(
      ResultHelper.failure,
      (localizations) {
        final rtlLocalizations =
            localizations.where((loc) => loc.isRtl).toList();
        return ResultHelper.success(rtlLocalizations);
      },
    );
  }

  /// Get available language codes
  FutureResult<List<String>> getLanguageCodes() async {
    final result = await repository.getSupportedLocalizations();

    return result.fold(
      ResultHelper.failure,
      (localizations) {
        final languageCodes =
            localizations.map((loc) => loc.languageCode).toSet().toList();
        return ResultHelper.success(languageCodes);
      },
    );
  }
}
