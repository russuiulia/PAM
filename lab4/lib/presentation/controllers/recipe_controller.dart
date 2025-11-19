import 'package:get/get.dart';
import '../../domain/entities/feed_data.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';

class RecipeController extends GetxController {
  final RecipeRepository repository;
  
  RecipeController({required this.repository});

  var feedData = Rxn<FeedData>();
  var selectedCategoryId = 1.obs;
  var isLoading = true.obs;

  List<Recipe> get filteredRecipes {
    if (feedData.value == null) return [];
    
    if (selectedCategoryId.value == 1) {
      return feedData.value!.recipes;
    }
    return feedData.value!.recipes;
  }

  @override
  void onInit() {
    super.onInit();
    loadFeed();
  }

  Future<void> loadFeed() async {
    try {
      isLoading(true);
      final data = await repository.getFeed();
      feedData.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load recipes: $e');
    } finally {
      isLoading(false);
    }
  }

  void changeCategory(int categoryId) {
    selectedCategoryId.value = categoryId;
  }
}
