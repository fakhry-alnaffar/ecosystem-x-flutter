import 'package:flutter/foundation.dart';
import 'package:ecosystem_x_flutter/src/core/domain/entity/common/data_response.dart';
import 'package:ecosystem_x_flutter/x_flutter_core_models.dart';

/// Maps a [DataResponse] error variant to the matching [Failure] type from
/// `x_flutter_core_models`.
///
/// Subclass this and override [onCustomError] to translate application-specific
/// API error payloads into domain [Failure] objects.
///
/// ```dart
/// class MyErrorMapper extends ServerErrorMapper {
///   @override
///   Failure? onCustomError(Object data, int? statusCode) {
///     if (data is MyApiError) return ApiResponseFailure(statusCode: statusCode ?? 0, message: data.message);
///     return null;
///   }
/// }
/// ```
abstract class ServerErrorMapper {
  /// Called for [ApiError] responses before falling back to the default mapping.
  ///
  /// Return a [Failure] to override the default, or `null` to use it.
  Failure? onCustomError(Object data, int? statusCode);

  /// Converts a [DataResponse] error variant to a [Failure].
  ///
  /// Handles all sealed [DataResponse] subtypes. Catches unexpected exceptions
  /// and wraps them in [ApiExceptionFailure].
  Failure mapToFailure<T>(DataResponse<T> response) {
    try {
      return switch (response) {
        DataResponseSuccess() => ApiUnknownFailure(),
        DataResponseFailure(:final failure) => failure,
        UndefinedError(:final errorObject, :final statusCode) =>
            ApiUndefinedFailure(
              statusCode: statusCode,
              message: errorObject.toString(),
            ),
        ApiError(:final error, :final statusCode) =>
        onCustomError(error, statusCode) ??
            ApiResponseFailure(
              statusCode: statusCode ?? 0,
              message: error.toString(),
            ),
        NoInternetConnection() => ConnectionFailure(),
        Unauthorized() => ApiUnauthorizedFailure(),
        TooManyRequests() => ApiTooManyRequestsFailure(),
        CanceledRequest() => const CanceledRequestFailure(),
      };
    } catch (e, trace) {
      if (kDebugMode) {
        debugPrint('ServerErrorMapper::mapToFailure — $e');
        debugPrint(trace.toString());
      }
      return ApiExceptionFailure(message: e.toString());
    }
  }
}
