class UserCustom {
  String id;
  String name;
  String email;
  String address;
  String? preview;
  UserCustom(
      {required this.name,
      required this.id,
      required this.email,
      required this.address,
      preview});
  factory UserCustom.initial() =>
      UserCustom(name: "", email: "", address: "", id: "");
  UserCustom copyWith({email, name, address, preview, id}) {
    return UserCustom(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        preview: preview ?? this.preview);
  }
}
