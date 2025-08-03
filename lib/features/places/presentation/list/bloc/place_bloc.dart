import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository _placeRepository;
  List<PlaceEntity>? _cachedPlaces;

  PlaceBloc(this._placeRepository) : super(PlaceInitial()) {
    on<LoadPlaces>(_onLoadPlaces);
    on<SearchPlaces>(_onSearchPlaces);
  }

  Future<void> _onLoadPlaces(
    LoadPlaces event,
    Emitter<PlaceState> emit,
  ) async {
    try {
      emit(PlaceLoading());
      final places = await _placeRepository.getPlaces();
      if (places.isEmpty) {
        emit(PlaceEmpty());
      } else {
        emit(PlaceLoaded(places));
      }
    } catch (e, stackTrace) {
      emit(PlaceError('Не удалось загрузить места: $e'));
      addError(e, stackTrace);
    }
  }

  Future<void> _onSearchPlaces(
    SearchPlaces event,
    Emitter<PlaceState> emit,
  ) async {
    try {
      emit(PlaceLoading());
      final places = await _placeRepository.searchPlaces(
        event.query,
        limit: event.limit,
      );

      if (places.isEmpty) {
        emit(PlaceEmpty());
      } else {
        emit(PlaceLoaded(places));
      }
    } catch (e, stackTrace) {
      emit(PlaceError('Не удалось загрузить места: $e'));
      addError(e, stackTrace);
    }
  }
}
