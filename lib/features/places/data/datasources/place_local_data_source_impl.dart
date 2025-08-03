import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../models/models.dart';

///  Класс для реализации локальной базы данных для сохранения и загрузки списка мест
/// Работает с таблицей [places]
///
/// Принимает:
/// - [_databaseHelper] - вспомогательный класс для работы БД
class PlaceDatabase implements PlaceLocalDataSource {
  final DatabaseHelper _databaseHelper;
  static const String _tableName = 'places';

  PlaceDatabase(this._databaseHelper);

  Future<Database> get _db async => await _databaseHelper.database;

  @override
  Future<void> cachePlace(PlaceEntity place) async {
    final db = await _db;
    await db.insert(
      _tableName,
      _placeToJson(place),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> cachePlaces(List<PlaceEntity> places) async {
    final db = await _db;
    final batch = db.batch();

    for (final place in places) {
      batch.insert(
        _tableName,
        _placeToJson(place),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  @override
  Future<List<PlaceEntity>> getCachedPlaces() async {
    final db = await _db;
    final result = await db.query(_tableName);
    return result.map(_jsonToPlace).toList();
  }

  @override
  Future<PlaceEntity?> getPlaceById(int id) async {
    final db = await _db;
    final result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? _jsonToPlace(result.first) : null;
  }

  @override
  Future<void> addToFavorite(PlaceEntity place) async {
    final db = await _db;
    final placeJson = _placeToJson(place.copyWith(isFavorite: true));
    await db.insert(
      _tableName,
      placeJson,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<PlaceEntity>> getFavorites() async {
    final db = await _db;
    final List<Map<String, dynamic>> favoritePlaces = await db.query(
      _tableName,
      where: 'is_favorite = ?',
      whereArgs: [1],
    );
    return favoritePlaces.map(_jsonToPlace).toList();
  }

  Map<String, dynamic> _placeToJson(PlaceEntity place) {
    return {
      'id': place.id,
      'name': place.name,
      'lat': place.lat,
      'lng': place.lng,
      'description': place.description,
      'urls': jsonEncode(place.images),
      'type': place.placeType?.name,
      'is_favorite':
          place.isFavorite == null ? null : (place.isFavorite! ? 1 : 0),
    };
  }

  PlaceEntity _jsonToPlace(Map<String, dynamic> json) {
    return PlaceEntity(
      id: json['id'],
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
      description: json['description'],
      images: json['urls'] != null
          ? List<String>.from(jsonDecode(json['urls']))
          : <String>[],
      placeType: json['type'] != null
          ? PlaceType.values.firstWhere(
              (e) => e.name == json['type'],
            )
          : PlaceType.other,
      isFavorite: json['is_favorite'] == null
          ? null
          : (json['is_favorite'] as int) == 1,
    );
  }
}
