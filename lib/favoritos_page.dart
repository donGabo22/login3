// // FavoritosPage.dart
// import 'package:flutter/material.dart';
// import 'package:login3/models/Favorito.dart';
// import 'package:login3/models/databaseHelper.dart';

// class FavoritosPage extends StatefulWidget {
//   @override
//   _FavoritosPageState createState() => _FavoritosPageState();
// }

// class _FavoritosPageState extends State<FavoritosPage> {
//   late Future<List<Favorito>> _favoritos;

//   @override
//   void initState() {
//     super.initState();
//     _favoritos = DatabaseHelper.instance.getAllFavoritos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recetas Favoritas'),
//       ),
//       body: FutureBuilder<List<Favorito>>(
//         future: _favoritos,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Text('No hay recetas favoritas guardadas.'),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(snapshot.data![index].title),
//                   subtitle: Text(snapshot.data![index].mealId),
//                   leading: Image.network(
//                     snapshot.data![index].thumbnail,
//                     width: 50.0,
//                     height: 50.0,
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// favoritos_page.dart
import 'package:flutter/material.dart';
import 'package:login3/models/Favorito.dart';
import 'package:login3/models/databaseHelper.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  List<Favorito> _favoritos = [];

  @override
  void initState() {
    super.initState();
    _loadFavoritos();
  }

  void _loadFavoritos() async {
    List<Favorito> favoritos = await DatabaseHelper.instance.getAllFavoritos();
    setState(() {
      _favoritos = favoritos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: ListView.builder(
        itemCount: _favoritos.length,
        itemBuilder: (context, index) {
          Favorito favorito = _favoritos[index];
          return ListTile(
            title: Text(favorito.title),
            // Puedes agregar más detalles según sea necesario.
          );
        },
      ),
    );
  }
}
