import '../../domain/entities/chef.dart';

class ChefModel extends Chef {
  ChefModel({
    required super.name,
    required super.profileImage,
    required super.location,
    required super.isFollowing,
  });

  factory ChefModel.fromJson(Map<String, dynamic> json) {
    return ChefModel(
      name: json['name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      location: json['location'] ?? '',
      isFollowing: json['is_following'] ?? false,
    );
  }
}