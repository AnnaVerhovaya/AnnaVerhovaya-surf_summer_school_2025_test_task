import '../../../../core/data/data.dart';
import '../../../../core/domain/domain.dart';

///  Класс для реализации локальной базы данных для истории поиска
/// Сохраняет запрос
/// Удаляет запрос
/// Удаляет историю
/// Получает историю
/// Работает с таблицей [search_history']
///
/// Принимает:
/// - [_databaseHelper] - вспомогательный класс для работы БД
class SearchHistoryDatabase implements ISearchHistoryClient {
  final DatabaseHelper _databaseHelper;

  SearchHistoryDatabase(this._databaseHelper);

  Future<void> addSearchHistory(String query) async {
    final db = await _databaseHelper.database;
    await db.insert('search_history', {
      'query': query,
      'timestamp': DateTime.now().millisecondsSinceEpoch ~/ 1000,
    });
  }

  Future<List<String>> getSearchHistory({int limit = 10}) async {
    final db = await _databaseHelper.database;
    final results = await db.query(
      'search_history',
      columns: ['query'],
      orderBy: 'timestamp DESC',
      limit: limit,
    );

    return results.map((row) => row['query'] as String).toList();
  }

  @override
  Future<void> removeSearchQuery(String query) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'search_history',
      where: 'query = ?',
      whereArgs: [query],
    );
  }

  @override
  Future<void> saveSearchQuery(String query) async {
    if (query.isEmpty) return;
    final db = await _databaseHelper.database;
    await db.insert(
      'search_history',
      {
        'query': query,
      },
    );
  }

  @override
  Future<void> clearSearchHistory() async {
    final db = await _databaseHelper.database;
    await db.delete('search_history');
  }
}
