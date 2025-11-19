import '../../domain/entities/recipe_detail.dart';

class RecipeDetailModel extends RecipeDetail {
  RecipeDetailModel({
    required int id,
    required String title,
    required String image,
    required double rating,
    required String reviews,
    required String cookTime,
    required bool isBookmarked,
  }) : super(
    id: id,
    title: title,
    image: image,
    rating: rating,
    reviews: reviews,
    cookTime: cookTime,
    isBookmarked: isBookmarked,
  );

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['reviews'] ?? '',
      cookTime: json['cook_time'] ?? '',
      isBookmarked: json['is_bookmarked'] ?? false,
    );
  }
}