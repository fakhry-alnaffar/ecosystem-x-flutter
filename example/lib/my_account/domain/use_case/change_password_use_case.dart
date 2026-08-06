import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';

import '../entity/change_password_params.dart';
import '../repository/user_profile_repository.dart';

final class ChangePasswordUseCase {
  const ChangePasswordUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<DataResponse<bool>> call(ChangePasswordParams params) =>
      _repository.changePassword(params);
}
