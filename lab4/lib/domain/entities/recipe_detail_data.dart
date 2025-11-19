import 'recipe_detail.dart';
import 'chef.dart';
import 'ingredient.dart';

class RecipeDetailData {
  final RecipeDetail recipe;
  final Chef chef;
  final String serves;
  final int totalItems;
  final List<Ingredient> ingredients;

  RecipeDetailData({
    required this.recipe,
    required this.chef,
    required this.serves,
    required this.totalItems,
    required this.ingredients,
  });
}