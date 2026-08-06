import 'package:example/base_api_client_example/domain/entity/user_entity.dart';
import 'package:example/base_api_client_example/domain/result.dart';

abstract interface class UserRepository {
  Future<Result<List<UserEntity>>> getUsers();
}
