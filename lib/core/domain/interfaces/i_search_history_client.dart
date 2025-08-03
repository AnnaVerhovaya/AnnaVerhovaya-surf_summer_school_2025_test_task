/// Интерфейс для работы с историей поиска
abstract interface class ISearchHistoryClient {
  /// Сохранить запрос в историю
  Future<void> saveSearchQuery(String query);

  /// Получить историю поиска
  Future<List<String>> getSearchHistory();

  /// Удалить конкретный запрос из истории
  Future<void> removeSearchQuery(String query);

  /// Очистить всю историю поиска
  Future<void> clearSearchHistory();
}
