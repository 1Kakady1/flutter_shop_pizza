import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/redux/state/user/user.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/menu/menu.dart';
import 'package:redux/redux.dart';

class DrawerMenuConatainer extends StatelessWidget {
  const DrawerMenuConatainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, _ViewDrewerMenu>(
            converter: (store) => _ViewDrewerMenu.fromStore(store),
            builder: (context, vm) {
              return DrawerMenu(
                isAuth: vm.isAuth,
                user: vm.user,
              );
            }));
  }
}

class _ViewDrewerMenu {
  final bool isAuth;
  final UserCustom user;

  _ViewDrewerMenu({
    required this.isAuth,
    required this.user,
  });

  bool operator ==(other) {
    return (other is _ViewDrewerMenu) &&
        (this.isAuth == other.isAuth) &&
        (this.user == other.user);
  }

  @override
  int get hashCode {
    return isAuth.hashCode + user.hashCode;
  }

  static _ViewDrewerMenu fromStore(Store<AppState> store) {
    return _ViewDrewerMenu(
      isAuth: UserSelectors.isAuth(store.state),
      user: UserSelectors.user(store.state),
    );
  }
}
