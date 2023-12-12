//meal.dart
class Meal {
  final String id;
  final String title;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final List<String> ingredients;

  Meal({
    required this.id,
    required this.title,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json['idMeal'] ?? '',
        title: json['strMeal'] ?? '',
        category: json['strCategory'] ?? '',
        area: json['strArea'] ?? '',
        instructions: json['strInstructions'] ?? '',
        thumbnail: json['strMealThumb'] ?? '',
        ingredients: List<String>.from(List.generate(
          20,
          (index) => json['strIngredient${index + 1}'] ?? '',
        ).where((ingredient) => ingredient.isNotEmpty)),
      );
}


