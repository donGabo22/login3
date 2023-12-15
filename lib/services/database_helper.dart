import 'package:login3/models/favorite_meal_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorite_meals_v2.db'); // Cambia el nombre de la base de datos
    return await openDatabase(
      path,
      version: 1, // Cambia la versión de vuelta a 1
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS favorite_meals (
        id TEXT PRIMARY KEY,
        title TEXT,
        thumbnailUrl TEXT
      )
    ''');
  }

  Future<bool> insertFavoriteMeal(String id, String title, String thumbnailUrl) async {
    final Database db = await database;
    try {
      await db.insert(
        'favorite_meals',
        {
          'id': id,
          'title': title,
          'thumbnailUrl': thumbnailUrl,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Inserted favorite meal with id: $id, title: $title, thumbnailUrl: $thumbnailUrl');
      return true;
    } catch (e) {
      print('Error inserting favorite meal: $e');
      return false;
    }
  }

  Future<List<FavoriteMealModel>> getFavoriteMeals() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorite_meals');
    return List.generate(maps.length, (i) {
      final String id = maps[i]['id'].toString();
      final String title = maps[i]['title'].toString();
      final String thumbnailUrl = maps[i]['thumbnailUrl'].toString();
      print('Type of ID in database: ${id.runtimeType}');
      print('Type of title in database: ${title.runtimeType}');
      print('Type of thumbnailUrl in database: ${thumbnailUrl.runtimeType}');
      print('Type of thumbnailUrl in database: ${thumbnailUrl.toString()}');

      return FavoriteMealModel(
        id: id,
        title: title,
        thumbnailUrl: thumbnailUrl,
      );
    });
  }

  Future<bool> deleteFavoriteMeal(String id) async {
    final Database db = await database;
    try {
      await db.delete('favorite_meals', where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (e) {
      print('Error deleting favorite meal: $e');
      return false;
    }
  }

Future<Map<String, dynamic>> getMealDetailsEnFavoritos(String mealId) async {
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'favorite_meals',
    where: 'id = ?',
    whereArgs: [mealId],
  );

  if (maps.isNotEmpty) {
    final Map<String, dynamic> mealDetails = {
      'meals': [
        {
          'idMeal': maps[0]['id'],
          'strMeal': maps[0]['title'],
          'strImageSource': maps[0]['thumbnailUrl'],
          // ... otras propiedades ...
        }
      ]
    };
    return mealDetails;
  } else {
    return {}; // o cualquier valor predeterminado que desees para indicar que no se encontraron detalles
  }
}

}
