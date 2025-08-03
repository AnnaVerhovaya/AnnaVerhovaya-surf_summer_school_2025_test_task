import '../../../features/places/domain/domain.dart';

/// Класс для описания интерфейса сервиса по работе с БД
abstract interface class PlaceLocalDataSource {
  Future<void> cachePlace(PlaceEntity place);
  Future<void> cachePlaces(List<PlaceEntity> places);
  Future<List<PlaceEntity>> getCachedPlaces();
  Future<PlaceEntity?> getPlaceById(int id);
}
