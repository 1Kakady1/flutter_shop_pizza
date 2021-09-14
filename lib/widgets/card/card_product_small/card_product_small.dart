import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:pizza_time/helpers/product.utils.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/bookmark/bookmark.dart';
import "dart:math" show pi;

class CardProductSmall extends StatelessWidget {
  final Product product;
  CardProductSmall({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? size = product.filter?.size?[0];
    final List<String?>? sizes = product.filter?.size;
    final double price = getPrice(
        price: product.price, filtersSize: product.filter?.size, size: size);
    final String unit =
        product.isUnit == true && size != null ? "($size ${product.unit})" : "";
    final List<String> categorys = product.cat;
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  product.preview,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      "assets/img/no-img.png",
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    );
                  },
                )),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 110,
                          height: 40,
                          child: Marquee(
                            accelerationCurve: Curves.easeInCirc,
                            blankSpace: 60.0,
                            pauseAfterRound: Duration(seconds: 6),
                            text: product.title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.clipboardList,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ..._printCategory(categorys, 3)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.rulerCombined,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          ..._printSizes(sizes, 3)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 80,
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "\$ $price",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.red[200],
                                  fontSize: 20),
                        ),
                        Text(
                          "$unit",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        new Positioned.fill(
            child: new Material(
                color: Colors.transparent,
                child: new InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () => null,
                ))),
        product.isTop == true
            ? Positioned(
                right: 26,
                top: -10,
                child: Bookmark(
                  text: "TOP",
                  top: 18,
                  width: 40,
                  heigt: 60,
                  fontSize: 10,
                ))
            : SizedBox()
      ]),
    );
  }
}

List<Widget> _printSizes(List<String?>? size, int count) {
  final List<Widget> sizeList = [];
  if (size != null) {
    for (int i = 0; i < size.length; i++) {
      if (i == count && count != size.length) {
        sizeList.add(const Text(
          "...",
          style: TextStyle(fontWeight: FontWeight.w600),
        ));
        break;
      }
      sizeList.add(Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
          size[i]!,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ));
    }
  }

  return sizeList;
}

List<Widget> _printCategory(List<String> category, int count) {
  final List<Widget> catList = [];
  for (int i = 0; i < category.length; i++) {
    if (i == count && count != category.length) {
      catList.add(const Text(
        "...",
        style: TextStyle(fontWeight: FontWeight.w600),
      ));
      break;
    }
    catList.add(Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        category[i],
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ));
  }
  return catList;
}
