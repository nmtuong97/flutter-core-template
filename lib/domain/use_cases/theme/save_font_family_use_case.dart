import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../repositories/theme_repository.dart';

/// Use case for saving font family preference
///
/// Validates the font family before saving to repository.
/// Must be one of [AppConstants.supportedFontFamilies]
///
/// Example:
/// ```dart
/// final result = await saveFontFamilyUseCase('Inter');
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (_) => print('Font family saved successfully'),
/// );
/// ```
class SaveFontFamilyUseCase {
  /// Creates a new instance with the required [repository]
  const SaveFontFamilyUseCase({required this.repository});

  /// Theme repository for data access
  final ThemeRepository repository;

  /// Executes the use case with the given [fontFamily]
  ///
  /// Parameters:
  /// - [fontFamily]: The font family to save (must be supported)
  ///
  /// Returns [FutureResult] containing:
  /// - Right: void on success
  /// - Left: ValidationFailure if fontFamily is not supported
  /// - Left: CacheFailure if unable to save
  FutureResult<void> call(String fontFamily) async {
    // Validate font family is supported
    if (!AppConstants.supportedFontFamilies.contains(fontFamily)) {
      return Left(
        ValidationFailure(
          message: AppConstants.unsupportedFontFamilyMessage(fontFamily),
          code: 'UNSUPPORTED_FONT_FAMILY',
        ),
      );
    }

    // Save to repository
    return repository.setFontFamily(fontFamily);
  }
}
