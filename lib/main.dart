import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:surf_summer_school_2025_test_task/features/favorites/presentation/favorites_bloc.dart';
import 'di/di.dart';
import 'features/places/domain/domain.dart';
import 'features/places/presentation/presentation.dart';
import 'router/router.dart';
import 'uikit/themes/themes.dart';

void main() async {
  final providers = await AppDependencies.providers();
  final appRouter = AppRouter();

  runApp(
    MultiProvider(
      providers: providers,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PlaceBloc>(
            create: (context) {
              final placeRepository = context.read<PlaceRepository>();
              return PlaceBloc(placeRepository)
                ..add(
                  LoadPlaces(),
                );
            },
          ),
          BlocProvider<SearchHistoryBloc>(
            create: (context) {
              final searchHistoryRepository =
                  context.read<SearchHistoryRepository>();
              return SearchHistoryBloc(searchHistoryRepository);
            },
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) {
              final placeRepository = context.read<PlaceRepository>();
              return FavoritesBloc(placeRepository);
            },
          ),
        ],
        child: MyApp(appRouter: appRouter),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppThemeData.lightTheme,
      routerConfig: appRouter.config(),
    );
  }
}
