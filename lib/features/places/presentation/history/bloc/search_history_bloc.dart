import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/domain.dart';
part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final SearchHistoryRepository _searchHistoryRepository;

  SearchHistoryBloc(this._searchHistoryRepository)
      : super(SearchHistoryInitial()) {
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<SaveSearchQuery>(_onSaveSearchQuery);
    on<RemoveSearchHistoryItem>(_onRemoveSearchHistoryItem);
    on<ClearSearchHistory>(_onClearSearchHistory);
  }

  Future<void> _onLoadSearchHistory(
    LoadSearchHistory event,
    Emitter<SearchHistoryState> emit,
  ) async {
    try {
      emit(SearchHistoryLoading());
      final searchHistory = await _searchHistoryRepository.getSearchHistory();
      emit(SearchHistoryLoaded(searchHistory.toSet().toList()));
    } catch (e, stackTrace) {
      emit(SearchHistoryError('Не удалось загрузить историю: $e'));
      addError(e, stackTrace);
    }
  }

  Future<void> _onSaveSearchQuery(
    SaveSearchQuery event,
    Emitter<SearchHistoryState> emit,
  ) async {
    try {
      if (event.query.length > 3) {
        await _searchHistoryRepository.saveSearchQuery(event.query);
        final searchHistory = await _searchHistoryRepository.getSearchHistory();
        emit(SearchHistoryLoaded(searchHistory.toSet().toList()));
      }
    } catch (e, stackTrace) {
      emit(SearchHistoryError('Не удалось сохранить: $e'));
      addError(e, stackTrace);
    }
  }

  Future<void> _onRemoveSearchHistoryItem(
    RemoveSearchHistoryItem event,
    Emitter<SearchHistoryState> emit,
  ) async {
    try {
      await _searchHistoryRepository.removeSearchQuery(event.query);
      final searchHistory = await _searchHistoryRepository.getSearchHistory();
      emit(SearchHistoryLoaded(searchHistory.toSet().toList()));
    } catch (e, stackTrace) {
      emit(SearchHistoryError('Не удалось удалить: $e'));
      addError(e, stackTrace);
    }
  }

  Future<void> _onClearSearchHistory(
    ClearSearchHistory event,
    Emitter<SearchHistoryState> emit,
  ) async {
    try {
      await _searchHistoryRepository.clearSearchHistory();
      emit(SearchHistoryLoaded([]));
    } catch (e, stackTrace) {
      emit(SearchHistoryError('Не удалось очистить историю: $e'));
      addError(e, stackTrace);
    }
  }
}
