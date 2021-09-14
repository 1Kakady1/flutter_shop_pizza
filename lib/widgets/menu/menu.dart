import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_time/routes/routes.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/user/drawer_info/drawer_info.container.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes = AppRoutes().getRouterList(false);
    final double queryDataWidth = MediaQuery.of(context).size.width;
    return Material(
      color: AppColors.black,
      child: SafeArea(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: DraverUserInfoContainer(
                      size: queryDataWidth > 600 ? 80 : 40,
                      isBorder: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ...routes.map(
                    (route) => ListTile(
                      onTap: () =>
                          Navigator.pushNamed(context, route.routePath),
                      leading: Icon(
                        route.icon,
                        size: queryDataWidth > 600 ? 40 : 24,
                      ),
                      title: Text(
                        FlutterI18n.translate(context, route.titleKey),
                        style:
                            TextStyle(fontSize: queryDataWidth > 600 ? 24 : 16),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 210,
                    margin: EdgeInsets.all(10),
                    child: TextButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.signInAlt,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                                FlutterI18n.translate(context, "login.sign_in")
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: queryDataWidth > 600 ? 18 : 12)),
                          ],
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.white)))),
                        onPressed: () => null),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
