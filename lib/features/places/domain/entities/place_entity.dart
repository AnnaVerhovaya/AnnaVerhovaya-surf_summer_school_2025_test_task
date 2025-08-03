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
  });

  final int id;
  final String name;
  final String description;
  final List<String>? images;
  final double? lat;
  final double? lng;
  final PlaceType? placeType;

  @override
  List<Object?> get props =>
      [id, name, description, images, lat, lng, placeType];
}
