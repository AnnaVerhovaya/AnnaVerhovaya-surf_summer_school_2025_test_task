abstract interface class SearchHistoryRepository {
  Future<void> saveSearchQuery(String query);
  Future<List<String>> getSearchHistory();
  Future<void> removeSearchQuery(String query);
  Future<void> clearSearchHistory();
}
