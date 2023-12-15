import 'package:flutter/material.dart';
import 'package:login3/services/database_helper.dart';
import 'package:login3/models/favorite_meal_model.dart';
import 'recipe_details_screen2.dart';

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

      // Imprimimos información detallada para depuración
      print('Favorite meals loaded: $favoriteMeals');

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
      // Actualizamos la lista después de eliminar una comida de favoritos
      _loadMeals();

      // Mostramos un mensaje de éxito si es necesario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Eliminado de favoritos'),
        ),
      );
    }
  }

  void _viewFavoriteMealDetails(FavoriteMealModel favoriteMeal) async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetailScreen2(mealId: favoriteMeal.id),
        ),
      );
    } catch (e) {
      print('Error loading meal details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Imprimimos información detallada para depuración
    print('Favorite meals in build: $_favoriteMeals');

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
                  onTap: () {
                    _viewFavoriteMealDetails(favoriteMeal);
                  },
                  title: Text(favoriteMeal.title),
                  
                  subtitle: FutureBuilder<Map<String, dynamic>>(
  future: DatabaseHelper.instance.getMealDetailsEnFavoritos(favoriteMeal.id),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Icon(Icons.error); // Manejar el error de alguna manera
    } else {
      print('Data from database: ${snapshot.data}');

      // Agrega mensajes de depuración para imprimir el tipo de cada dato
      print('Type of ID in database: ${snapshot.data?['meals'][0]['idMeal']?.runtimeType}');
      print('Type of title in database: ${snapshot.data?['meals'][0]['strMeal']?.runtimeType}');
      print('Type of thumbnailUrl in database: ${snapshot.data?['meals'][0]['strImageSource']?.runtimeType}');

      String thumbnailUrl = snapshot.data?['meals'][0]['strImageSource'] ?? '';

      if (thumbnailUrl.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(thumbnailUrl, width: 50, height: 50),
            Text('Title: ${snapshot.data?['meals'][0]['strMeal'] ?? ''}'),
            // Mostrar detalles adicionales si es necesario
          ],
        );
      } else {
        // Manejar el caso en que la URL de la imagen es nula o vacía
        return Text('No hay imagen disponible todavía.');
      }
    }
  },
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
