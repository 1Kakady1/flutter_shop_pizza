class UserCustom {
  late String id;
  late String name;
  late String email;
  late String address;
  late String phone;
  String? preview;
  UserCustom(
      {required this.name,
      required this.id,
      required this.email,
      required this.phone,
      required this.address,
      this.preview});

  UserCustom.fromJson(Map<String, dynamic> json) {
    id = json["userID"] ?? "";
    name = json["name"] ?? "";
    email = json["email"] ?? "";
    address = json["address"] ?? "";
    phone = json["phone"] ?? "";
    preview = json["preview"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["preview"] = preview;
    data["email"] = email;
    data["address"] = address;
    data["phone"] = phone;
    return data;
  }

  factory UserCustom.initial() =>
      UserCustom(name: "", email: "", address: "", id: "", phone: "");
  UserCustom copyWith({email, name, address, preview, id, phone}) {
    return UserCustom(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        preview: preview ?? this.preview);
  }
}
