import '../../domain/entities/feed_data.dart';
import '../../domain/entities/recipe_detail_data.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_remote_datasource.dart';
import '../models/user_model.dart';
import '../models/category_model.dart';
import '../models/recipe_model.dart';
import '../models/recipe_detail_model.dart';
import '../models/chef_model.dart';
import '../models/ingredient_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;

  RecipeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<FeedData> getFeed() async {
    final jsonData = await remoteDataSource.getFeed();
    
    return FeedData(
      user: UserModel.fromJson(jsonData['user']),
      categories: (jsonData['filters']['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      recipes: (jsonData['recipes'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList(),
      newRecipes: (jsonData['new_recipes'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList(),
    );
  }

  @override
  Future<RecipeDetailData> getRecipeDetails() async {
    final jsonData = await remoteDataSource.getRecipeDetails();
    
    return RecipeDetailData(
      recipe: RecipeDetailModel.fromJson(jsonData['recipe']),
      chef: ChefModel.fromJson(jsonData['chef']),
      serves: jsonData['serving']['serves'] ?? '',
      totalItems: jsonData['serving']['total_items'] ?? 0,
      ingredients: (jsonData['ingredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
    );
  }
}
