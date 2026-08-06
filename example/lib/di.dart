import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';
import 'package:example/base_api_client_example/data/log_interceptor.dart';
import 'package:example/base_api_client_example/data/repository/user_repository_impl.dart';
import 'package:example/base_api_client_example/data/source/user_source.dart';
import 'package:example/base_api_client_example/data/source/user_source_impl.dart';
import 'package:example/base_api_client_example/domain/repository/user_repository.dart';
import 'package:example/base_api_client_example/presentation/cubit/user_cubit.dart';
import 'package:example/base_api_client_example/util/custom_error_parser.dart';
import 'package:example/base_bloc_example/bloc/base_bloc_example_screen_bloc.dart';
import 'package:example/base_cubit_example/cubit/base_cubit_example_screen_cubit.dart';
import 'package:example/my_account/data/repository/user_profile_repository_impl.dart';
import 'package:example/my_account/domain/repository/user_profile_repository.dart';
import 'package:example/my_account/domain/use_case/change_password_use_case.dart';
import 'package:example/my_account/domain/use_case/get_user_profile_use_case.dart';
import 'package:example/my_account/domain/use_case/logout_use_case.dart';
import 'package:example/my_account/domain/use_case/update_user_profile_use_case.dart';
import 'package:example/my_account/presentation/bloc/my_account_bloc.dart';
import 'package:get_it/get_it.dart';

/// Wires every demo in this app.
///
/// Worth noting after the merge: the networking registrations and the state
/// management registrations below came from two separate example apps, one per
/// package. They now sit in one `initializeDi` and pull every type they need
/// from a single import.
void initializeDi(GetIt getIt) {
  _registerNetworking(getIt);
  _registerBaseExamples(getIt);
  _registerMyAccount(getIt);
}

// ─── Networking — the core layer ─────────────────────────────────────────────
void _registerNetworking(GetIt getIt) {
  final dioClientModule = _DioClientModule();

  getIt.registerLazySingleton<ApiClient>(
    () => dioClientModule.makeApiClient(
      ApiClientParams(
        baseUrl: 'https://jsonplaceholder.typicode.com/',
        defaultConnectTimeout: 5000,
        defaultReceiveTimeout: 5000,
        interceptors: [LogInterceptor()],
        headers: {},
      ),
    ),
    instanceName: 'apiInstanceName',
  );

  getIt.registerLazySingleton<RequestProcessor>(
    () => dioClientModule.createInternalDioRequestProcessor(
      customErrorParser: CustomErrorParser.parse,
    ),
  );

  getIt.registerLazySingleton<UserSource>(
    () => UserSourceImpl(
      getIt<ApiClient>(instanceName: 'apiInstanceName'),
      getIt<RequestProcessor>(),
    ),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserSource>()),
  );

  // registerFactory so every BlocProvider gets a fresh Cubit instance.
  getIt.registerFactory<UserCubit>(
    () => UserCubit(getIt<UserRepository>()),
  );
}

// ─── BaseBloc / BaseCubit demos — the bloc layer ─────────────────────────────
void _registerBaseExamples(GetIt getIt) {
  getIt.registerFactory<BaseBlocExampleScreenBloc>(
    BaseBlocExampleScreenBloc.new,
  );
  getIt.registerFactory<BaseCubitExampleScreenCubit>(
    BaseCubitExampleScreenCubit.new,
  );
}

// ─── My Account — all three layers working together ──────────────────────────
void _registerMyAccount(GetIt getIt) {
  getIt.registerLazySingleton<UserProfileRepository>(
    UserProfileRepositoryImpl.new,
  );

  getIt.registerLazySingleton(
    () => GetUserProfileUseCase(getIt<UserProfileRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateUserProfileUseCase(getIt<UserProfileRepository>()),
  );
  getIt.registerLazySingleton(
    () => ChangePasswordUseCase(getIt<UserProfileRepository>()),
  );
  getIt.registerLazySingleton(
    () => LogoutUseCase(getIt<UserProfileRepository>()),
  );

  getIt.registerFactory<MyAccountBloc>(
    () => MyAccountBloc(
      getProfile: getIt<GetUserProfileUseCase>(),
      updateProfile: getIt<UpdateUserProfileUseCase>(),
      changePassword: getIt<ChangePasswordUseCase>(),
      logout: getIt<LogoutUseCase>(),
    ),
  );
}

class _DioClientModule extends DioClientModule {}
