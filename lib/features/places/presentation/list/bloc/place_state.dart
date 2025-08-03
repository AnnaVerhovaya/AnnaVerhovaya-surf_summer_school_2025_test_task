part of 'place_bloc.dart';

sealed class PlaceState {}

class PlaceInitial extends PlaceState {}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final List<PlaceEntity> places;

  PlaceLoaded(
    this.places,
  );

  PlaceLoaded copyWith({
    List<PlaceEntity>? places,
    List<String>? searchHistory,
  }) {
    return PlaceLoaded(
      places ?? this.places,
    );
  }
}

class PlaceEmpty extends PlaceState {}

class PlaceError extends PlaceState {
  final String message;

  PlaceError(this.message);
}
