import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../models/models.dart';

///  Класс для реализации получения списка мест с API
/// Принимает:
///   - [httpClient] - HTTP клиент для выполнения запросов к API,
class PlaceRemoteDataSource {
  final IHttpClient httpClient;
  PlaceRemoteDataSource(this.httpClient);

  Future<List<PlaceEntity>> getPlaces({int? limit, int? offset}) async {
    final response = await httpClient.get('/places');
    return (response.data as List)
        .map((json) => PlaceDto.fromJson(json).toEntity())
        .toList();
  }

  Future<List<PlaceEntity>> searchPlaces(String query,
      {int? limit, int? offset}) async {
    final response = await httpClient.get(
      '/places/search',
      queryParameters: {
        'q': query,
        if (limit != null) 'limit': limit.toString(),
        if (offset != null) 'offset': offset.toString(),
      },
    );
    final data = response.data as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;
    return results
        .map((i) => PlaceDto.fromJson(i['place']).toEntity())
        .toList();
  }

  Future<PlaceEntity> getPlaceById(int id) async {
    final response = await httpClient.get('/places/$id');
    return PlaceDto.fromJson(response.data).toEntity();
  }
}
