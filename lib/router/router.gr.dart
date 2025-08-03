// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [FavoritesScreen]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
      : super(MapRoute.name, initialChildren: children);

  static const String name = 'MapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MapScreen();
    },
  );
}

/// generated route for
/// [PlaceDetailsScreen]
class PlaceDetailsRoute extends PageRouteInfo<PlaceDetailsRouteArgs> {
  PlaceDetailsRoute({
    Key? key,
    required PlaceEntity place,
    List<PageRouteInfo>? children,
  }) : super(
          PlaceDetailsRoute.name,
          args: PlaceDetailsRouteArgs(key: key, place: place),
          initialChildren: children,
        );

  static const String name = 'PlaceDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlaceDetailsRouteArgs>();
      return PlaceDetailsScreen(key: args.key, place: args.place);
    },
  );
}

class PlaceDetailsRouteArgs {
  const PlaceDetailsRouteArgs({this.key, required this.place});

  final Key? key;

  final PlaceEntity place;

  @override
  String toString() {
    return 'PlaceDetailsRouteArgs{key: $key, place: $place}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlaceDetailsRouteArgs) return false;
    return key == other.key && place == other.place;
  }

  @override
  int get hashCode => key.hashCode ^ place.hashCode;
}

/// generated route for
/// [PlaceSearchScreen]
class PlaceSearchRoute extends PageRouteInfo<void> {
  const PlaceSearchRoute({List<PageRouteInfo>? children})
      : super(PlaceSearchRoute.name, initialChildren: children);

  static const String name = 'PlaceSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PlaceSearchScreen();
    },
  );
}

/// generated route for
/// [PlacesListScreen]
class PlacesListRoute extends PageRouteInfo<void> {
  const PlacesListRoute({List<PageRouteInfo>? children})
      : super(PlacesListRoute.name, initialChildren: children);

  static const String name = 'PlacesListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PlacesListScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}
