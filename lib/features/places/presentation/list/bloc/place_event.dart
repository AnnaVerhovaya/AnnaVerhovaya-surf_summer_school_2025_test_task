part of 'place_bloc.dart';

sealed class PlaceEvent {}

class LoadPlaces extends PlaceEvent {}

class SearchPlaces extends PlaceEvent {
  SearchPlaces(this.query, this.limit);
  final String query;
  final int? limit;
}
