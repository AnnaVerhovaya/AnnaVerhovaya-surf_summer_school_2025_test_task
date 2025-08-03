import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../datasources/datasources.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceRemoteDataSource remoteDataSource;
  final PlaceLocalDataSource localDataSource;

  PlaceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<PlaceEntity>> getPlaces({int? limit, int? offset}) async {
    try {
      final remotePlaces =
          await remoteDataSource.getPlaces(limit: limit, offset: offset);
      await localDataSource.cachePlaces(remotePlaces);
      return remotePlaces;
    } catch (e) {
      final localPlaces = await localDataSource.getCachedPlaces();
      if (localPlaces.isNotEmpty) {
        return localPlaces;
      }
      throw Exception('Ошибка загрузки данных');
    }
  }

  @override
  Future<List<PlaceEntity>> searchPlaces(String query,
      {int? limit, int? offset}) async {
    try {
      final remotePlaces = await remoteDataSource.searchPlaces(
        query,
        limit: limit,
        offset: offset,
      );
      return remotePlaces;
    } catch (e) {
      throw Exception('Ошибка загрузки данных: $e');
    }
  }

  @override
  Future<PlaceEntity> getPlaceById(int id) async {
    try {
      return await remoteDataSource.getPlaceById(id);
    } catch (e) {
      throw Exception('Ошибка загрузки данных: $e');
    }
  }

  @override
  Future<void> addToFavorites(PlaceEntity place) async {
    try {
      return await localDataSource.addToFavorite(place);
    } catch (e) {
      throw Exception('Ошибка загрузки данных: $e');
    }
  }

  @override
  Future<List<PlaceEntity?>> getFavorites() async {
    try {
      return await localDataSource.getFavorites();
    } catch (e) {
      throw Exception('Ошибка загрузки данных: $e');
    }
  }
}
