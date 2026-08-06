import 'package:example/base_api_client_example/domain/entity/user_entity.dart';
import 'package:example/base_api_client_example/domain/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecosystem_x_flutter/x_flutter_core_models.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserInitial());

  Future<void> loadUsers() async {
    if (state is UserLoading) return;
    emit(const UserLoading());
    final result = await _userRepository.getUsers();
    if (isClosed) return;
    emit(
      result.isOk
          ? UserLoaded(result.data!)
          : UserError(result.failure!),
    );
  }
}
