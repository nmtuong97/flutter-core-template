import '../../../core/errors/failures.dart';
import '../../../core/errors/result.dart';
import '../../../core/utilities/validators.dart';
import '../../entities/theme_entity.dart';
import '../../repositories/theme_repository.dart';

/// Use case for switching to a different theme
class SwitchThemeUseCase {
  const SwitchThemeUseCase({
    required this.repository,
  });

  final ThemeRepository repository;

  /// Execute the use case
  FutureResult<ThemeEntity> call(String themeId) async {
    // Validate theme ID
    final validationError = Validators.getThemeIdError(themeId);
    if (validationError != null) {
      return ResultHelper.failure(
        ValidationFailure(message: validationError),
      );
    }

    // Check if theme exists
    final existsResult = await repository.themeExists(themeId);

    return existsResult.fold(
      ResultHelper.failure,
      (exists) async {
        if (!exists) {
          return ResultHelper.failure(
            const ThemeFailure(
              message: 'Theme not found',
              code: 'THEME_NOT_FOUND',
            ),
          );
        }

        // Set the current theme
        final setResult = await repository.setCurrentTheme(themeId);

        return setResult.fold(
          ResultHelper.failure,
          (_) async {
            // Return the newly set theme
            return repository.getCurrentTheme();
          },
        );
      },
    );
  }

  /// Switch to default theme
  FutureResult<ThemeEntity> switchToDefault() async {
    return call('default');
  }

  /// Switch to previous theme (if available)
  FutureResult<ThemeEntity> switchToPrevious() async {
    // This would require storing previous theme in preferences
    // For now, just switch to default
    return switchToDefault();
  }
}
