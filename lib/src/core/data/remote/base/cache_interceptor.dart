import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// Contract for a Dio cache interceptor integration.
///
/// Implement this interface to plug a custom caching strategy into [ApiClient].
/// Pass the implementation to [ApiClient.attachCacheInterceptor].
abstract interface class CacheInterceptor {
  /// The active cache configuration, or `null` if not yet initialised.
  CacheOptions? cacheOptions;

  /// Attaches this interceptor to the Dio client and activates caching.
  Future<void> attachCacheInterceptor();

  /// Builds and returns the [CacheOptions] for this interceptor.
  Future<CacheOptions> createOptions();

  /// Returns the appropriate [CachePolicy] based on whether a refresh is forced.
  CachePolicy getCachePolicy({required bool forceRefresh});

  /// Clears all cached responses managed by this interceptor.
  Future<void> clearCache();

  /// Removes this interceptor from the Dio client.
  void detachInterceptor();

  /// Builds a custom cache key for the given [request].
  String customCacheKeyBuilder(RequestOptions request);
}
