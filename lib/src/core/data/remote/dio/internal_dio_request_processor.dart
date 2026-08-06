// ignore_for_file: prefer_initializing_formals
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/base/processor/error_processor.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/base/processor/request_processor.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/base/connection_checker.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/connection_checker/always_have_connection.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/base/retry_policy.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/dio/internal_dio_error_processor.dart';
import 'package:ecosystem_x_flutter/src/core/domain/entity/common/data_response.dart';
import 'package:retry/retry.dart';

/// Default [RequestProcessor] implementation for Dio.
///
/// Handles connectivity gating, optional retry logic, response parsing, and
/// error mapping in a single pipeline. Use [DioClientModule.createInternalDioRequestProcessor]
/// to obtain a pre-configured instance.
class InternalDioRequestProcessor extends RequestProcessor {
  final ErrorProcessor _errorProcessor;
  final RetryPolicy? _retryPolicy;
  final ConnectionChecker _connectionChecker;
  final OnCustomError? _onCustomError;

  /// Creates an [InternalDioRequestProcessor].
  ///
  /// All parameters are optional:
  /// - [retryPolicy] — omit to disable retries.
  /// - [errorProcessor] — defaults to [InternalDioErrorProcessor].
  /// - [connectionChecker] — defaults to [AlwaysHaveConnection].
  /// - [onCustomError] — global fallback for API-level error parsing.
  InternalDioRequestProcessor({
    RetryPolicy? retryPolicy,
    ErrorProcessor? errorProcessor,
    ConnectionChecker? connectionChecker,
    OnCustomError? onCustomError,
  })  : _errorProcessor = errorProcessor ?? const InternalDioErrorProcessor(),
        _retryPolicy = retryPolicy,
        _connectionChecker = connectionChecker ?? const AlwaysHaveConnection(),
        _onCustomError = onCustomError;

  @override
  Future<DataResponse<R>> processRequest<T, R>({
    required OnRequest<T> onRequest,
    required OnParse<R> onParse,
    OnCustomError? onCustomRequestError,
    bool checkNetworkConnection = true,
  }) async {
    if (checkNetworkConnection) {
      final hasConnection = await hasInternetConnection(_connectionChecker);
      if (!hasConnection) {
        return DataResponse<R>.notConnected();
      }
    }

    try {
      final T response;
      if (_retryPolicy != null) {
        response = await retry(
          onRequest,
          maxAttempts: _retryPolicy.maxAttemptsCount,
          retryIf: (exception) => _retryPolicy.onRetry(exception: exception),
        );
      } else {
        response = await onRequest();
      }
      return DataResponse.success(onParse(response));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        return DataResponse.canceledRequest();
      }

      return _errorProcessor.processError(
        e,
        onCustomError: onCustomRequestError ?? _onCustomError,
      );
    } catch (e, trace) {
      if (kDebugMode) {
        print('InternalDioRequestProcessor::processRequest error: $e');
        print(trace);
      }

      return DataResponse.undefinedError(e);
    }
  }

  @override
  Future<bool> hasInternetConnection(ConnectionChecker connectionChecker) =>
      connectionChecker.hasConnection();
}
