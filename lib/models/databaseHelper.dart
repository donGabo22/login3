// // DatabaseHelper.dart
// import 'package:login3/models/Favorito.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static const _databaseName = 'favoritos.db';
//   static const _databaseVersion = 1;

//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final path = join(await getDatabasesPath(), _databaseName);
//     return await openDatabase(
//       path,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE favoritos(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         mealId TEXT,
//         title TEXT,
//         thumbnail TEXT
//       )
//     ''');
//   }

//   Future<int> insert(Favorito favorito) async {
//     final db = await database;
//     return await db.insert('favoritos', favorito.toMap());
//   }

//   Future<List<Favorito>> getAllFavoritos() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('favoritos');
//     return List.generate(maps.length, (i) {
//       return Favorito(
//         id: maps[i]['id'],
//         mealId: maps[i]['mealId'],
//         title: maps[i]['title'],
//         thumbnail: maps[i]['thumbnail'],
//       );
//     });
//   }
// }


// database_helper.dart
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
}
