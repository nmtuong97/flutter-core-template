import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../repositories/theme_repository.dart';

/// Use case for saving font size preference
///
/// Validates the font size before saving to repository.
/// Valid range: [AppConstants.minFontSize] to [AppConstants.maxFontSize]
///
/// Example:
/// ```dart
/// final result = await saveFontSizeUseCase(16.0);
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (_) => print('Font size saved successfully'),
/// );
/// ```
class SaveFontSizeUseCase {
  /// Creates a new instance with the required [repository]
  const SaveFontSizeUseCase({required this.repository});

  /// Theme repository for data access
  final ThemeRepository repository;

  /// Executes the use case with the given [fontSize]
  ///
  /// Parameters:
  /// - [fontSize]: The font size to save (must be within valid range)
  ///
  /// Returns [FutureResult] containing:
  /// - Right: void on success
  /// - Left: ValidationFailure if fontSize is invalid
  /// - Left: CacheFailure if unable to save
  FutureResult<void> call(double fontSize) async {
    // Validate font size range
    if (fontSize < AppConstants.minFontSize ||
        fontSize > AppConstants.maxFontSize) {
      return Left(
        ValidationFailure(
          message: AppConstants.invalidFontSizeMessage(fontSize),
          code: 'INVALID_FONT_SIZE',
        ),
      );
    }

    // Save to repository
    return repository.setFontSize(fontSize);
  }
}
