import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required super.id,
    required super.name,
    required super.rating,
    required super.time,
    required super.isBookmarked,
    required super.image,
    super.author,
    super.authorImage,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      time: json['time'] ?? '',
      isBookmarked: json['is_bookmarked'] ?? false,
      image: json['image'] ?? '',
      author: json['author'],
      authorImage: json['author_image'],
    );
  }
}