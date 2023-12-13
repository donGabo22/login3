// // Favorito.dart
// class Favorito {
//   final int id;
//   final String mealId;
//   final String title;
//   final String thumbnail;

//   Favorito({required this.id, required this.mealId, required this.title, required this.thumbnail});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'mealId': mealId,
//       'title': title,
//       'thumbnail': thumbnail,
//     };
//   }
// }


// favorito.dart

class Favorito {
  int? id; // id de la fila en la base de datos
  late String mealId;
  late String title;
  late String thumbnail;

  Favorito({
    this.id,
    required this.mealId,
    required this.title,
    required this.thumbnail,
  }) : assert(mealId != ''); // Asegúrate de que mealId no sea nulo.

  // Función para convertir un Favorito a un mapa.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mealId': mealId,
      'title': title,
      'thumbnail': thumbnail,
    };
  }

  // Constructor que crea un Favorito desde un mapa.
  Favorito.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    mealId = map['mealId'];
    title = map['title'];
    thumbnail = map['thumbnail'];
  }
}

