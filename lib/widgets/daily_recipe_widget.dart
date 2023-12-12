// daily_recipe_widget.dart

import 'package:flutter/material.dart';
import 'package:login3/models/meal.dart';
import 'package:login3/recipe_detail_screen.dart';

class DailyRecipeWidget extends StatelessWidget {
  final Meal meal;

  DailyRecipeWidget({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Receta del día:',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        GestureDetector(
          onTap: () {
            _navigateToRecipeDetail(context, meal);
          },
          child: Card(
            child: Column(
              children: [
                Image.network(meal.thumbnail),
                Text(meal.title),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToRecipeDetail(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(meal: meal),
      ),
    );
  }
}
