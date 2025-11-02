import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/result.dart';
import '../../repositories/theme_repository.dart';

/// Use case for retrieving the current font size preference
///
/// Returns the saved font size from repository, or [AppConstants.defaultFontSize]
/// if no preference exists.
///
/// Example:
/// ```dart
/// final result = await getFontSizeUseCase();
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (fontSize) => print('Current font size: $fontSize'),
/// );
/// ```
class GetFontSizeUseCase {
  /// Creates a new instance with the required [repository]
  const GetFontSizeUseCase({required this.repository});

  /// Theme repository for data access
  final ThemeRepository repository;

  /// Executes the use case
  ///
  /// Returns [FutureResult] containing:
  /// - Right: The current font size (double)
  /// - Left: Failure if unable to retrieve font size
  FutureResult<double> call() async {
    return repository.getCurrentFontSize();
  }
}
