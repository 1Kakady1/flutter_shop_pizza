import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/redux/state/user/user.actions.dart';
import 'package:pizza_time/redux/state/user/user.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/routes/routes.dart';
import 'package:redux/redux.dart';
import 'package:theme_provider/theme_provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RoutsAuthContianer extends StatefulWidget {
  final FlutterI18nDelegate flutterI18nDelegate;
  RoutsAuthContianer({Key? key, required this.flutterI18nDelegate})
      : super(key: key);

  @override
  _RoutsAuthContianerState createState() => _RoutsAuthContianerState();
}

class _RoutsAuthContianerState extends State<RoutsAuthContianer> {
  User? user;
  @override
  void initState() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in! ${user.email}');
        storeApp.dispatch(UserRequestAction(
            error: "", isLoad: true, email: user.email, id: user.uid));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewAuthUser>(
        converter: (store) => _ViewAuthUser.fromStore(store),
        builder: (context, vm) {
          return _App(widget.flutterI18nDelegate, vm.isAuth);
        });
  }
}

class _App extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;
  final bool isAuth;
  _App(this.flutterI18nDelegate, this.isAuth);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (themeContext) => MaterialApp(
        theme: ThemeProvider.themeOf(themeContext).data,
        localizationsDelegates: [
          flutterI18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        routes: AppRoutes().getRoutersMap(isAuth),
      ),
    );
  }
}

class _ViewAuthUser {
  final bool isAuth;

  _ViewAuthUser({
    required this.isAuth,
  });

  bool operator ==(other) {
    return (other is _ViewAuthUser) && (this.isAuth == other.isAuth);
  }

  @override
  int get hashCode {
    return isAuth.hashCode;
  }

  static _ViewAuthUser fromStore(Store<AppState> store) {
    return _ViewAuthUser(
      isAuth: UserSelectors.isAuth(store.state),
    );
  }
}
