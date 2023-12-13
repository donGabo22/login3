// favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:login3/models/meal.dart';
import 'package:login3/services/database_helper.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<FavoriteMeal> _favoriteMeals = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteMeals();
  }

  void _loadFavoriteMeals() async {
    List<FavoriteMeal> favoriteMeals = await _databaseHelper.getFavoriteMeals();
    setState(() {
      _favoriteMeals = favoriteMeals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas Favoritas'),
        backgroundColor: Colors.brown,
      ),
      body: _favoriteMeals.isNotEmpty
          ? ListView.builder(
              itemCount: _favoriteMeals.length,
              itemBuilder: (context, index) {
                FavoriteMeal favoriteMeal = _favoriteMeals[index];
                return ListTile(
                  title: Text(favoriteMeal.title),
                  subtitle: Text('Favorito'),
                  leading: Image.network(
                    favoriteMeal.thumbnail,
                    height: 80.0,
                    width: 80.0,
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No hay recetas favoritas.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
    );
  }
}
