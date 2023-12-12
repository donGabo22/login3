import 'package:flutter/material.dart';
import 'package:login3/card_swiper.dart';
import 'package:login3/models/meal.dart';
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
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.school_outlined),
            label: 'Buscar',
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int pageIndex) {
    return Container(
      color: pageIndex == 0 ? Colors.orange : (pageIndex == 1 ? Colors.orange : Colors.blue),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (pageIndex == 0)
            Expanded(
              child: Column(
                children: [
                  CardSwiper(meals: _randomMeals),
                ],
              ),
            ),
          if (pageIndex == 1)
            Expanded(
              child: RecipeListPage(),
            ),
          if (pageIndex == 2)
            const Text('Page 3: Aquí debería abrir un buscador y filtros'),
        ],
      ),
    );
  }
}
