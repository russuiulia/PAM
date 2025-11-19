class Recipe {
  final int id;
  final String name;
  final double rating;
  final String time;
  final bool isBookmarked;
  final String image;
  final String? author;
  final String? authorImage;

  Recipe({
    required this.id,
    required this.name,
    required this.rating,
    required this.time,
    required this.isBookmarked,
    required this.image,
    this.author,
    this.authorImage,
  });
}
