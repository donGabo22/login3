import 'package:login3/services/database_helper.dart';

class Meal {
  final String id;
  final String title;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final List<String> ingredients;
  bool isFavorite;

  Meal({
    required this.id,
    required this.title,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
    required this.isFavorite,
  });

  Meal.empty()
      : id = '',
        title = '',
        category = '',
        area = '',
        instructions = '',
        thumbnail = '',
        ingredients = [],
        isFavorite = false;

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
        isFavorite: false,
      );

  Future<bool> toggleFavorite() async {
    isFavorite = !isFavorite;
    return await DatabaseHelper.instance.insertFavoriteMeal(
      FavoriteMeal(id: id, title: title, thumbnail: thumbnail),
    );
  }
}
