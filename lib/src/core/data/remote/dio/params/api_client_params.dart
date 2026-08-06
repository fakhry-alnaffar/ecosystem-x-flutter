import 'package:dio/dio.dart';

/// Configuration bundle passed to [DioClientModule.makeApiClient].
class ApiClientParams {
  /// The base URL for all requests (e.g. `https://api.example.com/`).
  final String baseUrl;

  /// Additional Dio interceptors to attach after construction.
  final List<Interceptor> interceptors;

  /// Connection timeout in milliseconds. Defaults to 30 000 ms.
  final int defaultConnectTimeout;

  /// Response receive timeout in milliseconds. Defaults to 30 000 ms.
  final int defaultReceiveTimeout;

  /// Custom default headers. When `null` the client uses standard
  /// `Accept: application/json` and `Content-Type: application/json` headers.
  final Map<String, dynamic>? headers;

  /// Creates an [ApiClientParams] configuration.
  ApiClientParams({
    required this.baseUrl,
    this.interceptors = const [],
    this.defaultConnectTimeout = 30000,
    this.defaultReceiveTimeout = 30000,
    this.headers,
  });
}
