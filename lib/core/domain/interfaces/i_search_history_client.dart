/// Интерфейс для работы с историей поиска
abstract interface class ISearchHistoryClient {
  Future<void> saveSearchQuery(String query);
  Future<List<String>> getSearchHistory();
  Future<void> removeSearchQuery(String query);
  Future<void> clearSearchHistory();
}
