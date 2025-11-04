import '../../../core/errors/result.dart';
import '../../repositories/theme_repository.dart';

/// Use case for managing font size
class ManageFontSizeUseCase {
  const ManageFontSizeUseCase({required this.repository});

  final ThemeRepository repository;

  /// Get current font size
  FutureResult<double> getCurrentFontSize() async {
    return repository.getCurrentFontSize();
  }

  /// Set font size
  FutureResult<void> setFontSize(double fontSize) async {
    return repository.setFontSize(fontSize);
  }
}
