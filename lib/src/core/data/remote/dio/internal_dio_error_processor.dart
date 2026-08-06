import 'package:dio/dio.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/base/http_status.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/base/processor/error_processor.dart';
import 'package:ecosystem_x_flutter/src/core/domain/entity/common/data_response.dart';

/// Default [ErrorProcessor] for Dio-based requests.
///
/// Maps [DioException] types and HTTP status codes to the appropriate
/// [DataResponse] error variants:
///
/// | Condition | Result |
/// |-----------|--------|
/// | connect / send / receive timeout | [NoInternetConnection] |
/// | 401 Unauthorized | [Unauthorized] |
/// | 429 Too Many Requests | [TooManyRequests] |
/// | other 4xx/5xx with custom error handler | [ApiError] |
/// | anything else | [UndefinedError] |
class InternalDioErrorProcessor implements ErrorProcessor {
  /// Creates a const [InternalDioErrorProcessor].
  const InternalDioErrorProcessor();

  @override
  DataResponse<T> processError<T>(
    Exception e, {
    OnCustomError? onCustomError,
  }) {
    if (e is DioException) {
      final statusCode = e.response?.statusCode ?? -1;
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          statusCode == HttpStatus.networkConnectTimeoutError) {
        return DataResponse<T>.notConnected();
      }
      if (statusCode == HttpStatus.unauthorized) {
        return DataResponse<T>.unauthorized();
      }
      if (statusCode == HttpStatus.tooManyRequests) {
        return DataResponse<T>.tooManyRequests();
      }

      final errorHandler = onCustomError;

      if (errorHandler != null) {
        final apiError = errorHandler(
          statusCode,
          e.response?.data,
        );
        return DataResponse<T>.apiError(apiError, statusCode);
      }
      return DataResponse<T>.undefinedError(e, statusCode);
    }

    return DataResponse<T>.undefinedError(e, -1);
  }
}
