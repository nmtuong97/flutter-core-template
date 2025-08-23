import '../../../core/errors/result.dart';
import '../../entities/localization_entity.dart';
import '../../repositories/localization_repository.dart';

/// Use case for getting the current active localization
class GetCurrentLocalizationUseCase {
  const GetCurrentLocalizationUseCase({
    required this.repository,
  });

  final LocalizationRepository repository;

  /// Execute the use case
  FutureResult<LocalizationEntity> call() async {
    return repository.getCurrentLocalization();
  }

  /// Get current locale only
  FutureResult<String> getCurrentLocaleString() async {
    final result = await repository.getCurrentLocalization();

    return result.fold(
      ResultHelper.failure,
      (localization) => ResultHelper.success(localization.localeString),
    );
  }
}
