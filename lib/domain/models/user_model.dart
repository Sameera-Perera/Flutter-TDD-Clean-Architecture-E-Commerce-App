class UserModel {
  final String name;
  final int age;

  UserModel({required this.name, required this.age});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: json['name'], age: json['age']);
  }
}
