class ProductFilter {
  List<String?>? size;

  ProductFilter({
    this.size,
  });
  ProductFilter.fromJson(Map<String, dynamic> json) {
    if (json["size"] != null) {
      final v = json["size"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      size = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (size != null) {
      final v = size;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data["size"] = arr0;
    }
    return data;
  }
}
