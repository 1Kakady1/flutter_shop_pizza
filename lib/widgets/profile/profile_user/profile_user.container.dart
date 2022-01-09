import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/redux/state/user/user.actions.dart';
import 'package:pizza_time/redux/state/user/user.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/profile/profile_user/profile_user.dart';
import 'package:redux/redux.dart';

class ProfileUserContainer extends StatelessWidget {
  const ProfileUserContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, _ViewProfileUserInfo>(
            distinct: true,
            converter: (store) => _ViewProfileUserInfo.fromStore(store),
            builder: (context, vm) {
              return ProfileUser(
                user: vm.user,
                isAuth: vm.isAuth,
                onChangeUserInfo: vm.onChangeUserInfo,
              );
            }));
  }
}

class _ViewProfileUserInfo {
  final bool isAuth;
  final UserCustom user;
  final void Function(UserCustom user) onChangeUserInfo;
  _ViewProfileUserInfo(
      {required this.isAuth,
      required this.user,
      required this.onChangeUserInfo});
  @override
  bool operator ==(other) {
    return (other is _ViewProfileUserInfo) &&
        (this.user == other.user) &&
        (this.isAuth == other.isAuth);
  }

  @override
  int get hashCode {
    return isAuth.hashCode + user.hashCode;
  }

  static _ViewProfileUserInfo fromStore(Store<AppState> store) {
    return _ViewProfileUserInfo(
        isAuth: UserSelectors.isAuth(store.state),
        user: UserSelectors.user(store.state),
        onChangeUserInfo: (UserCustom user) =>
            store.dispatch(ChangeUserAction(user)));
  }
}
