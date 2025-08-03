import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:surf_summer_school_2025_test_task/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:surf_summer_school_2025_test_task/features/home/home_screen.dart';
import 'package:surf_summer_school_2025_test_task/features/map/presentation/screens/map_screen.dart';
import 'package:surf_summer_school_2025_test_task/features/places/domain/entities/place_entity.dart';
import 'package:surf_summer_school_2025_test_task/features/places/presentation/list/screens/place_details_screen.dart';
import 'package:surf_summer_school_2025_test_task/features/places/presentation/history/screens/place_search_screen.dart';
import 'package:surf_summer_school_2025_test_task/features/places/presentation/list/screens/places_list_screen.dart';
import 'package:surf_summer_school_2025_test_task/features/settings/presentation/screens/settings_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: PlacesListRoute.page,
              path: '',
            ),
            AutoRoute(
              page: FavoritesRoute.page,
              path: 'favorites',
            ),
            AutoRoute(
              page: SettingsRoute.page,
              path: 'settings',
            ),
          ],
        ),
        AutoRoute(
          page: PlaceDetailsRoute.page,
          path: '/details',
        ),
        AutoRoute(
          page: PlaceSearchRoute.page,
          path: '/search',
        ),
      ];
}
