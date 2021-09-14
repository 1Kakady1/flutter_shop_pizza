import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/model/category.model.dart';
import 'package:pizza_time/styles/colors.dart';

typedef Press = void Function(String cat);

class AppbarSliverProduct extends StatelessWidget {
  final double? height;
  final double? separatorSize;
  final List<Category> cat;
  final int activeCat;
  final Press onPress;
  const AppbarSliverProduct(
      {Key? key,
      this.height = 34,
      this.separatorSize = 20,
      required this.cat,
      required this.activeCat,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final _controller = ScrollController();
    return Container(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
            image: NetworkImage(cat[activeCat].preview),
            fit: BoxFit.cover,
          ),
        ),
        padding: new EdgeInsets.only(top: statusBarHeight + 60),
        child: Column(
          children: [
            Container(
              height: height,
              child: Center(
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: cat.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: separatorSize),
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: activeCat == index
                              ? Theme.of(context).backgroundColor
                              : AppColors.red[200],
                          textStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          onPress(cat[index].name);
                        },
                        child: Text(cat[index].name),
                      ),
                      decoration: BoxDecoration(
                        color: activeCat == index
                            ? AppColors.red[200]
                            : Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
