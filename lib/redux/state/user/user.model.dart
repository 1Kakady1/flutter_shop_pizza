import 'package:pizza_time/model/user.dart';

class UserModelState {
  User info;
  bool isAuth = false;

  UserModelState({required this.info, required this.isAuth});

  factory UserModelState.initial() =>
      UserModelState(info: User.initial(), isAuth: false);

  UserModelState copyWith({user, isAuth}) {
    return UserModelState(
      info: user ?? this.info,
      isAuth: isAuth ?? this.isAuth,
    );
  }
}