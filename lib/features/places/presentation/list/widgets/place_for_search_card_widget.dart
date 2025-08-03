import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:surf_summer_school_2025_test_task/core/constants/app_constants.dart';
import '../../../../../router/router.dart';
import '../../../../../uikit/uikit.dart';
import '../../../domain/domain.dart';

class PlaceForSearchCardWidget extends StatelessWidget {
  // /// Место.
  final PlaceEntity place;

  // /// Обработчик нажатия на карточку.
  // final VoidCallback onCardTap;

  // /// Обработчик нажатия на кнопку "лайк".
  // final VoidCallback onLikeTap;

  // /// Тип карточки.
  // final PlaceCardType cardType;

  /// Флаг, указывающий, добавлено ли место в избранное.
  final bool isFavorite;

  const PlaceForSearchCardWidget({
    required this.place,
    // required this.onCardTap,
    // required this.onLikeTap,
    // this.cardType = PlaceCardType.place,
    this.isFavorite = false,
    super.key,
  });

  static const _cardHeight = 78.0;
  static const _imageHeight = 56.0;

  Widget _buildImageWidget() {
    final images = place.images;
    if (images == null || images.isEmpty) {
      return Center(child: Text(AppStrings.noPhoto));
    }

    final firstImage = images.firstWhere(
      (image) => image.isNotEmpty,
      orElse: () => '',
    );

    if (firstImage.isEmpty) {
      return Center(child: Text(AppStrings.noPhoto));
    }

    return Image.network(
      firstImage,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Center(child: Text(AppStrings.noPhoto)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(PlaceDetailsRoute());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 32),
        child: SizedBox(
          height: _cardHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _imageHeight,
                height: _imageHeight,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: _buildImageWidget(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: textTheme.text
                          .copyWith(color: colorTheme.textSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      place.placeType.toString(),
                      style: textTheme.text
                          .copyWith(color: colorTheme.textSecondary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
