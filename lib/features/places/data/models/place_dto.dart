import '../../domain/domain.dart';
import 'models.dart';

class PlaceDto {
  final int id;
  final String name;
  final String description;
  final List<String>? images;
  final double lat;
  final double lng;
  final PlaceType? placeType;

  const PlaceDto({
    required this.id,
    required this.name,
    required this.description,
    this.images,
    required this.lat,
    required this.lng,
    this.placeType,
  });

  factory PlaceDto.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'id': int id,
          'name': String name,
          'description': String description,
          'lat': double lat,
          'lng': double lng,
          'type': String? placeType,
        }) {
      final images =
          (json['urls'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
              [];
      return PlaceDto(
        id: id,
        name: name,
        description: description,
        lat: lat,
        lng: lng,
        images: images,
        placeType: _parsePlaceType(placeType),
      );
    }
    throw FormatException('Invalid JSON for PlaceDto');
  }

  PlaceEntity toEntity() => PlaceEntity(
        id: id,
        name: name,
        description: description,
        images: images,
        lat: lat,
        lng: lng,
        placeType: placeType,
      );

  static PlaceType _parsePlaceType(String? placeType) {
    return switch (placeType) {
      'park' => PlaceType.park,
      'monument' => PlaceType.monument,
      'theatre' => PlaceType.theatre,
      'museum' => PlaceType.museum,
      'temple' => PlaceType.temple,
      'hotel' => PlaceType.hotel,
      'restaurant' => PlaceType.restaurant,
      'cafe' => PlaceType.cafe,
      'shopping' => PlaceType.shopping,
      _ => PlaceType.other,
    };
  }
}
