import '../../domain/domain.dart';
import '../datasources/datasources.dart';

/// Реализация репозитория для работы с историей поиска
class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  final SearchHistoryDatabase _searchHistoryDataSource;

  SearchHistoryRepositoryImpl(this._searchHistoryDataSource);

  @override
  Future<void> saveSearchQuery(String query) async {
    await _searchHistoryDataSource.saveSearchQuery(query);
  }

  @override
  Future<List<String>> getSearchHistory() async {
    return await _searchHistoryDataSource.getSearchHistory();
  }

  @override
  Future<void> removeSearchQuery(String query) async {
    await _searchHistoryDataSource.removeSearchQuery(query);
  }

  @override
  Future<void> clearSearchHistory() async {
    await _searchHistoryDataSource.clearSearchHistory();
  }
}
