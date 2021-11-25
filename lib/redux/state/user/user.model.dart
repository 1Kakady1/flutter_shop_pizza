import 'package:pizza_time/model/user.dart';

class UserModelState {
  UserCustom info;
  bool isAuth = false;
  bool? isLoad = false;
  String? error = "";

  UserModelState(
      {required this.info, required this.isAuth, this.error, this.isLoad});

  factory UserModelState.initial() => UserModelState(
      info: UserCustom.initial(), isAuth: false, isLoad: false, error: "");

  UserModelState copyWith({user, isAuth, error, isLoad}) {
    return UserModelState(
        info: user ?? this.info,
        isAuth: isAuth ?? this.isAuth,
        isLoad: isLoad ?? this.isLoad,
        error: error ?? this.error);
  }
}
