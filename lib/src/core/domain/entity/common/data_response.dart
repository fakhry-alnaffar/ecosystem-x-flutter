import 'package:ecosystem_x_flutter/x_flutter_core_models.dart';

/// Sealed result type for all HTTP responses.
///
/// Every [RequestProcessor.processRequest] call returns one of these variants.
/// Use pattern matching to handle each case exhaustively:
///
/// ```dart
/// switch (response) {
///   DataResponseSuccess(:final data) => // use data
///   DataResponseFailure(:final failure) => // already-mapped domain failure
///   NoInternetConnection() => // show offline UI
///   Unauthorized() => // redirect to login
///   TooManyRequests() => // show rate-limit message
///   ApiError(:final error, :final statusCode) => // map to domain failure
///   UndefinedError(:final errorObject) => // unexpected error
///   CanceledRequest() => // request was cancelled
/// }
/// ```
sealed class DataResponse<T> {
  const DataResponse();

  /// The parsed response data. Throws [StateError] on non-success variants.
  T get data {
    if (this is DataResponseSuccess<T>) {
      return (this as DataResponseSuccess<T>).data;
    }
    throw StateError('Cannot access data on a non-success response: $this');
  }

  /// Returns `true` if this is a [DataResponseSuccess].
  bool isSuccess() => this is DataResponseSuccess<T>;

  /// Returns `true` if this is any error variant.
  bool isError() => this is! DataResponseSuccess<T>;

  /// Creates a successful response wrapping [data].
  factory DataResponse.success(T data) => DataResponseSuccess(data);

  /// Creates an [UndefinedError] for unexpected exceptions.
  factory DataResponse.undefinedError(
    Object? errorObject, [
    int? statusCode,
  ]) =>
      UndefinedError(errorObject, statusCode);

  /// Creates an [ApiError] for known API-level error payloads.
  factory DataResponse.apiError(
    Object error, [
    int? statusCode,
  ]) =>
      ApiError(error, statusCode);

  /// Creates a [NoInternetConnection] response.
  factory DataResponse.notConnected() => NoInternetConnection();

  /// Creates an [Unauthorized] response.
  factory DataResponse.unauthorized() => Unauthorized();

  /// Creates a [TooManyRequests] response.
  factory DataResponse.tooManyRequests() => TooManyRequests();

  /// Creates a [CanceledRequest] response.
  factory DataResponse.canceledRequest() => CanceledRequest();

  /// Creates a [DataResponseFailure] carrying a pre-mapped domain [failure].
  factory DataResponse.failure(Failure failure) => DataResponseFailure(failure);
}

/// A successful response containing parsed [data].
final class DataResponseSuccess<T> extends DataResponse<T> {
  final T _data;

  @override
  T get data => _data;

  const DataResponseSuccess(T data) : _data = data;
}

/// An unrecognised error — the exception did not match any known mapping.
final class UndefinedError<T> extends DataResponse<T> {
  final Object? _errorObject;
  final int? _statusCode;

  /// The raw exception or error object.
  Object? get errorObject => _errorObject;

  /// The HTTP status code, or `null` if unavailable.
  int? get statusCode => _statusCode;

  const UndefinedError(
    Object? errorObject, [
    int? statusCode,
  ])  : _errorObject = errorObject,
        _statusCode = statusCode;
}

/// A known API error with a parsed [error] payload and [statusCode].
final class ApiError<T> extends DataResponse<T> {
  final Object _error;
  final int? _statusCode;

  /// The parsed API error object returned by the custom error handler.
  Object get error => _error;

  /// The HTTP status code.
  int? get statusCode => _statusCode;

  const ApiError(
    Object error, [
    int? statusCode,
  ])  : _error = error,
        _statusCode = statusCode;
}

/// Indicates no network connection was available when the request was made.
final class NoInternetConnection<T> extends DataResponse<T> {
  const NoInternetConnection();
}

/// Indicates the server returned HTTP 401 Unauthorized.
final class Unauthorized<T> extends DataResponse<T> {
  const Unauthorized();
}

/// Indicates the server returned HTTP 429 Too Many Requests.
final class TooManyRequests<T> extends DataResponse<T> {
  const TooManyRequests();
}

/// Indicates the request was cancelled via a Dio [CancelToken].
final class CanceledRequest<T> extends DataResponse<T> {
  const CanceledRequest();
}

/// A response that directly carries a pre-mapped domain [Failure].
///
/// Use when the failure type is already known and no further mapping is needed,
/// e.g. when composing results from lower-level services that already produce
/// [Failure] objects.
final class DataResponseFailure<T> extends DataResponse<T> {
  final Failure failure;
  const DataResponseFailure(this.failure);
}
