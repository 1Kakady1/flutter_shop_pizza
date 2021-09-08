import 'package:pizza_time/model/product_filter.model.dart';

class Product {
  late String id;
  late List<String> cat;
  late String code;
  late String desc;
  late ProductFilter? filter;
  late bool? isTop;
  late bool? isUnit;
  late String name;
  late String preview;
  late String title;
  late String? unit;
  late String url;
  late List<String?>? gallary;
  late dynamic price;

  Product({
    required this.id,
    required this.cat,
    required this.code,
    required this.desc,
    required this.name,
    required this.preview,
    required this.title,
    required this.url,
    required this.price,
    this.isUnit,
    this.isTop,
    this.filter,
    this.unit,
    this.gallary,
  });
  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    price = json["price"];
    if (json["cat"] != null) {
      final v = json["cat"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      cat = arr0;
    }
    code = json["code"].toString();
    desc = json["desc"].toString();
    filter = (json["filters"] != null)
        ? ProductFilter.fromJson(json["filters"])
        : null;
    isTop = json["isTop"] ?? false;
    isUnit = json["isUnit"] ?? false;
    name = json["name"].toString();
    preview = json["preview"].toString();
    title = json["title"].toString();
    unit = json["unit"].toString();
    url = json["url"].toString();
    if (json["gallary"] != null) {
      final v = json["gallary"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      gallary = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    if (cat != null) {
      final v = cat;
      final arr0 = [];
      v.forEach((v) {
        arr0.add(v);
      });
      data["cat"] = arr0;
    }
    data["code"] = code;
    data["desc"] = desc;
    if (filter != null) {
      data["filters"] = filter!.toJson();
    }
    data["price"] = price.toJson();
    data["isTop"] = isTop;
    data["isUnit"] = isUnit;
    data["name"] = name;
    data["preview"] = preview;
    data["title"] = title;
    data["unit"] = unit;
    data["url"] = url;
    if (gallary != null) {
      final v = gallary;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data["gallary"] = arr0;
    }
    return data;
  }
}
