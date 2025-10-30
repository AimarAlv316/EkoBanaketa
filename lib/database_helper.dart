import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'suge_jokoa.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE erabiltzaileak(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        izena TEXT UNIQUE,
        puntuak INTEGER DEFAULT 0,
        createdAt TEXT
      )
    ''');
  }

  // Erabiltzailea sortu edo eguneratu
  Future<void> saveErabiltzailea(String izena, int puntuak) async {
    final Database db = await database;

    // Egiaztatu ea erabiltzailea existitzen den
    final List<Map<String, dynamic>> maps = await db.query(
      'erabiltzaileak',
      where: 'izena = ?',
      whereArgs: [izena],
    );

    if (maps.isNotEmpty) {
      // Eguneratu existitzen den erabiltzailea
      await db.update(
        'erabiltzaileak',
        {
          'puntuak': puntuak,
        },
        where: 'izena = ?',
        whereArgs: [izena],
      );
    } else {
      // Sortu erabiltzaile berria
      await db.insert(
        'erabiltzaileak',
        {
          'izena': izena,
          'puntuak': puntuak,
          'createdAt': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Lortu erabiltzailearen puntuak
  Future<int> getPuntuak(String izena) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'erabiltzaileak',
      where: 'izena = ?',
      whereArgs: [izena],
    );

    if (maps.isNotEmpty) {
      return maps.first['puntuak'] as int;
    } else {
      return 0;
    }
  }

  // Lortu ranking-a (puntuazio altuenak)
  Future<List<Map<String, dynamic>>> getRanking() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'erabiltzaileak',
      orderBy: 'puntuak DESC',
      limit: 10,
    );

    return maps;
  }

  // Ezabatu erabiltzailea (debugging-erako)
  Future<void> deleteErabiltzailea(String izena) async {
    final Database db = await database;
    await db.delete(
      'erabiltzaileak',
      where: 'izena = ?',
      whereArgs: [izena],
    );
  }
}