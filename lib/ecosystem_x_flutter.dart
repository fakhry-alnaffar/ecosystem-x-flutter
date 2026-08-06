/// # ecosystem_x_flutter
///
/// The whole X Flutter ecosystem behind a single import.
///
/// ```dart
/// import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';
/// ```
///
/// This one library replaces the three packages that used to be consumed
/// separately — `x_flutter_core_models`, `x_flutter_core` and
/// `x_flutter_bloc` — with an identical public API. Every type, function,
/// mixin and typedef those packages exported is exported here under the same
/// name, so migrating is an import change and nothing else.
///
/// ## The three layers
///
/// | Layer     | Was                     | Contains                                              |
/// |-----------|-------------------------|-------------------------------------------------------|
/// | models    | `x_flutter_core_models` | pure domain contracts — [Failure], progress, [Mapper] |
/// | core      | `x_flutter_core`        | networking, storage, [DataResponse], [Result]          |
/// | bloc      | `x_flutter_bloc`        | [BaseBloc], [BaseCubit], mixins, screens              |
///
/// Layers depend strictly downwards: bloc → core → models. Nothing depends
/// upwards, which is what keeps the models layer free of Flutter and the core
/// layer free of state management.
///
/// ## Granular imports
///
/// The layer entry points remain public, so a file that only needs domain
/// contracts can say so:
///
/// ```dart
/// import 'package:ecosystem_x_flutter/x_flutter_core_models.dart'; // models only
/// import 'package:ecosystem_x_flutter/x_flutter_core.dart';        // + networking
/// import 'package:ecosystem_x_flutter/x_flutter_bloc.dart';        // + state management
/// ```
///
/// Each of those is a drop-in replacement for the same-named library in the
/// old packages, which makes a staged migration possible: swap the package
/// name first, collapse to this single import later.
///
/// ## What you get
///
/// **State management** — [BaseBloc], [BaseCubit], [BaseBlocState],
/// [BaseCubitState], [BaseStatelessScreen], [OperationOrchestrator],
/// [SingleResultMixin], [ProgressStreamMixin], [FailureStreamMixin],
/// [BaseUiStateMixin], [StreamListener], [AppBlocObserver].
///
/// **Networking** — [ApiClient], [DioClientModule], [ApiClientParams],
/// [RequestProcessor], [ErrorProcessor], [InternalDioRequestProcessor],
/// [InternalDioErrorProcessor], [ServerErrorMapper], [RetryPolicy],
/// [HttpStatus], [ConnectionChecker], [DataResponse], [Result].
///
/// **Storage** — [KeyValueStorage], [KeyValueReloadableStorage],
/// [SharedPreferencesStorage], [SecuredPreferencesStorage].
///
/// **Domain contracts** — [Failure], [ApiFailure] and subtypes,
/// [CanceledRequestFailure], [ServerFailure], [BaseProgressState],
/// [DefaultProgressState], [Mapper], [MapperIterable], [OperationStatus].
library;

// The three layers, bottom-up. Each layer already re-exports the one below it;
// listing all three is deliberate — it documents the composition at a glance
// and keeps this barrel honest if a layer ever stops re-exporting downwards.
export 'x_flutter_core_models.dart';
export 'x_flutter_core.dart';
export 'x_flutter_bloc.dart';
