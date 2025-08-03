import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/core.dart';
import '../../../../../uikit/uikit.dart';
import '../../list/list.dart';
import '../history.dart';

@RoutePage()
class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({super.key});

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  late final PlaceBloc placeBloc;
  late final SearchHistoryBloc searchHistoryBloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    placeBloc = context.read<PlaceBloc>();
    searchHistoryBloc = context.read<SearchHistoryBloc>();
    searchHistoryBloc.add(LoadSearchHistory());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.placesScreenAppBarTitle, style: textTheme.title),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
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
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(AppSvgIcons.icClear),
                  onPressed: () {
                    _searchController.clear();
                    AutoRouter.of(context).pop();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  placeBloc.add(SearchPlaces(query, null));
                  searchHistoryBloc.add(SaveSearchQuery(query));
                }
              },
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          placeBloc.add(LoadPlaces());
          await Future.delayed(Duration(milliseconds: 500));
        },
        child: Column(
          children: [
            BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
              builder: (context, historyState) {
                if (historyState is SearchHistoryLoaded &&
                    historyState.searchHistory.isNotEmpty) {
                  return _buildHistoryList(historyState.searchHistory);
                }
                return Container();
              },
            ),
            Expanded(
              child: BlocBuilder<PlaceBloc, PlaceState>(
                builder: (context, placeState) {
                  if (_searchController.text.isNotEmpty) {
                    if (placeState is PlaceLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (placeState is PlaceError) {
                      return Center(child: Text(placeState.message));
                    }
                    if (placeState is PlaceLoaded &&
                        placeState.places.isNotEmpty) {
                      return ListView.builder(
                        itemCount: placeState.places.length,
                        itemBuilder: (ctx, index) => PlaceForSearchCardWidget(
                            place: placeState.places[index]),
                      );
                    }
                    if (placeState is PlaceEmpty) {
                      return const Center(child: Text('Нет доступных мест'));
                    }
                  }
                  return BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
                    builder: (context, historyState) {
                      if (historyState is SearchHistoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (historyState is SearchHistoryLoaded &&
                          historyState.searchHistory.isEmpty) {
                        return const Center(child: Text('Ничего не найдено'));
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(List<String> history) {
    final textTheme = AppTextTheme.of(context);
    final colorTheme = AppColorTheme.of(context);

    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Вы искали',
              style: textTheme.text.copyWith(color: colorTheme.inactive),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: history.length,
              itemBuilder: (i, index) => ListTile(
                title: Text(history[index]),
                onTap: () {
                  _searchController.text = history[index];
                  context
                      .read<PlaceBloc>()
                      .add(SearchPlaces(history[index], null));
                },
                trailing: IconButton(
                  icon: SvgPicture.asset(AppSvgIcons.icClose),
                  onPressed: () {
                    context.read<SearchHistoryBloc>().add(
                          RemoveSearchHistoryItem(history[index]),
                        );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextButton(
              onPressed: () {
                context.read<SearchHistoryBloc>().add(ClearSearchHistory());
              },
              child: Text(
                'Очистить историю',
                style: textTheme.text.copyWith(color: colorTheme.accent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
