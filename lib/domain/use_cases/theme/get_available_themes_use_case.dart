import '../../../core/errors/result.dart';
import '../../entities/theme_entity.dart';
import '../../repositories/theme_repository.dart';

/// Use case for getting all available themes
class GetAvailableThemesUseCase {
  const GetAvailableThemesUseCase({
    required this.repository,
  });

  final ThemeRepository repository;

  /// Execute the use case
  FutureResult<List<ThemeEntity>> call() async {
    return repository.getAvailableThemes();
  }

  /// Get themes filtered by tags
  FutureResult<List<ThemeEntity>> getThemesByTags(List<String> tags) async {
    final result = await repository.getAvailableThemes();

    return result.fold(
      ResultHelper.failure,
      (themes) {
        final filteredThemes = themes.where((theme) {
          return tags.any((tag) => theme.tags.contains(tag));
        }).toList();
        return ResultHelper.success(filteredThemes);
      },
    );
  }

  /// Get only custom themes
  FutureResult<List<ThemeEntity>> getCustomThemes() async {
    final result = await repository.getAvailableThemes();

    return result.fold(
      ResultHelper.failure,
      (themes) {
        final customThemes = themes.where((theme) => theme.isCustom).toList();
        return ResultHelper.success(customThemes);
      },
    );
  }
}
