import 'package:example/base_api_client_example/core/mapper/dio_server_error_mapper.dart';
import 'package:example/base_api_client_example/data/mapper/user_mapper.dart';
import 'package:example/base_api_client_example/data/source/user_source.dart';
import 'package:example/base_api_client_example/domain/entity/user_entity.dart';
import 'package:example/base_api_client_example/domain/repository/user_repository.dart';
import 'package:example/base_api_client_example/domain/result.dart';
import 'package:ecosystem_x_flutter/x_flutter_core_models.dart';

class UserRepositoryImpl implements UserRepository {
  final UserSource _userSource;

  const UserRepositoryImpl(this._userSource);

  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    try {
      final response = await _userSource.getUsers();
      if (response.isSuccess()) {
        final users = response.data.users
            .map((model) => model.toEntity())
            .toList();
        return Result.ok(users);
      }
      return Result.error(
        failure: DioServerErrorMapper().mapToFailure(response),
      );
    } catch (e) {
      return Result.error(failure: const ApiUnknownFailure());
    }
  }
}
