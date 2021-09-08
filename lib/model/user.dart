class User {
  String name;
  String email;
  String address;
  String? preview;
  User(
      {required this.name,
      required this.email,
      required this.address,
      preview});
  factory User.initial() => User(
        name: "",
        email: "",
        address: "",
      );
  User copyWith({email, name, address, preview}) {
    return User(
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        preview: preview ?? this.preview);
  }
}
