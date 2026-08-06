/// Models layer — pure domain contracts: failure types, server error hierarchy,
/// and progress state for domain layers.
///
/// This is a *layer* entry point. It exposes exactly what the standalone
/// `x_flutter_core_models` package exposed before the three packages were
/// merged into `ecosystem_x_flutter`, so an import of this library is a
/// drop-in replacement for `package:x_flutter_core_models/x_flutter_core_models.dart`.
///
/// - [Failure] — root marker interface for all domain failures.
/// - [ApiFailure] and subtypes — typed server/network failures.
/// - [CanceledRequestFailure] — explicit request cancellation.
/// - [ServerFailure] — enum categorising error kinds.
/// - [BaseProgressState] / [DefaultProgressState] — sealed loading state.
/// - [Mapper] / [MapperIterable] — domain converter contracts.
/// - [OperationStatus] — simple success/failed outcome enum.
///
/// Most apps should import `package:ecosystem_x_flutter/ecosystem_x_flutter.dart`
/// instead, which includes everything below.
library;

export 'src/core_models/domain/failure/failure.dart';
export 'src/core_models/domain/failure/networking/server_failure.dart';
export 'src/core_models/domain/failure/networking/api_failure.dart';
export 'src/core_models/domain/failure/networking/canceled_request_failure.dart';
export 'src/core_models/domain/progress_state/progress_state.dart';
export 'src/core_models/domain/converter/mapper.dart';
export 'src/core_models/domain/operation_status.dart';
