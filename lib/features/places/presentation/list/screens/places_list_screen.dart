import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/core.dart';
import '../../../../../router/router.dart';
import '../../../../../uikit/uikit.dart';
import '../list.dart';

@RoutePage()
class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({super.key});

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  late final PlaceBloc placeBloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    placeBloc = context.read<PlaceBloc>();
  }

  @override
  void dispose() {
    placeBloc.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(AppStrings.placesScreenAppBarTitle,
              style: textTheme.largeTitle),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Поиск по названию',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    width: 6,
                    height: 6,
                    AppSvgIcons.icSearch,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    width: 6,
                    height: 6,
                    AppSvgIcons.icClear,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onTap: () {
                AutoRouter.of(context).push(PlaceSearchRoute());
              },
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PlaceBloc>().add(LoadPlaces());
          await Future.delayed(Duration(milliseconds: 500));
        },
        child: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            if (state is PlaceInitial) {
              return const Center(child: Text('Обновите список'));
            }
            if (state is PlaceLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PlaceEmpty) {
              return const Center(child: Text('Нет доступных мест'));
            }
            if (state is PlaceError) {
              return Center(child: Text(state.message));
            }

            if (state is PlaceLoaded) {
              return ListView.builder(
                itemCount: state.places.length,
                itemBuilder: (ctx, index) =>
                    PlaceCardWidget(place: state.places[index]),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
