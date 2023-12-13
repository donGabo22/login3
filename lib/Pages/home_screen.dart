import 'package:flutter/material.dart';
import 'package:login3/card_swiper.dart';
import 'package:login3/models/Favorito.dart';
import 'package:login3/models/database_helper.dart';
import 'package:login3/models/meal.dart';
import 'package:login3/recipe_detail_screen.dart';
import 'package:login3/recipe_list_page.dart';
import 'package:login3/favoritos_page.dart';  // Agregamos la importación de la nueva página
import 'package:login3/services/auth_services.dart';
import 'package:login3/services/meal_service.dart';
import 'package:login3/services/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MealService _mealService = MealService();
  Meal _mealOfTheDay = Meal.empty();
  List<Meal> _randomMeals = [];
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadRandomMeals();
  }

  void _loadRandomMeals() async {
    try {
      final randomMeals = await _mealService.getRandomMealsBatch(10);
      setState(() {
        _mealOfTheDay = randomMeals.isNotEmpty ? randomMeals[0] : Meal.empty();
        _randomMeals = randomMeals;
      });
    } catch (e) {
      print('Error loading random meals: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BBQ'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: _buildPage(currentPageIndex),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Página Principal',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt),
            label: 'Recetas',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outlined),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int pageIndex) {
    return Container(
      color: pageIndex == 0 ? Colors.orange : (pageIndex == 1 ? Colors.white : Colors.orange),
      child: Column(
        children: [
          if (pageIndex == 0)
            Column(
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                CardSwiper(meals: _randomMeals),
              ],
            ),
          if (pageIndex == 1)
            Expanded(
          child: RecipeListPage(),
            ),
          if (pageIndex == 2)
            Expanded(
              child: FavoritosPage(),  // Usamos la nueva página FavoritosPage
            ),
        ],
      ),
    );
  }

   void _navigateToRecipeDetail(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(meal: meal),
      ),
    ).then((value) {
      if (value != null && value is bool && value) {
        _saveToFavorites(meal);
      }
    });
  }

  void _saveToFavorites(Meal meal) async {
    try {
      Favorito favorito = Favorito(
        mealId: meal.id,
        title: meal.title,
        thumbnail: meal.thumbnail,
      );

      int result = await DatabaseHelper.instance.insert(favorito);
      if (result > 0) {
        print('Receta guardada como favorita');
      } else {
        print('Error al guardar la receta como favorita');
      }
    } catch (e) {
      print('Error al guardar la receta como favorita: $e');
    }
  }

  void _viewFavorites() async {
    List<Favorito> favoritos = await DatabaseHelper.instance.getAllFavoritos();
    // Puedes imprimir los favoritos o mostrarlos en un ListView.
    print('Favoritos: $favoritos');
  }
}
