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
    String path = join(await getDatabasesPath(), 'favorite_meals.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorite_meals (
        id TEXT PRIMARY KEY
      )
    ''');
  }

  Future<bool> insertFavoriteMeal(String id) async {
    final Database db = await database;
    try {
      await db.insert(
        'favorite_meals',
        {'id': id},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Inserted favorite meal with id: $id');
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
    print('Type of ID in database: ${id.runtimeType}');
    return FavoriteMealModel.fromMap({
      'id': id,
    });
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

  Future<Map<String, dynamic>> getMealDetailsEnFavoritos(String id) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      print('Failed to load meal details. Status Code: ${response.statusCode}');
      print('Error body: ${response.body}');
      throw Exception('Failed to load meal details');
    }
  }
}
