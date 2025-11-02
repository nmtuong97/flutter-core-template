import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/result.dart';
import '../../repositories/theme_repository.dart';

/// Use case for retrieving the current font family preference
///
/// Returns the saved font family from repository, or [AppConstants.defaultFontFamily]
/// if no preference exists.
///
/// Example:
/// ```dart
/// final result = await getFontFamilyUseCase();
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (fontFamily) => print('Current font family: $fontFamily'),
/// );
/// ```
class GetFontFamilyUseCase {
  /// Creates a new instance with the required [repository]
  const GetFontFamilyUseCase({required this.repository});

  /// Theme repository for data access
  final ThemeRepository repository;

  /// Executes the use case
  ///
  /// Returns [FutureResult] containing:
  /// - Right: The current font family (String)
  /// - Left: Failure if unable to retrieve font family
  FutureResult<String> call() async {
    return repository.getCurrentFontFamily();
  }
}
