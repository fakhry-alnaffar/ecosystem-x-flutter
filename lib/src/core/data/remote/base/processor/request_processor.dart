import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/base/connection_checker.dart';
import 'package:ecosystem_x_flutter/src/core/data/remote/base/processor/error_processor.dart';
import 'package:ecosystem_x_flutter/src/core/domain/entity/common/data_response.dart';

/// A [Future]-returning function that performs the actual HTTP call.
typedef OnRequest<T> = Future<T> Function();

/// A function that converts a raw response into a typed domain object.
typedef OnParse<T> = T Function(dynamic response);

/// Base class for the request pipeline.
///
/// Subclass this to provide a custom request execution strategy. The default
/// implementation is [InternalDioRequestProcessor].
abstract class RequestProcessor {
  /// Executes a network request and returns a typed [DataResponse].
  ///
  /// - [onRequest] performs the HTTP call.
  /// - [onParse] converts the raw response body to [R].
  /// - [onCustomRequestError] overrides global error mapping for this call.
  /// - [checkNetworkConnection] gates the request on connectivity when `true`.
  Future<DataResponse<R>> processRequest<T, R>({
    required OnRequest<T> onRequest,
    required OnParse<R> onParse,
    OnCustomError? onCustomRequestError,
    bool checkNetworkConnection = true,
  });

  /// Returns `true` if the device currently has network access.
  ///
  /// Override to inject a custom connectivity check.
  @protected
  Future<bool> hasInternetConnection(
    ConnectionChecker connectionChecker,
  ) =>
      connectionChecker.hasConnection();
}
