import 'user.dart';
import 'category.dart';
import 'recipe.dart';

class FeedData {
  final User user;
  final List<Category> categories;
  final List<Recipe> recipes;
  final List<Recipe> newRecipes;

  FeedData({
    required this.user,
    required this.categories,
    required this.recipes,
    required this.newRecipes,
  });
}