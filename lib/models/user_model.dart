class UserModel {
  String id;
  String name;
  String email;
  int phone;
  String password;
  bool isBlocked;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.isBlocked,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      isBlocked: json['isBlocked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'isBlocked': isBlocked,
    };
  }
}
