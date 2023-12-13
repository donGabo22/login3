import 'package:login3/models/Favorito.dart';
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
    String path = join(await getDatabasesPath(), 'favoritos_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favoritos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mealId TEXT,
        title TEXT,
        thumbnail TEXT
      )
    ''');
  }

  Future<int> insert(Favorito favorito) async {
    Database db = await instance.database;
    return await db.insert('favoritos', favorito.toMap());
  }

  Future<List<Favorito>> getAllFavoritos() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('favoritos');

    return List.generate(maps.length, (index) {
      return Favorito.fromMap(maps[index]);
    });
  }
  // database_helper.dart
Future<int> delete(String mealId) async {
  Database db = await instance.database;
  return await db.delete('favoritos', where: 'mealId = ?', whereArgs: [mealId]);
}

}
