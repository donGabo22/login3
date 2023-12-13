import 'package:flutter/material.dart';
import 'package:login3/services/database_helper.dart';
import 'package:login3/models/favorite_meal_model.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<FavoriteMealModel> _favoriteMeals = [];

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  void _loadMeals() async {
    try {
      List<FavoriteMealModel> favoriteMeals =
          await DatabaseHelper.instance.getFavoriteMeals();
      setState(() {
        _favoriteMeals = favoriteMeals;
      });
    } catch (e) {
      print('Error loading favorite meals: $e');
    }
  }

  void _deleteFavoriteMeal(FavoriteMealModel favoriteMeal) async {
    bool success =
        await DatabaseHelper.instance.deleteFavoriteMeal(favoriteMeal.id);
    if (success) {
      // Actualizar la lista después de eliminar de favoritos
      _loadMeals();
      // Mostrar mensaje de éxito si es necesario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Eliminado de favoritos'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: _favoriteMeals.isNotEmpty
          ? ListView.builder(
              itemCount: _favoriteMeals.length,
              itemBuilder: (context, index) {
                FavoriteMealModel favoriteMeal = _favoriteMeals[index];
                return ListTile(
                  title: Text(favoriteMeal.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${favoriteMeal.id}'),
                      FutureBuilder<Map<String, dynamic>>(
                        future: DatabaseHelper.instance.getMealDetailsEnFavoritos(favoriteMeal.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error); // Manejar el error de alguna manera
                           
                          } else {
                          // Paso 3: Imprime el mapa completo de datos recuperados
                          print('Data from database: ${snapshot.data}');
                            print('strMealThumb: ${snapshot.data?['strMealThumb']}');
                            String thumbnailUrl = snapshot.data?['strMealThumb'] ?? '';

                            if (thumbnailUrl.isNotEmpty) {
                              return Column(
                                children: [
                                  Image.network(thumbnailUrl, width: 50, height: 50),
                                  Text('Title: ${snapshot.data?['strMeal'] ?? ''}'),
                                ],
                              );
                            } else {
                              // Manejar el caso en que la URL de la imagen es nula o vacía
                              return Text('No hay imagen disponible todavia jej');
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteFavoriteMeal(favoriteMeal);
                    },
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No hay favoritos.',
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
