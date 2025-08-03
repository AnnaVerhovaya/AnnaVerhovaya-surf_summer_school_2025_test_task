import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

/// Вспомогательный класс для работы с БД
/// - Создание/обновление БД
/// - Управление соединениями
/// - Отладочные функции
class DatabaseHelper {
  static const String _databaseName = 'places_database.db';
  static const int _databaseVersion = 2;

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;
  String get databaseName => _databaseName;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createPlacesTable(db);
    await _createSearchHistoryTable(db);
  }

  Future<void> _createPlacesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS places (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        lat REAL,
        lng REAL,
        description TEXT,
        urls TEXT,
        type TEXT,
        created_at INTEGER DEFAULT (strftime('%s', 'now')),
        updated_at INTEGER
      )
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_places_name ON places(name)
    ''');
  }

  Future<void> _createSearchHistoryTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS search_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        query TEXT NOT NULL,
        timestamp INTEGER DEFAULT (strftime('%s', 'now'))
      )
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_search_history_query ON search_history(query)
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_search_history_timestamp ON search_history(timestamp)
    ''');
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> resetDatabase() async {
    await close();
    final path = join(await getDatabasesPath(), _databaseName);
    await deleteDatabase(path);
    _database = await _initDatabase();
  }

  Future<void> debugPrintTables() async {
    final db = await database;
    final tables = await db.rawQuery('''
      SELECT name FROM sqlite_master 
      WHERE type='table' 
      AND name NOT LIKE 'sqlite_%'
    ''');

    for (final table in tables) {
      final tableName = table['name'] as String;
      print('Name ------->: $tableName');

      final columns = await db.rawQuery('table_info($tableName)');
      for (final column in columns) {
        print('  ${column['name']}: ${column['type']}');
      }

      final data = await db.query(tableName, limit: 3);
      print('Data ------->: $data');
    }
  }
}
