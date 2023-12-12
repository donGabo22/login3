import 'package:flutter/material.dart';
import 'package:login3/models/meal.dart';
import 'package:login3/recipe_detail_screen.dart';
import 'package:login3/recipe_list_page.dart';
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
  Meal _mealOfTheDay = Meal(
    id: '52772', // El ID de la comida del día
    title: 'Meal of the Day', // Un valor ficticio para el título
    category: 'Main Course', // Un valor ficticio para la categoría
    area: 'International', // Un valor ficticio para el área
    instructions: 'Follow the instructions on the recipe.', // Un valor ficticio para las instrucciones
    thumbnail: 'https://www.themealdb.com/images/media/meals/wvqpwt1511727313.jpg', // URL de la imagen de la comida del día
    ingredients: ['Ingredient 1', 'Ingredient 2'], // Una lista ficticia de ingredientes
  );
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadMealOfTheDay();
  }

  void _loadMealOfTheDay() async {
    try {
      final meal = await _mealService.getMealById(_mealOfTheDay.id);
      setState(() {
        _mealOfTheDay = meal;
      });
    } catch (e) {
      print('Error loading meal of the day: $e');
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
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.school_outlined),
            label: 'Buscar',
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return Container(
          color: Colors.orange, // Cambié el color a café
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('La comida del Día!'),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  _navigateToRecipeDetail(context, _mealOfTheDay);
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.network(_mealOfTheDay.thumbnail),
                      Text(_mealOfTheDay.title),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 1:
        return RecipeListPage(); // Aquí abre la página de lista de recetas
      case 2:
        return Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3: Aquí debería abrir un buscador y filtros'),
        );
      default:
        return Container();
    }
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
