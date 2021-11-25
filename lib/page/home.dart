import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pizza_time/redux/state/home/home.actions.dart';
import 'package:pizza_time/redux/state/products/products.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/appbar/appbar.dart';
import 'package:pizza_time/widgets/carusel-category/carusel-category.home.container.dart';
import 'package:pizza_time/widgets/popular/popular.container.dart';
import 'package:pizza_time/widgets/snack/snack.dart';
import 'package:pizza_time/widgets/user/title/user_title.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    final Store<AppState> store =
        StoreProvider.of<AppState>(context, listen: false);
    if (store.state.user.isLoad == true) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBar("Вы успешно вошли. Идет загрузка ваших данных..."));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffold: _scaffoldKey,
        title: UserTitle(),
        color: AppColors.background,
        elevation: 0,
        onClick: () => 0,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          store.dispatch(RequestHome(
              isLoad: true, error: "", cat: store.state.home.currentCat));
          return Future.delayed(Duration.zero);
        },
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final mediaWidth = constraints.maxWidth;
          return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(FlutterI18n.translate(context, "home_title_top"),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontSize: mediaWidth > 600 ? 50 : 30)),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          FlutterI18n.translate(context, "home_title_bottom"),
                          style: mediaWidth > 600
                              ? Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontSize: 32)
                              : Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                  CaruselCategoryHomeContainer(),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(children: [
                        PopularContainer(),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.red[200] as Color)),
                          onPressed: () {
                            store.dispatch(GotoCategoryProducts(
                                cat: store.state.category.currentCat,
                                error: "",
                                isLoad: true));
                            Navigator.pushNamed(context, "/products");
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.all(mediaWidth > 600 ? 12.0 : 0),
                            child: Text(
                              FlutterI18n.translate(context, "go_product"),
                              style: TextStyle(
                                  fontSize: mediaWidth > 600 ? 24 : 16),
                            ),
                          ),
                        ),
                      ])),
                  SizedBox(
                    height: 6,
                  ),
                ],
              ));
        }),
      ),
    );
  }
}
