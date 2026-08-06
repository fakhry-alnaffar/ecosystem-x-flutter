/// Core layer — networking, storage, and infrastructure for Flutter.
///
/// This is a *layer* entry point. It exposes exactly what the standalone
/// `x_flutter_core` package exposed before the three packages were merged into
/// `ecosystem_x_flutter` — including the full models layer re-export — so an
/// import of this library is a drop-in replacement for
/// `package:x_flutter_core/x_flutter_core.dart`.
///
/// **From the models layer (re-exported):**
/// - [Failure], [ApiFailure] and all subtypes — typed domain failures
/// - [CanceledRequestFailure], [ServerFailure] — network failure taxonomy
/// - [BaseProgressState], [DefaultProgressState] — loading state contracts
/// - [Mapper], [MapperIterable] — domain converter contracts
/// - [OperationStatus] — simple success/failed outcome enum
///
/// **From the core layer (networking + infrastructure):**
/// - [DataResponse] — sealed transport result with 7 variants
/// - [Result] — application/domain layer result type
/// - [RequestProcessor], [ErrorProcessor] — request pipeline contracts
/// - [ApiClient], [DioClientModule] — Dio HTTP client
/// - [ServerErrorMapper] — DataResponse → Failure converter
/// - [KeyValueStorage], [SharedPreferencesStorage], [SecuredPreferencesStorage]
/// - [ConnectionChecker], [HttpStatus], [RetryPolicy]
///
/// ## Quick start
/// ```dart
/// final module = _MyDioModule();
/// final client = module.makeApiClient(ApiClientParams(
///   baseUrl: 'https://api.example.com/',
///   defaultConnectTimeout: 5000,
///   defaultReceiveTimeout: 5000,
/// ));
/// final processor = module.createInternalDioRequestProcessor();
/// ```
///
/// Most apps should import `package:ecosystem_x_flutter/ecosystem_x_flutter.dart`
/// instead, which adds the bloc layer on top of everything below.
library;

// Re-export the full models layer so consumers need only one import.
export 'x_flutter_core_models.dart';

// Local storage
export 'src/core/data/local/prefs/shared_preferences_storage.dart';
export 'src/core/data/local/prefs/secured_preferences_storage.dart';
export 'src/core/data/local/base/key_value_storage.dart';
export 'src/core/data/local/base/key_value_reloadable_storage.dart';

// HTTP client
export 'src/core/data/remote/base/base_api_client.dart' show BaseApiClient;
export 'src/core/data/remote/base/http_status.dart' show HttpStatus;
export 'src/core/data/remote/base/server_error_mapper.dart' show ServerErrorMapper;
export 'src/core/data/remote/base/connection_checker.dart';
export 'src/core/data/remote/dio/api_client.dart' show ApiClient;
export 'src/core/data/remote/dio/dio_client_module.dart' show DioClientModule;

// Request pipeline
export 'src/core/data/remote/base/processor/request_processor.dart'
    show RequestProcessor, OnRequest, OnParse;
export 'src/core/data/remote/dio/internal_dio_request_processor.dart'
    show InternalDioRequestProcessor;
export 'src/core/data/remote/base/processor/error_processor.dart'
    show ErrorProcessor, OnCustomError;
export 'src/core/data/remote/dio/internal_dio_error_processor.dart'
    show InternalDioErrorProcessor;

// Connectivity
export 'src/core/data/remote/connection_checker/always_have_connection.dart'
    show AlwaysHaveConnection;
export 'src/core/data/remote/connection_checker/mobile_connection_checker.dart'
    show MobileConnectionChecker;
export 'src/core/data/remote/base/retry_policy.dart' show RetryPolicy;

// Caching
export 'src/core/data/remote/base/cache_interceptor.dart';
export 'src/core/data/remote/dio/params/api_client_params.dart' show ApiClientParams;

// DataResponse — canonical transport result type.
// Mapper and OperationStatus come from the models re-export above.
export 'src/core/domain/entity/common/data_response.dart';

// Result — application/domain layer result type (distinct from DataResponse)
export 'src/core/domain/entity/common/result.dart';

// DTO utilities
export 'src/core/data/remote/base/base_empty_response.dart' show BaseEmptyResponse;
