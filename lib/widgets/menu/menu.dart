import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/user/drawer_info/drawer_info.container.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      size: 40,
                      isBorder: true,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(FlutterI18n.translate(context, "menu.home")),
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title:
                        Text(FlutterI18n.translate(context, "menu.products")),
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 120,
                    color: AppColors.red[200],
                    child: Text("test"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
