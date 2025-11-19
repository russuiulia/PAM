import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.profileImage,
    required super.greeting,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      greeting: json['greeting'] ?? '',
    );
  }
}