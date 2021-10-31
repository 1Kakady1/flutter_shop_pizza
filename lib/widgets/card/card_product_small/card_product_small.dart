import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:pizza_time/helpers/media_query.dart';
import 'package:pizza_time/helpers/product.utils.dart';
import 'package:pizza_time/model/product.model.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/bookmark/bookmark.dart';
import 'package:pizza_time/widgets/card/card_product_small/card_product_small.media.dart';

class CardProductSmall extends StatelessWidget {
  final Product product;
  final Function onPress;
  CardProductSmall({Key? key, required this.product, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? size = product.filter?.size?[0];
    final List<String?>? sizes = product.filter?.size;
    final double price = getPrice(
        price: product.price, filtersSize: product.filter?.size, size: size);
    final String unit =
        product.isUnit == true && size != null ? "($size ${product.unit})" : "";
    final List<String> categorys = product.cat;
    print(MediaQuery.of(context).size.width);
    final double mediaWidth =
        MediaQuery.of(context).size.width >= 600 ? 600 : 0;
    final styles = getMediaQueryStyles(
        mediaWidth, MediaSizeEnum.sm, CardProductSmallMedia.mapMedia);

    final TextStyle titileStyle = TextStyle(
        fontSize: styles!["title_font_size"], fontWeight: FontWeight.bold);

    return Container(
      height: styles["container_height"],
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
                  width: styles["size_img"],
                  height: styles["size_img"],
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      "assets/img/no-img.png",
                      width: styles["size_img"],
                      height: styles["size_img"],
                      fit: BoxFit.cover,
                    );
                  },
                )),
            SizedBox(
              width: mediaWidth >= 600 ? 30 : 0,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(mediaWidth >= 600 ? 24.00 : 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: styles["title_width"],
                            height: 40,
                            child: mediaWidth < 600
                                ? Marquee(
                                    accelerationCurve: Curves.easeInCirc,
                                    blankSpace: 60.0,
                                    pauseAfterRound: Duration(seconds: 6),
                                    text: product.title,
                                    style: titileStyle,
                                  )
                                : Text(
                                    product.title,
                                    style: titileStyle,
                                  )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.clipboardList,
                              size: mediaWidth >= 600 ? 38 : 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ..._printCategory(categorys, 3, mediaWidth)
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
                              size: mediaWidth >= 600 ? 38 : 18,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            ..._printSizes(sizes, 3, mediaWidth)
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: mediaWidth >= 600 ? 20.00 : 10.0,
                    ),
                    Container(
                      width: styles["price"]["contianer"]["width"],
                      height: styles["container_height"],
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
                                    fontSize: styles["price"]["size"]),
                          ),
                          Text(
                            "$unit",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: styles["price"]["size_unit"]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        new Positioned.fill(
            child: new Material(
                color: Colors.transparent,
                child: new InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () => onPress(),
                ))),
        product.isTop == true
            ? Positioned(
                right: styles["bookmark"]["right"],
                top: -10,
                child: Bookmark(
                  text: "TOP",
                  top: styles["bookmark"]["top"],
                  width: styles["bookmark"]["width"],
                  heigt: styles["bookmark"]["height"],
                  fontSize: styles["bookmark"]["size"],
                ))
            : SizedBox()
      ]),
    );
  }
}

List<Widget> _printSizes(List<String?>? size, int count, double media) {
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
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: media >= 600 ? 30 : 12),
        ),
      ));
    }
  }

  return sizeList;
}

List<Widget> _printCategory(List<String> category, int count, double media) {
  final List<Widget> catList = [];
  for (int i = 0; i < category.length; i++) {
    if (i == count && count != category.length) {
      catList.add(const Text(
        "...",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ));
      break;
    }
    catList.add(Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        category[i],
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: media >= 600 ? 30 : 12),
      ),
    ));
  }
  return catList;
}
