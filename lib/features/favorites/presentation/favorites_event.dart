part of 'favorites_bloc.dart';

sealed class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class AddedFavorites extends FavoritesEvent {
  final PlaceEntity place;

  AddedFavorites(this.place);
}

class RemoveFromFavorites extends FavoritesEvent {
  final PlaceEntity place;
  RemoveFromFavorites(this.place);
}
