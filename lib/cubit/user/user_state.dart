part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState(this.user, this.index);
  final UserModel? user;
  final int index;

  @override
  List<Object?> get props => [user, index];

  UserState copyWith({
    UserModel? user,
    int? index,
  }) {
    return UserState(
      user ?? this.user,
      index ?? this.index,
    );
  }
}
