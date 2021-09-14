import 'package:flutter/material.dart';
import 'package:pizza_time/page/home.dart';
import 'package:pizza_time/page/products.dart';
import 'package:pizza_time/widgets/drawer/drawer.dart';

class RouteItem {
  final IconData icon;
  final Widget Function(BuildContext) route;
  final String routePath;
  final bool isPrivate;
  final String titleKey;

  RouteItem(
      {required this.icon,
      required this.route,
      required this.routePath,
      required this.isPrivate,
      required this.titleKey});
}

class AppRoutes {
  final List<RouteItem> _listRoutes = [
    RouteItem(
        titleKey: "menu.home",
        icon: Icons.home,
        isPrivate: false,
        routePath: "/",
        route: (context) => AppDrawer(
              child: HomePage(),
            )),
    RouteItem(
        titleKey: "menu.products",
        icon: Icons.home,
        isPrivate: false,
        routePath: "/products",
        route: (context) => AppDrawer(child: ProductsPage())),
  ];

  List<RouteItem> getRouterList(bool isAuth) {
    List<RouteItem> routes = [];
    this._listRoutes.forEach((element) {
      if (isAuth == true && element.isPrivate == true) {
        routes.add(element);
      }
      if (element.isPrivate != true) {
        routes.add(element);
      }
    });

    return routes;
  }

  Map<String, Widget Function(BuildContext)> getRoutersMap(bool isAuth) {
    Map<String, Widget Function(BuildContext)> routes = {};
    this._listRoutes.forEach((element) {
      if (isAuth == true && element.isPrivate == true) {
        routes[element.routePath] = element.route;
      }

      if (element.isPrivate != true) {
        routes[element.routePath] = element.route;
      }
    });

    return routes;
  }
}
