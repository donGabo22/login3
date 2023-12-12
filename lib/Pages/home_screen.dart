import 'package:flutter/material.dart';
import 'package:login3/recipe_list_page.dart';
import 'package:login3/services/auth_services.dart';
import 'package:login3/services/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

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
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text('Page 1: Aquí debería abrir la página principal con un cardsweeper y una receta del día'),
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
}
