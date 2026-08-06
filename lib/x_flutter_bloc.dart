/// Bloc layer — production-ready state management framework for Flutter.
///
/// This is a *layer* entry point. It exposes exactly what the standalone
/// `x_flutter_bloc` package exposed before the three packages were merged into
/// `ecosystem_x_flutter` — including the full core and models re-exports — so
/// an import of this library is a drop-in replacement for
/// `package:x_flutter_bloc/x_flutter_bloc.dart`.
///
/// **From the core and models layers (re-exported):**
/// - [DataResponse] — sealed transport result (7 variants)
/// - [Failure], [ApiFailure] subtypes — domain failure hierarchy
/// - [BaseProgressState], [DefaultProgressState] — loading state
/// - [ServerErrorMapper], [RequestProcessor], [ApiClient], storage, etc.
///
/// **From the bloc layer:**
/// - [BaseBloc] / [BaseCubit] — base state manager classes
/// - [BaseBlocState] / [BaseCubitState] — stateful widget integration
/// - [BaseStatelessScreen] — declarative screen template
/// - [OperationOrchestrator] — automatic progress + failure handling
/// - [SingleResultMixin] — one-time events (navigation, toasts)
/// - [StreamListener] — reactive stream-to-widget bridge
/// - [AppBlocObserver] — debug logging BlocObserver
///
/// This library is identical in surface to
/// `package:ecosystem_x_flutter/ecosystem_x_flutter.dart`; the latter is the
/// preferred import for new code.
library;

// Re-export the full core layer (which itself re-exports the models layer)
// so consumers need only this one import.
export 'x_flutter_core.dart';

// BLoC & Cubit
export 'src/bloc/base_bloc/base_bloc.dart' show BaseBloc;
export 'src/bloc/base_bloc/base_bloc_state.dart' show BaseBlocState;
export 'src/bloc/base_cubit/base_cubit.dart' show BaseCubit;
export 'src/bloc/base_cubit/base_cubit_state.dart' show BaseCubitState;

// Screens
export 'src/bloc/ui/base_stateless_screen.dart';

// Mixins
export 'src/bloc/mixins/single_result_mixin.dart' show SingleResultMixin, SrBlocObserver;
export 'src/bloc/mixins/progress_stream_mixin.dart' show ProgressStreamMixin;
export 'src/bloc/mixins/failure_stream_mixin.dart' show FailureStreamMixin;
export 'src/bloc/mixins/operation_orchestrator.dart' show OperationOrchestrator;
export 'src/bloc/mixins/base_ui_state_mixin.dart' show BaseUiStateMixin;

// Widgets
export 'src/bloc/stream_listener.dart';

// Utils
export 'src/bloc/app_bloc_observer.dart';
export 'src/bloc/bloc_typedefs.dart';
