import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
        id TEXT PRIMARY KEY,
        title TEXT,
        thumbnail TEXT
      )
    ''');
  }

  Future<bool> insertFavoriteMeal(FavoriteMealModel meal) async {
    final Database db = await database;
    try {
      await db.insert(
        'favorite_meals',
        meal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<FavoriteMealModel>> getFavoriteMeals() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorite_meals');
    return List.generate(maps.length, (i) {
      return FavoriteMealModel.fromMap(maps[i]);
    });
  }

  Future<bool> deleteFavoriteMeal(String id) async {
    final Database db = await database;
    try {
      await db.delete('favorite_meals', where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class FavoriteMealModel {
  final String id;
  final String title;
  final String thumbnail;

  FavoriteMealModel({
    required this.id,
    required this.title,
    required this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
    };
  }

  factory FavoriteMealModel.fromMap(Map<String, dynamic> map) {
    return FavoriteMealModel(
      id: map['id'],
      title: map['title'],
      thumbnail: map['thumbnail'],
    );
  }
}