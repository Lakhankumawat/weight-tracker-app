import 'dart:convert';

UserModel userModelFromJson(Map<String, dynamic>? data) =>
    UserModel.fromJson(data!);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.imageUrl,
    required this.name,
    required this.email,
  });

  final String imageUrl;
  final String name;
  final String email;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        imageUrl: json["image_url"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "name": name,
        "email": email,
      };
}
