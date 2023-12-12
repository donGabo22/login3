// recipe_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:login3/models/meal.dart';


class RecipeDetailScreen extends StatelessWidget {
  final Meal meal;

  RecipeDetailScreen({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Platillo: "+meal.title),
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      meal.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(meal.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    'Nationality:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  Text(
                    meal.area, // Suponiendo que "area" contiene la nacionalidad
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Ingredients:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  if (meal.ingredients.isNotEmpty)
                    for (String ingredient in meal.ingredients)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '• $ingredient',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                  SizedBox(height: 16.0),
                  Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    meal.instructions,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
