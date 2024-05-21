class OkuurUserInfo {
  String id;
  String name;
  String surname;
  String username;
  String email;


  OkuurUserInfo({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
  });

  factory OkuurUserInfo.fromJson(Map<String, dynamic> json) {
    return OkuurUserInfo(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'username': username,
      'email': email,
    };
  }
}
