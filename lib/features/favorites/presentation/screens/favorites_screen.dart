import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_summer_school_2025_test_task/features/favorites/presentation/favorites_bloc.dart';
import '../../../places/presentation/presentation.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesBloc favoritesBloc;

  @override
  void initState() {
    favoritesBloc = context.read<FavoritesBloc>()..add(LoadFavorites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoritesLoaded) {
            final favorites = state.favorites;
            if (favorites.isEmpty) {
              return const Center(child: Text('Нет избранных мест'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final place = favorites[index];
                return place != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PlaceCardWidget(place: place),
                      )
                    : Container();
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
