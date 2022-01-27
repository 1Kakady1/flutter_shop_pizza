import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pizza_time/helpers/media_query.dart';
import 'package:pizza_time/helpers/product.utils.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/routes/routes.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/card/card_history_item/card_history_item.media.dart';

typedef Press = void Function();

class CardHistoryItem extends StatefulWidget {
  final CartItem product;

  CardHistoryItem({Key? key, required this.product}) : super(key: key);

  @override
  _CardCartItemState createState() => _CardCartItemState();
}

class _CardCartItemState extends State<CardHistoryItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.product.comments ?? "";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? size = widget.product.productSize;
    final double price = getPrice(
        price: widget.product.price,
        filtersSize: widget.product.filter?.size,
        size: size);
    final double mediaWidth =
        MediaQuery.of(context).size.width >= 600 ? 600 : 0;
    final styles = getMediaQueryStyles(MediaQuery.of(context).size.width,
        MediaSizeEnum.sm, CardHistoryItemMedia.mapMedia);
    final TextStyle titileStyle = TextStyle(
        fontSize: styles!["title_font_size"], fontWeight: FontWeight.bold);
    final String sizeTitle = widget.product.isUnit == true
        ? "${(int.parse(widget.product.productSize) / 1000).toString()}"
        : widget.product.productSize.toUpperCase();

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PathRoute.product,
            arguments: {"id": widget.product.id, "product": null});
      },
      child: Container(
        height: styles["container_height"],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(children: [
                      Image.network(
                        widget.product.preview ?? "",
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
                Container(
                  height: styles["size_img"],
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
                                width: styles["title_width"],
                                height: 40,
                                child: mediaWidth < 600
                                    ? Marquee(
                                        accelerationCurve: Curves.easeInCirc,
                                        blankSpace: 60.0,
                                        pauseAfterRound: Duration(seconds: 6),
                                        text: widget.product.title,
                                        style: titileStyle,
                                      )
                                    : Text(
                                        widget.product.title,
                                        style: titileStyle,
                                      )),
                            Container(
                              width: styles["title_width"],
                              child: Center(
                                child: Text(widget.product.count.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: styles["price"]["contianer"]["width"],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Comments',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
