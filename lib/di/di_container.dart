import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../core/core.dart';
import '../features/places/data/datasources/datasources.dart';
import '../features/places/data/repository/repository.dart';
import '../features/places/domain/domain.dart';

abstract class AppDependencies {
  static Future<List<SingleChildWidget>> providers() async {
    final database = DatabaseHelper();
    final httpClient = AppHttpClient(
      baseUrl: ApiConstants.baseUrl,
    );

    final remoteDataSource = PlaceRemoteDataSource(httpClient);
    final localDataSource = PlaceDatabase(database);
    final searchHistorDataSource = SearchHistoryDatabase(database);

    final placeRepository = PlaceRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    final searchHistoryRepository =
        SearchHistoryRepositoryImpl(searchHistorDataSource);
    return [
      Provider<IHttpClient>.value(value: httpClient),
      Provider<DatabaseHelper>.value(value: database),
      Provider<PlaceRemoteDataSource>.value(value: remoteDataSource),
      Provider<PlaceLocalDataSource>.value(value: localDataSource),
      Provider<PlaceRepository>.value(value: placeRepository),
      Provider<SearchHistoryRepository>.value(value: searchHistoryRepository),
    ];
  }
}
