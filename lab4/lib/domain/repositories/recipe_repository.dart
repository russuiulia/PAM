import '../entities/feed_data.dart';
import '../entities/recipe_detail_data.dart';

abstract class RecipeRepository {
  Future<FeedData> getFeed();
  Future<RecipeDetailData> getRecipeDetails();
}
