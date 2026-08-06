import 'package:ecosystem_x_flutter/ecosystem_x_flutter.dart';

import '../entity/update_profile_params.dart';
import '../entity/user_profile.dart';
import '../repository/user_profile_repository.dart';

final class UpdateUserProfileUseCase {
  const UpdateUserProfileUseCase(this._repository);

  final UserProfileRepository _repository;

  Future<DataResponse<UserProfile>> call(UpdateProfileParams params) =>
      _repository.updateProfile(params);
}
