import 'package:flutter/material.dart';
import '../../../../uikit/uikit.dart';
import '../../../places/domain/domain.dart';

class MapPlaceDetailsWidget extends StatelessWidget {
  final PlaceEntity place;

  const MapPlaceDetailsWidget({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NetworkImageWidget(
            imgUrl: place.images!.first,
            height: 96,
          ),
          Text(
            place.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (place.description.isNotEmpty)
            Text(
              place.description,
              style: const TextStyle(fontSize: 16),
            ),
        ],
      ),
    );
  }
}
