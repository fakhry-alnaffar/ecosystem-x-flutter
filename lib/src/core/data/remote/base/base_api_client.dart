import 'package:ecosystem_x_flutter/src/core/data/remote/base/cache_interceptor.dart';

/// Base contract for HTTP API clients.
///
/// Provides common header constants and lifecycle methods for attaching and
/// detaching interceptors. The concrete [ApiClient] implements this against Dio,
/// but any HTTP client can be wrapped by extending this class.
abstract class BaseApiClient<T> {
  /// Standard `Authorization` header name.
  static const String kAuthHeader = 'Authorization';

  /// Bearer token prefix used in the `Authorization` header.
  static const String kAuthPrefix = 'Bearer ';

  /// Standard `Accept` header name.
  static const String kAcceptHeader = 'Accept';

  /// Standard `Content-Type` header name.
  static const String kContentTypeHeader = 'Content-Type';

  /// JSON MIME type string.
  static const String kJsonPrefix = 'application/json';

  /// Multipart form-data MIME type string.
  static const String kMultipartPrefix = 'multipart/form-data';

  /// JPEG image MIME type string.
  static const String kMediaJPEG = 'image/jpeg';

  /// PNG image MIME type string.
  static const String kMediaPNG = 'image/png';

  /// The underlying HTTP client instance (e.g. a [Dio] object).
  late T client;

  /// Attaches all registered interceptors to [client].
  Future<void> attachInterceptors();

  /// Attaches a [CacheInterceptor] and activates response caching.
  Future<void> attachCacheInterceptor(CacheInterceptor cacheInterceptor);

  /// Removes all interceptors from [client] and clears cached data.
  Future<void> detachInterceptors();

  /// Attaches a pretty-print logger interceptor in debug builds.
  void attachLoggerInterceptor();
}
