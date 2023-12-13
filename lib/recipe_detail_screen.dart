import 'package:flutter/material.dart';
import 'package:login3/models/meal.dart';
import 'package:login3/services/database_helper.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Meal meal;

  RecipeDetailScreen({required this.meal});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late bool isFavorite;
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.meal.isFavorite;
    _databaseHelper = DatabaseHelper.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Platillo: " + widget.meal.title),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteFromFavorites(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    widget.meal.thumbnail,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.meal.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nacionalidad:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        Text(
                          widget.meal.area,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ingredientes:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        if (widget.meal.ingredients.isNotEmpty)
                          for (String ingredient in widget.meal.ingredients)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '• $ingredient',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Instrucciones:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          widget.meal.instructions,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite() async {
    bool success = await widget.meal.toggleFavorite();

    setState(() {
      isFavorite = widget.meal.isFavorite;
    });

    final snackBar = SnackBar(content: Text(success ? (isFavorite ? 'Añadido a favoritos' : 'Eliminado de favoritos') : 'Error al actualizar favoritos'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _deleteFromFavorites(BuildContext context) async {
    bool success = await _databaseHelper.deleteFavoriteMeal(widget.meal.id);

    final snackBar = SnackBar(content: Text(success ? 'Eliminado de favoritos' : 'Error al eliminar de favoritos'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (success) {
      Navigator.pop(context);
    }
  }
}
