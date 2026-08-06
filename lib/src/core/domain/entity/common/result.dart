import 'package:ecosystem_x_flutter/x_flutter_core_models.dart';

/// Application-layer result type for repository and domain operations.
///
/// Distinct from [DataResponse], which is the transport-layer contract.
/// Use [Result] at the repository/domain boundary — never as a return type
/// from networking code.
///
/// ```dart
/// // Repository method
/// Future<Result<UserEntity>> getUser(String id) async {
///   final response = await _source.getUser(id);
///   if (response.isError()) return Result.error(error: mapper.mapToFailure(response));
///   return Result.ok(mapper.map(response.data));
/// }
///
/// // Cubit
/// final result = await repository.getUser(id);
/// if (result.isError) {
///   emitFailure(result.asError.error);
///   return;
/// }
/// emit(state.copyWith(user: result.data));
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful result wrapping [data].
  factory Result.ok(T data) => ResultSuccess(data);

  /// Creates a failure result wrapping [error].
  factory Result.error({required Failure error}) => ResultFailure(error);

  /// Returns `true` if this is a [ResultFailure].
  bool get isError => this is ResultFailure<T>;

  /// Returns `true` if this is a [ResultSuccess].
  bool get isSuccess => this is ResultSuccess<T>;

  /// The success data. Throws [StateError] on a failure result.
  T get data;

  /// Casts to [ResultFailure]. Throws [StateError] if this is a [ResultSuccess].
  ResultFailure<T> get asError {
    if (this is! ResultFailure<T>) {
      throw StateError('Cannot call asError on a successful result');
    }
    return this as ResultFailure<T>;
  }

  /// Casts to [ResultSuccess]. Throws [StateError] if this is a [ResultFailure].
  ResultSuccess<T> get asSuccess {
    if (this is! ResultSuccess<T>) {
      throw StateError('Cannot call asSuccess on a failure result');
    }
    return this as ResultSuccess<T>;
  }
}

/// A successful [Result] containing [data].
final class ResultSuccess<T> extends Result<T> {
  final T _data;

  @override
  T get data => _data;

  const ResultSuccess(T data) : _data = data;
}

/// A failed [Result] containing a domain [error].
final class ResultFailure<T> extends Result<T> {
  final Failure error;

  @override
  T get data => throw StateError('Cannot access data on a failure result: $error');

  const ResultFailure(this.error);
}
