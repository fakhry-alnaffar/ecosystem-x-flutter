import 'package:ecosystem_x_flutter/src/core/domain/entity/common/data_response.dart';

/// Callback that maps a raw API error payload to a domain error object.
///
/// [statusCode] is the HTTP status code; [response] is the parsed response body
/// (typically a `Map<String, dynamic>`, but may be any type).
typedef OnCustomError<T> = Object Function(
  int statusCode,
  dynamic response,
);

/// Contract for converting exceptions into typed [DataResponse] error variants.
///
/// Implement this to provide custom error mapping logic. Pass the implementation
/// to [InternalDioRequestProcessor] via its constructor.
abstract class ErrorProcessor {
  /// Maps [e] to a [DataResponse] error variant.
  ///
  /// If [onCustomError] is provided it is called for API-level errors before
  /// falling back to the default mapping.
  DataResponse<T> processError<T>(
    Exception e, {
    OnCustomError? onCustomError,
  });
}
