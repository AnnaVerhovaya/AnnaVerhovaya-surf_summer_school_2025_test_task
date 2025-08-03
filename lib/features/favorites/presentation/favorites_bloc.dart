import 'package:bloc/bloc.dart';
import '../../places/domain/domain.dart';
part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final PlaceRepository _placeRepository;

  FavoritesBloc(this._placeRepository) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<AddedFavorites>(_onAddedFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      emit(FavoritesLoading());
      final favorites = await _placeRepository.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e, stackTrace) {}
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {}

  Future<void> _onAddedFavorites(
    AddedFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _placeRepository.addToFavorites(event.place);
    } catch (e, stackTrace) {
      addError(e, stackTrace);
    }
  }
}
