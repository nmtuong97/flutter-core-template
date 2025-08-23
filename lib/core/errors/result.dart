import 'package:dartz/dartz.dart';

import 'failures.dart';

/// Type alias for Either with Failure as left and Success as right
typedef Result<T> = Either<Failure, T>;

/// Type alias for Future Result
typedef FutureResult<T> = Future<Result<T>>;

/// Extension methods for Result type to make it easier to work with
extension ResultExtension<T> on Result<T> {
  /// Returns true if the result is a success
  bool get isSuccess => isRight();

  /// Returns true if the result is a failure
  bool get isFailure => isLeft();

  /// Returns the success value or null if it's a failure
  T? get successValue => fold<T?>(
        (failure) => null,
        (success) => success,
      );

  /// Returns the failure or null if it's a success
  Failure? get failureValue => fold<Failure?>(
        (failure) => failure,
        (success) => null,
      );

  /// Executes onSuccess callback if result is success
  Result<T> onSuccess(void Function(T value) onSuccess) {
    fold<void>(
      (failure) => {},
      (success) => onSuccess(success),
    );
    return this;
  }

  /// Executes onFailure callback if result is failure
  Result<T> onFailure(void Function(Failure failure) onFailure) {
    fold<void>(
      (failure) => onFailure(failure),
      (success) => {},
    );
    return this;
  }
}

/// Helper functions to create Results
class ResultHelper {
  /// Creates a success result
  static Result<T> success<T>(T value) => Right(value);

  /// Creates a failure result
  static Result<T> failure<T>(Failure failure) => Left(failure);

  /// Creates a future success result
  static FutureResult<T> futureSuccess<T>(T value) async => Right(value);

  /// Creates a future failure result
  static FutureResult<T> futureFailure<T>(Failure failure) async =>
      Left(failure);
}
