class Category {
  late String name;
  late String preview;
  late String id;
  late String catId;

  Category(
      {required this.name,
      required this.preview,
      required this.catId,
      required this.id});
  Category.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    catId = json["cat_id"] ?? "";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["preview"] = preview;
    data["cat_id"] = catId;
    return data;
  }

  Category copyWith({name, preview, catId, id}) {
    return Category(
        name: name ?? this.name,
        preview: preview ?? this.preview,
        catId: catId ?? this.catId,
        id: id ?? this.id);
  }
}
