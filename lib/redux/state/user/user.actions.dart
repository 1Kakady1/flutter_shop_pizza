import 'package:pizza_time/model/user.dart';

class ChangeAuthAction {
  final bool isAuth;

  ChangeAuthAction(this.isAuth);
}

class SetUser {
  final UserCustom user;
  final bool isAuth;
  SetUser(this.isAuth, this.user);
}

class ChangeUserAction {
  final UserCustom user;
  ChangeUserAction(this.user);
}

class UserRequestAction {
  bool isLoad;
  String error;
  String? email;
  String id;
  UserRequestAction(
      {required this.error,
      required this.isLoad,
      required this.email,
      required this.id});
}

class UserRequestEmailAndPasswordAction {
  String? email;
  String password;
  UserRequestEmailAndPasswordAction(
      {required this.email, required this.password});
}

class UserRequestSuccessAction {
  UserCustom user;
  bool isAuth;
  bool isLoad;
  String error;

  UserRequestSuccessAction(
      {required this.user,
      required this.error,
      required this.isLoad,
      required this.isAuth});
}

class UserRequestErrorAction {
  bool isLoad;
  String error;
  UserRequestErrorAction({required this.error, required this.isLoad});
}
