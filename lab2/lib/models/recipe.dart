class Recipe {
  final String title;
  final String image;
  final double rating;
  final String time;
  final String author;
  final String category;
  final String location;
  final List<Map<String, String>> ingredients;

  Recipe({
    required this.title,
    required this.image,
    required this.rating,
    required this.time,
    required this.author,
    required this.location,
    required this.ingredients,
    required this.category,
  });
}
