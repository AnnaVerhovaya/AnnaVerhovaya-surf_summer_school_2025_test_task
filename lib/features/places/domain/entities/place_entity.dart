import 'package:equatable/equatable.dart';
import '../../data/models/models.dart';

class PlaceEntity extends Equatable {
  const PlaceEntity({
    required this.id,
    required this.name,
    required this.description,
    this.images,
    this.lat,
    this.lng,
    this.placeType,
    this.isFavorite,
  });

  final int id;
  final String name;
  final String description;
  final List<String>? images;
  final double? lat;
  final double? lng;
  final PlaceType? placeType;
  final bool? isFavorite;

  @override
  List<Object?> get props =>
      [id, name, description, images, lat, lng, placeType, isFavorite];

  PlaceEntity copyWith({
    int? id,
    String? name,
    String? description,
    List<String>? images,
    double? lat,
    double? lng,
    PlaceType? placeType,
    bool? isFavorite,
  }) {
    return PlaceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      placeType: placeType ?? this.placeType,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
