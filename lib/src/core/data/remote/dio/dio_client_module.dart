import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ecosystem_x_flutter/x_flutter_core.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/dio/internal_dio_retry_policy.dart';

/// Factory for creating pre-configured [ApiClient] and [RequestProcessor] instances.
///
/// Extend this class in your DI module to override defaults:
/// ```dart
/// class AppDioModule extends DioClientModule {}
/// ```
/// Then register it as a singleton and call [makeApiClient] and
/// [createInternalDioRequestProcessor] during app initialisation.
abstract class DioClientModule {
  /// Default number of retry attempts (including the original request).
  static const defaultMaxAttemptsCount = 2;

  /// HTTP status codes that trigger an automatic retry by default.
  static const defaultRetryStatusCodes = [
    HttpStatus.badGateway,
    HttpStatus.serviceUnavailable,
  ];

  /// Creates an [ApiClient] from [params].
  ///
  /// The client is configured with [BackgroundTransformer], a pretty logger
  /// (debug builds only), and all interceptors listed in [params].
  ApiClient makeApiClient(ApiClientParams params) => ApiClient(
        interceptors: params.interceptors,
        options: BaseOptions(
          baseUrl: params.baseUrl,
          connectTimeout: Duration(milliseconds: params.defaultConnectTimeout),
          receiveTimeout: Duration(milliseconds: params.defaultReceiveTimeout),
          headers: params.headers ??
              {
                BaseApiClient.kAcceptHeader: BaseApiClient.kJsonPrefix,
                BaseApiClient.kContentTypeHeader: BaseApiClient.kJsonPrefix,
              },
        ),
      );

  /// Creates an [InternalDioRequestProcessor] with sensible defaults.
  ///
  /// On Flutter Web [connectionChecker] is ignored (always-connected).
  RequestProcessor createInternalDioRequestProcessor({
    RetryPolicy? retryPolicy,
    ConnectionChecker? connectionChecker,
    ErrorProcessor? errorProcessor,
    OnCustomError? customErrorParser,
  }) =>
      InternalDioRequestProcessor(
        retryPolicy: retryPolicy ??
            InternalDioRetryPolicy(
              maxAttemptsCount: defaultMaxAttemptsCount,
              retryStatusCodes: defaultRetryStatusCodes,
            ),
        errorProcessor: errorProcessor,
        connectionChecker: (kIsWeb) ? null : connectionChecker,
        onCustomError: customErrorParser,
      );
}
