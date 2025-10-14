import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const RecipeApp());
}

// Model
class Recipe {
  final String title;
  final String time;
  final double rating;
  final String category;
  final String image;
  final String author;
  final String authorImage;
  final String location;
  final List<Map<String, String>> ingredients;

  Recipe({
    required this.title,
    required this.time,
    required this.rating,
    required this.category,
    required this.image,
    required this.author,
    required this.authorImage,
    required this.location,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    title: json['title'],
    time: json['time'],
    rating: json['rating'].toDouble(),
    category: json['category'],
    image: json['image'],
    author: json['author'],
    authorImage: json['authorImage'],
    location: json['location'],
    ingredients: List<Map<String, String>>.from(
      (json['ingredients'] as List).map((e) => Map<String, String>.from(e)),
    ),
  );
}

// Controller GetX
class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var selectedCategory = 'All'.obs;
  var isLoading = true.obs;

  List<Recipe> get filteredRecipes => selectedCategory.value == 'All'
      ? recipes
      : recipes.where((r) => r.category == selectedCategory.value).toList();

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    isLoading(true);
    final data = await rootBundle.loadString('assets/recipes.json');
    final jsonResult = json.decode(data) as List;
    recipes.value = jsonResult.map((e) => Recipe.fromJson(e)).toList();
    isLoading(false);
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}

// App
class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lab3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
      ),
      home: const RecipeHomePage(),
    );
  }
}

// Home Page
class RecipeHomePage extends StatelessWidget {
  const RecipeHomePage({super.key});

  final List<String> categories = const [
    'All',
    'Indian',
    'Italian',
    'Asian',
    'Chinese',
  ];

  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.put(RecipeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Hello Jega',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/avatar.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What are you cooking today?",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search recipe",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF888888),
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF10A37F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.tune, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Categories
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final cat = categories[index];
                    return Obx(() {
                      final isSelected =
                          controller.selectedCategory.value == cat;
                      return GestureDetector(
                        onTap: () => controller.changeCategory(cat),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF10A37F)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              cat,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF10A37F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: categories.length,
                ),
              ),

              const SizedBox(height: 20),

              // Featured PageView
              SizedBox(
                height: 280,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.75),
                  itemCount: controller.filteredRecipes.length,
                  itemBuilder: (_, index) {
                    final recipe = controller.filteredRecipes[index];
                    return GestureDetector(
                      onTap: () =>
                          Get.to(() => RecipeDetailScreen(recipe: recipe)),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 70,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: 250,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 6,
                                      color: Colors.grey.shade300,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  bottom: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 13),
                                    const SizedBox(height: 40),
                                    Center(
                                      child: Text(
                                        recipe.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 13),
                                    const Text(
                                      "Time",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      recipe.time,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: -4,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: ClipOval(
                                  child: Image.asset(
                                    recipe.image,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "New Recipes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.recipes.length,
                  itemBuilder: (_, index) {
                    final r = controller.recipes[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => RecipeDetailScreen(recipe: r)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 220,
                            margin: const EdgeInsets.only(right: 16, top: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                60,
                                16,
                                12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    r.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: List.generate(
                                      r.rating.toInt(),
                                      (i) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 120,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 38,
                                backgroundImage: AssetImage(r.image),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// Detail Screen
class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    var selectedTab;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(recipe.image, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: Text(
                    '(13k reviews)',
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/author_image.png"),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.author,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '📍 ${recipe.location}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10A37F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Follow",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 19.0),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: selectedTab == 'ingredients'
                          ? Colors.orange
                          : const Color(0xFF10A37F),
                      foregroundColor: selectedTab == 'ingredients'
                          ? Colors.black
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => {},
                    child: const Text('Ingredients'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 19.0),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: selectedTab == 'procedure'
                          ? Colors.orange
                          : Colors.white,
                      foregroundColor: selectedTab == 'procedure'
                          ? Colors.white
                          : const Color(0xFF10A37F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => {},
                    child: const Text('Procedure'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Text("🥣 1 serve", style: TextStyle(color: Colors.grey)),
                Spacer(),
                Text("10 Items", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 20),

            Column(
              children: List<Widget>.from(
                (recipe.ingredients).map((ing) {
                  final key = ing.keys.first;
                  final value = ing.values.first;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(21),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 244, 244),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage("assets/${key}.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              key,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(value, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
