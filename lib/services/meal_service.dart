//  meal_service.dart






// meal_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login3/models/meal.dart';

class MealService {
  final String apiUrl = 'https://www.themealdb.com/api/json/v1/1/';

   Future<List<Meal>> getMealsByCategory({
    required String category,
  }) async {
    final response = await http.get(Uri.parse(apiUrl + 'filter.php?c=$category'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> meals = data['meals'];
      return meals.map((meal) => Meal.fromJson(meal)).toList();
    } else {
      print('Failed to load meals. Status Code: ${response.statusCode}');
      print('Error body: ${response.body}');
      throw Exception('Failed to load meals');
    }
  }

  Future<List<String>> getAreasList() async {
    try {
      final response = await http.get(Uri.parse(apiUrl + 'list.php?a=list'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> areas = data['meals'];
        return areas.map((area) => area['strArea'] as String).toList();
      } else {
        print('Failed to load areas list. Status Code: ${response.statusCode}');
        print('Error body: ${response.body}');
        throw Exception('Failed to load areas list');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load areas list');
    }
  }

  // Future<List<Meal>> getRandomMealsBatch(int count) async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse(apiUrl + 'random.php?limit=$count'));

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       final List<dynamic> meals = data['meals'];
  //       return meals.map((meal) => Meal.fromJson(meal)).toList();
  //     } else {
  //       print(
  //           'Failed to load random meals. Status Code: ${response.statusCode}');
  //       print('Error body: ${response.body}');
  //       throw Exception('Failed to load random meals');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception('Failed to load random meals');
  //   }
  // }
  // meal_service.dart
// ... (código existente)

  Future<List<Meal>> getAllMeals() async {
    try {
      final response = await http.get(Uri.parse(apiUrl + 'search.php?s='));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> meals = data['meals'];

        for (var meal in meals) {
          print('Meal JSON: $meal');
        }

        return meals
            .map((meal) => Meal.fromJson(meal as Map<String, dynamic>))
            .toList();
      } else {
        print('Failed to load all meals. Status Code: ${response.statusCode}');
        print('Error body: ${response.body}');
        throw Exception('Failed to load all meals');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load all meals');
    }
  }
  Future<Meal> getMealById(String mealId) async {
    try {
      final response = await http.get(Uri.parse(apiUrl + 'lookup.php?i=$mealId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> meals = data['meals'];

        if (meals.isNotEmpty) {
          return Meal.fromJson(meals[0]);
        } else {
          throw Exception('Meal not found');
        }
      } else {
        print('Failed to load meal details. Status Code: ${response.statusCode}');
        print('Error body: ${response.body}');
        throw Exception('Failed to load meal details');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load meal details');
    }
  }

  



    Future<List<Meal>> getLatestMeals() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/latest.php'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> mealsData = data['meals'];
        List<Meal> loadedMeals = [];

        for (var mealData in mealsData) {
          loadedMeals.add(Meal.fromJson(mealData));
        }

        return loadedMeals;
      } else {
        print('Error loading meals: ${response.statusCode}');
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      print('Error loading meals: $e');
      throw Exception('Failed to load meals');
    }
  }

  getRandomMealsBatch(int i) {}
}

Future<List<Meal>> _fetchMeals(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Imprimir la respuesta para depuración
    print('API Response: ${response.body}');

    // Procesar la respuesta y devolver la lista de comidas
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> mealsData = data['meals'];
    final List<Meal> meals = mealsData.map((meal) => Meal.fromJson(meal)).toList();
    
    return meals;
  } else {
    // Si la solicitud no fue exitosa, lanza una excepción
    throw Exception('Failed to load meals');
  }

  
}




  

