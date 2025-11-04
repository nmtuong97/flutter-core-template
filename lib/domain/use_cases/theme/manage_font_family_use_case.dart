import '../../../core/errors/result.dart';
import '../../repositories/theme_repository.dart';

/// Use case for managing font family
class ManageFontFamilyUseCase {
  const ManageFontFamilyUseCase({required this.repository});

  final ThemeRepository repository;

  /// Get current font family
  FutureResult<String> getCurrentFontFamily() async {
    return repository.getCurrentFontFamily();
  }

  /// Set font family
  FutureResult<void> setFontFamily(String fontFamily) async {
    return repository.setFontFamily(fontFamily);
  }
}
