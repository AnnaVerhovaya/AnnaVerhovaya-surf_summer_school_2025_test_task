import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../uikit/uikit.dart';
import '../../../domain/entities/place_entity.dart';

@RoutePage()
class PlaceDetailsScreen extends StatelessWidget {
  final PlaceEntity place;
  const PlaceDetailsScreen({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 360,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: place.images?.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.network(
                        place.images![index],
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Positioned(
                        top: 15,
                        left: 15,
                        child: BackButtonWidget(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                Text(
                  place.name,
                ),
                const SizedBox(height: 8),
                Text(
                  place.placeType.toString(),
                ),
                const SizedBox(height: 16),
                Text(
                  place.description,
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            sliver: SliverToBoxAdapter(
              child: Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
