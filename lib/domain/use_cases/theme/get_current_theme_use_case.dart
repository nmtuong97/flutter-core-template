import '../../../core/errors/result.dart';
import '../../entities/theme_entity.dart';
import '../../repositories/theme_repository.dart';

/// Use case for getting the current active theme
class GetCurrentThemeUseCase {
  const GetCurrentThemeUseCase({
    required this.repository,
  });

  final ThemeRepository repository;

  /// Execute the use case
  FutureResult<ThemeEntity> call() async {
    return repository.getCurrentTheme();
  }
}
