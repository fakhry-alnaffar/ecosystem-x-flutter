import 'dart:async';

/// Defines the retry strategy for failed HTTP requests.
///
/// Subclass this and override [onRetry] to control which exceptions and status
/// codes trigger a retry. Pass an instance to [DioClientModule.createInternalDioRequestProcessor].
abstract class RetryPolicy {
  /// Maximum number of attempts (including the original request).
  final int maxAttemptsCount;

  /// HTTP status codes that should trigger a retry.
  final List<int> retryStatusCodes;

  /// Creates a retry policy with the given [maxAttemptsCount] and
  /// [retryStatusCodes].
  RetryPolicy({
    required this.maxAttemptsCount,
    required this.retryStatusCodes,
  });

  /// Called after each failed attempt. Return `true` to retry, `false` to stop.
  FutureOr<bool> onRetry({
    required Exception exception,
  });
}
