part of 'get_all_users_cubit.dart';

@immutable
sealed class GetAllUsersState {}

final class GetAllUsersLoading extends GetAllUsersState {}

final class GetAllUsersSuccess extends GetAllUsersState {
  final List<UserModel> users;
  GetAllUsersSuccess(this.users);
}
final class GetAllUsersError extends GetAllUsersState {
  final String message;
  GetAllUsersError(this.message);
}