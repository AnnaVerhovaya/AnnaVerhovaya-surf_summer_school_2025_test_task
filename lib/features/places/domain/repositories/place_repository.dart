import '../domain.dart';

abstract class PlaceRepository {
  Future<List<PlaceEntity>> getPlaces({int? limit, int? offset});
  Future<List<PlaceEntity>> searchPlaces(String query,
      {int? limit, int? offset});
  Future<PlaceEntity> getPlaceById(int id);
}
