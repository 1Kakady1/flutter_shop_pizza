import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/redux/state/home/home.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/appbar/appbar.dart';
import 'package:pizza_time/widgets/carusel-category/carusel-category.container.dart';
import 'package:pizza_time/widgets/popular/popular.container.dart';
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
        elevation: 0,
        onClick: () => 0,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return store.dispatch(getHome(
              limit: 3,
              where: CallectionWhere.arrayContainsIsEqualToTop,
              value: store.state.category.currentCat,
              field: "cat"));
        },
        child: SingleChildScrollView(
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
                      Text(
                        FlutterI18n.translate(context, "home_title_top"),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        FlutterI18n.translate(context, "home_title_bottom"),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                CaruselCategoryContainer(),
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
                          Navigator.pushNamed(context, "/products");
                        },
                        child:
                            Text(FlutterI18n.translate(context, "go_product")),
                      ),
                    ])),
                SizedBox(
                  height: 6,
                ),
              ],
            )),
      ),
    );
  }
}
