import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/redux/state/home/home.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/routes/routes.dart';
import 'package:pizza_time/routes/routes_auth_contaioner.dart';
import 'package:pizza_time/styles/theme.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _enablePlatformOverrideForDesktop();
  await Firebase.initializeApp();
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
        useCountryCode: false,
        fallbackFile: 'ru',
        basePath: 'assets/i18n',
        forcedLocale: Locale('ru')),
  );
  storeApp.dispatch(RequestHome(isLoad: true, error: ""));
  runApp(StoreProvider(
    child: MyApp(flutterI18nDelegate),
    store: storeApp,
  ));
}

class MyApp extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;
  MyApp(this.flutterI18nDelegate);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(
          id: "custom_light_theme",
          description: "My Custom Theme light",
          data: customThemeLight(),
        ),
        AppTheme(
          id: "custom_dark_theme",
          description: "My Custom Theme dark",
          data: ThemeData.dark().copyWith(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xff121212),
            appBarTheme: AppBarTheme(backgroundColor: const Color(0xff121212)),
          ),
        ),
      ],
      child: ThemeConsumer(
          child: RoutsAuthContianer(
        flutterI18nDelegate: flutterI18nDelegate,
      )),
    );
  }
}
