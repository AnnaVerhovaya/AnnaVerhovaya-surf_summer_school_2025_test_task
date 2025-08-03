part of 'favorites_bloc.dart';

sealed class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<PlaceEntity?> favorites;
  FavoritesLoaded(this.favorites);
}
