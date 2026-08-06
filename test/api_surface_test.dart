// GENERATED-BY-HAND-ONCE, then kept under review. Do not delete.
//
// This is the contract test for the three-packages-into-one merge.
//
// Every name below was exported by the public barrel of x_flutter_core_models,
// x_flutter_core or x_flutter_bloc before those three packages became
// `ecosystem_x_flutter`. The list was extracted from those packages' own
// barrels, not from this one, so it is an independent expectation.
//
// The only import here is the single merged entry point. If any name ever stops
// being reachable through it, THIS FILE STOPS COMPILING — which is exactly the
// alarm we want, because a consumer such as the Tyrhal app would break the same
// way. Referencing each name as a type argument works uniformly for classes,
// mixins, enums, sealed types and function typedefs.
//
// ignore_for_file: unused_field

import 'package:flutter_test/flutter_test.dart';

import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';

class _PublicApiSurface {
  List<AlwaysHaveConnection>? _f1;
  List<ApiClient>? _f2;
  List<ApiClientParams>? _f3;
  List<ApiError>? _f4;
  List<ApiExceptionFailure>? _f5;
  List<ApiFailure>? _f6;
  List<ApiResponseFailure>? _f7;
  List<ApiTooManyRequestsFailure>? _f8;
  List<ApiUnauthorizedFailure>? _f9;
  List<ApiUndefinedFailure>? _f10;
  List<ApiUnknownFailure>? _f11;
  List<AppBlocObserver>? _f12;
  List<BaseApiClient>? _f13;
  List<BaseBloc>? _f14;
  List<BaseBlocState>? _f15;
  List<BaseCubit>? _f16;
  List<BaseCubitState>? _f17;
  List<BaseEmptyResponse>? _f18;
  List<BaseProgressState>? _f19;
  List<BaseStatelessScreen>? _f20;
  List<BaseUiStateMixin>? _f21;
  List<CacheInterceptor>? _f22;
  List<CanceledRequest>? _f23;
  List<CanceledRequestFailure>? _f24;
  List<ConnectionChecker>? _f25;
  List<ConnectionFailure>? _f26;
  List<DataResponse>? _f27;
  List<DataResponseFailure>? _f28;
  List<DataResponseSuccess>? _f29;
  List<DefaultProgressState>? _f30;
  List<DioClientModule>? _f31;
  List<ErrorProcessor>? _f32;
  List<Failure>? _f33;
  List<FailureStreamMixin>? _f34;
  List<FailureStreamProvider>? _f35;
  List<HttpStatus>? _f36;
  List<IBaseBloc>? _f37;
  List<InternalDioErrorProcessor>? _f38;
  List<InternalDioRequestProcessor>? _f39;
  List<KeyValueReloadableStorage>? _f40;
  List<KeyValueStorage>? _f41;
  List<ListenDelegate>? _f42;
  List<Mapper>? _f43;
  List<MapperIterable>? _f44;
  List<MobileConnectionChecker>? _f45;
  List<NoInternetConnection>? _f46;
  List<OnCustomError>? _f47;
  List<OnParse>? _f48;
  List<OnRequest>? _f49;
  List<OperationOrchestrator>? _f50;
  List<OperationStatus>? _f51;
  List<ProgressStreamMixin>? _f52;
  List<ProgressStreamProvider>? _f53;
  List<RequestProcessor>? _f54;
  List<Result>? _f55;
  List<ResultFailure>? _f56;
  List<ResultSuccess>? _f57;
  List<RetryPolicy>? _f58;
  List<SecuredPreferencesStorage>? _f59;
  List<ServerErrorMapper>? _f60;
  List<ServerFailure>? _f61;
  List<SharedPreferencesStorage>? _f62;
  List<SingleResultEmitter>? _f63;
  List<SingleResultListener>? _f64;
  List<SingleResultMixin>? _f65;
  List<SingleResultProvider>? _f66;
  List<SrBlocObserver>? _f67;
  List<StreamListener>? _f68;
  List<TooManyRequests>? _f69;
  List<Unauthorized>? _f70;
  List<UndefinedError>? _f71;
}

void main() {
  test('every pre-merge public symbol is reachable from the single import', () {
    // Reaching this line means the declarations above resolved against
    // package:ecosystem_x_flutter/ecosystem_x_flutter.dart alone.
    expect(_PublicApiSurface(), isNotNull);
  });
}
