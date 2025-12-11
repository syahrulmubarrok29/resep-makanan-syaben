// Gabungan dari model Recipe kamu dan aku
class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final String videoUrl;
  final int cookingTime; // Dalam menit
  final String difficulty;
  final String category;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.videoUrl,
    required this.cookingTime,
    required this.difficulty,
    required this.category,
  });

  // Getter untuk time string (untuk kompatibilitas dengan kode kamu)
  String get time => '$cookingTime menit';

  // Factory untuk dari JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/300x200',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      steps: List<String>.from(json['steps'] ?? []),
      videoUrl: json['videoUrl'] ?? '',
      cookingTime: json['cookingTime'] ?? 0,
      difficulty: json['difficulty'] ?? 'Medium',
      category: json['category'] ?? 'Main Course',
    );
  }

  // Factory untuk dari Map (untuk kompatibilitas dengan kode kamu)
  factory Recipe.fromMap(Map<String, String> map, int index) {
    return Recipe(
      id: (index + 1).toString(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: 'https://via.placeholder.com/300x200',
      ingredients: [],
      steps: [],
      videoUrl: '',
      cookingTime: 30,
      difficulty: 'Medium',
      category: 'Main Course',
    );
  }

  // Untuk search compatibility
  bool matchesQuery(String query) {
    final lowerQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowerQuery) ||
           description.toLowerCase().contains(lowerQuery) ||
           category.toLowerCase().contains(lowerQuery);
  }
}