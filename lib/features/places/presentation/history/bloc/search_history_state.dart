part of 'search_history_bloc.dart';

sealed class SearchHistoryState {}

class SearchHistoryInitial extends SearchHistoryState {}

class SearchHistoryLoading extends SearchHistoryState {}

class SearchHistoryLoaded extends SearchHistoryState {
  final List<String> searchHistory;

  SearchHistoryLoaded(this.searchHistory);
}

class SearchHistoryError extends SearchHistoryState {
  final String message;

  SearchHistoryError(this.message);
}
