class User {
  int? id;
  String username;
  String password;
  String createdAt;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.createdAt,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map["id"],
    username: map["username"] ?? "",
    password: map["password"] ?? "",
    createdAt: map["created_at"] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "password": password,
    "created_at": createdAt,
  };
}
