import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';

import '../repository/user_profile_repository.dart';

final class LogoutUseCase {
  const LogoutUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<DataResponse<bool>> call() => _repository.logout();
}
