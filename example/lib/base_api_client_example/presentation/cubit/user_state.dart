part of 'user_cubit.dart';

sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();

  @override
  bool operator ==(Object other) => other is UserInitial;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class UserLoading extends UserState {
  const UserLoading();

  @override
  bool operator ==(Object other) => other is UserLoading;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class UserLoaded extends UserState {
  final List<UserEntity> users;

  UserLoaded(List<UserEntity> users) : users = List.unmodifiable(users);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLoaded && listEquals(users, other.users);

  @override
  int get hashCode => Object.hashAll(users);
}

final class UserError extends UserState {
  final Failure failure;

  const UserError(this.failure);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserError && failure == other.failure;

  @override
  int get hashCode => failure.hashCode;
}
