import 'package:get/get.dart';
import '../../domain/entities/recipe_detail_data.dart';
import '../../domain/repositories/recipe_repository.dart';

class RecipeDetailController extends GetxController {
  final RecipeRepository repository;

  RecipeDetailController({required this.repository});

  var detailData = Rxn<RecipeDetailData>();
  var isLoading = true.obs;
  var selectedTab = 'ingredients'.obs;

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      isLoading(true);
      final data = await repository.getRecipeDetails();
      detailData.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load details: $e');
    } finally {
      isLoading(false);
    }
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }
}
