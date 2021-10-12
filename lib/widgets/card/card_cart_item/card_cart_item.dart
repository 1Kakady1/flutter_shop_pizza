import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:pizza_time/helpers/product.utils.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/card/card_product_small/card_product_small.media.dart';
import 'package:pizza_time/widgets/counter_flat/counter_flat.dart';

typedef Press = void Function();

class CardCartItem extends StatelessWidget {
  final CartItem product;
  final Press onAdd;
  final Press onSub;
  final Press onRemove;
  final Animation<double> animation;
  CardCartItem(
      {Key? key,
      required this.product,
      required this.onAdd,
      required this.onSub,
      required this.onRemove,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? size = product.productSize;
    final double price = getPrice(
        price: product.price, filtersSize: product.filter?.size, size: size);
    final double mediaWidth =
        MediaQuery.of(context).size.width >= 600 ? 600 : 0;
    final Map<int, Map<String, dynamic>> mapMedia =
        CardProductSmallMedia.mapMedia(mediaWidth);
    final TextStyle titileStyle = TextStyle(
        fontSize: mapMedia[mediaWidth]!["title_font_size"],
        fontWeight: FontWeight.bold);
    final String sizeTitle = product.isUnit == true
        ? "${(int.parse(product.productSize) / 1000).toString()}"
        : product.productSize.toUpperCase();
    return ScaleTransition(
      scale: animation,
      child: Container(
        height: mapMedia[mediaWidth]!["container_height"],
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
                  child: Stack(children: [
                    Image.network(
                      product.preview,
                      width: mapMedia[mediaWidth]!["size_img"],
                      height: mapMedia[mediaWidth]!["size_img"],
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          "assets/img/no-img.png",
                          width: mapMedia[mediaWidth]!["size_img"],
                          height: mapMedia[mediaWidth]!["size_img"],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: AppColors.red[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                          child: Center(
                              child: Text(
                            sizeTitle,
                            style: TextStyle(color: AppColors.write),
                          )),
                        ))
                  ])),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: mapMedia[mediaWidth]!["title_width"],
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
                          ConuterFlat(
                            counter: product.count,
                            onAdd: onAdd,
                            onSub: onSub,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: mapMedia[mediaWidth]!["price"]["contianer"]
                            ["width"],
                        height: mapMedia[mediaWidth]!["container_height"],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                this.onRemove();
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.times,
                                color: AppColors.red[200],
                              ),
                            ),
                            Text(
                              "\$ $price",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.red[200],
                                      fontSize: mapMedia[mediaWidth]!["price"]
                                          ["size"]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
