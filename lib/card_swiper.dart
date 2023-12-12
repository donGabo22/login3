import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:login3/models/meal.dart';
import 'package:login3/recipe_detail_screen.dart';

class CardSwiper extends StatelessWidget {
  final List<Meal> meals;

  CardSwiper({required this.meals});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _navigateToRecipeDetail(context, meals[index]);
            },
            child: Card(
              child: Column(
                children: [
                  Image.network(meals[index].thumbnail),
                  Text(meals[index].title),
                ],
              ),
            ),
          );
        },
        itemCount: meals.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
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
