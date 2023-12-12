// import 'package:flutter/material.dart';
// import 'package:login3/Pages/home_screen.dart';
// import 'package:login3/favorites_page.dart';
// import 'package:login3/models/meal.dart';
// import 'package:login3/recipe_list_page.dart';

// import 'services/meal_service.dart';


// class CombinedNavigation extends StatefulWidget {
//   const CombinedNavigation({Key? key}) : super(key: key);

//   @override
//   State<CombinedNavigation> createState() => _CombinedNavigationState();
// }

// class _CombinedNavigationState extends State<CombinedNavigation> {
//   int currentPageIndex = 0;
//   MealService _mealService = MealService();
//   List<Meal> _randomMeals = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadRandomMeals();
//   }

//   void _loadRandomMeals() async {
//     try {
//       List<Meal> allMeals = await _mealService.getAllMeals();
//       setState(() {
//         _randomMeals = allMeals;
//       });
//     } catch (e) {
//       print('Error loading all meals: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentPageIndex,
//         onTap: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Página Principal',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.receipt),
//             label: 'Recetas',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border_outlined),
//             label: 'Favoritos',
//           ),
//         ],
//       ),
//       body: _buildPage(),
//     );
//   }

//   Widget _buildPage() {
//     switch (currentPageIndex) {
//       case 0:
//         return HomeScreen(randomMeals: _randomMeals);
//       case 1:
//         return RecipeListPage();
//       case 2:
//         return UnusedPage();
//       default:
//         return Container();
//     }
//   }
// }
