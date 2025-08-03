part of 'search_history_bloc.dart';

sealed class SearchHistoryEvent {}

class LoadSearchHistory extends SearchHistoryEvent {}

class SaveSearchQuery extends SearchHistoryEvent {
  final String query;

  SaveSearchQuery(this.query);
}

class RemoveSearchHistoryItem extends SearchHistoryEvent {
  final String query;

  RemoveSearchHistoryItem(this.query);
}

class ClearSearchHistory extends SearchHistoryEvent {}
