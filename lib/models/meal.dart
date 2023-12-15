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

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
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
  }

  Future<bool> toggleFavorite() async {
    isFavorite = !isFavorite;
    return await DatabaseHelper.instance.insertFavoriteMeal(id,title,thumbnail);
  }

  Meal.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        title = '',
        category = '',
        area = '',
        instructions = '',
        thumbnail = '',
        ingredients = [],
        isFavorite = map['isFavorite'] ?? false;

}
  // Future<Map<String, dynamic>> getDetails() async {
  //   // Aquí puedes realizar la llamada a la API para obtener los detalles completos
  //   // Puedes usar el método existente en tu clase MealService o ajustarlo según tus necesidades
  //   // Por ejemplo:
  //   // return await MealService().getMealById(id);
  // }





// class Meal {
//   final String id;
//   final String title;
//   final String category;
//   final String area;
//   final String instructions;
//   final String thumbnail;
//   final List<String> ingredients;
//   bool isFavorite;

//   Meal({
//     required this.id,
//     required this.title,
//     required this.category,
//     required this.area,
//     required this.instructions,
//     required this.thumbnail,
//     required this.ingredients,
//     required this.isFavorite,
//   });

//   Meal.empty()
//       : id = '',
//         title = '',
//         category = '',
//         area = '',
//         instructions = '',
//         thumbnail = '',
//         ingredients = [],
//         isFavorite = false;

//   factory Meal.fromJson(Map<String, dynamic> json) => Meal(
//         id: json['idMeal'] ?? '',
//         title: json['strMeal'] ?? '',
//         category: json['strCategory'] ?? '',
//         area: json['strArea'] ?? '',
//         instructions: json['strInstructions'] ?? '',
//         thumbnail: json['strMealThumb'] ?? '',
//         ingredients: List<String>.from(List.generate(
//           20,
//           (index) => json['strIngredient${index + 1}'] ?? '',
//         ).where((ingredient) => ingredient.isNotEmpty)),
//         isFavorite: false,
//       );

//   Map<String, dynamic> toMap() {
//     return {
//       'idMeal': id,
//       'strMeal': title,
//       'strCategory': category,
//       'strArea': area,
//       'strInstructions': instructions,
//       'strMealThumb': thumbnail,
//     };
//   }

//   factory Meal.fromMap(Map<String, dynamic> map) {
//     return Meal(
//       id: map['idMeal'] ?? '',
//       title: map['strMeal'] ?? '',
//       category: map['strCategory'] ?? '',
//       area: map['strArea'] ?? '',
//       instructions: map['strInstructions'] ?? '',
//       thumbnail: map['strMealThumb'] ?? '',
//       ingredients: List<String>.from(List.generate(
//         20,
//         (index) => map['strIngredient${index + 1}'] ?? '',
//       ).where((ingredient) => ingredient.isNotEmpty)),
//       isFavorite: false,
//     );
//   }

//   Future<bool> toggleFavorite() async {
//     isFavorite = !isFavorite;
//     return await DatabaseHelper.instance.insertFavoriteMeal(
//       FavoriteMealModel(id: id, title: title, thumbnail: thumbnail),
//     );
//   }
// }
//combina esto al final
















