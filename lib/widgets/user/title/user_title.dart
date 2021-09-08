import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/redux/state/user/user.model.dart';
import 'package:pizza_time/redux/state/user/user.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/styles/colors.dart';
// import 'package:redux/redux.dart';

class UserTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final Store<AppState> store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, UserModelState>(
        converter: (store) => UserSelectors.toUser(store.state),
        builder: (context, vm) =>
            vm.isAuth == true ? Text("") : _titleAuth(vm.info, context));
  }
}

Widget _titleAuth(User info, BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.mapMarkerAlt,
          color: AppColors.red[300],
        ),
        SizedBox(
          width: 10,
        ),
        RichText(
            textDirection: TextDirection.ltr,
            text: TextSpan(
              text: info.address,
              style: TextStyle(fontSize: 20),
              children: [
                TextSpan(
                  text: "Chicago,",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 16.0),
                ),
                TextSpan(
                  text: "EN",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: 16.0),
                ),
              ],
            )),
      ],
    ),
  );
}
