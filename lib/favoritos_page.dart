import 'package:flutter/material.dart';
import 'package:login3/models/Favorito.dart';
import 'package:login3/models/database_helper.dart';
import 'package:login3/providers/favoritos_provider.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  late FavoritosProvider _favoritosProvider;

  @override
  void initState() {
    super.initState();
    _favoritosProvider = Provider.of<FavoritosProvider>(context, listen: false);
    _loadFavoritos();
  }

  void _loadFavoritos() async {
    List<Favorito> favoritos = await DatabaseHelper.instance.getAllFavoritos();
    _favoritosProvider.setFavoritos(favoritos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Consumer<FavoritosProvider>(
        builder: (context, favoritosProvider, _) {
          List<Favorito> _favoritos = favoritosProvider.favoritos;
          return ListView.builder(
            itemCount: _favoritos.length,
            itemBuilder: (context, index) {
              Favorito favorito = _favoritos[index];
              return ListTile(
                title: Text(favorito.title),
                trailing: IconButton(
                  icon: Icon(
                    favoritosProvider.isFavorite(favorito.mealId)
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  onPressed: () async {
                    await _toggleFavorite(favorito);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _toggleFavorite(Favorito favorito) async {
    await DatabaseHelper.instance.delete(favorito.mealId);
    _loadFavoritos(); // Actualiza la lista después de cambiar el estado de favorito
  }
}



