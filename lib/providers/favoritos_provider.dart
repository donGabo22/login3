import 'package:flutter/foundation.dart';
import 'package:login3/models/Favorito.dart';
import 'package:login3/models/database_helper.dart';

class FavoritosProvider extends ChangeNotifier {
  List<Favorito> _favoritos = [];

  List<Favorito> get favoritos => _favoritos;

  void setFavoritos(List<Favorito> favoritos) {
    _favoritos = favoritos;
    notifyListeners();
  }

  Future<void> toggleFavorite(String mealId) async {
    if (isFavorite(mealId)) {
      await DatabaseHelper.instance.delete(mealId);
    } else {
      // Aquí puedes agregar lógica para obtener detalles del platillo
      // y luego agregarlo a favoritos
      // Ejemplo:
       MealDetails mealDetails = await getMealDetails(mealId);
       Favorito favorito = Favorito(
         mealId: mealDetails.id,
         title: mealDetails.title,
         thumbnail: mealDetails.thumbnail,
       );
       await DatabaseHelper.instance.insert(favorito);
    }

    await _loadFavoritos(); // Actualiza la lista después de cambiar el estado de favorito
  }

  bool isFavorite(String mealId) {
    return _favoritos.any((favorito) => favorito.mealId == mealId);
  }

  Future<void> _loadFavoritos() async {
    List<Favorito> favoritos = await DatabaseHelper.instance.getAllFavoritos();
    setFavoritos(favoritos);
  }
}
