import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../router/router.dart';
import '../../../../../uikit/uikit.dart';
import '../../../domain/domain.dart';

class PlaceCardWidget extends StatelessWidget {
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

  const PlaceCardWidget({
    required this.place,
    // required this.onCardTap,
    // required this.onLikeTap,
    // this.cardType = PlaceCardType.place,
    this.isFavorite = false,
    super.key,
  });

  static const _cardHeight = 188.0;
  static const _imageHeight = 96.0;

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
        AutoRouter.of(context).push(
          PlaceDetailsRoute(place: place),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 32),
        child: SizedBox(
          height: _cardHeight,
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: _imageHeight,
                          child: _buildImageWidget(),
                        ),
                        Positioned(
                          left: 16,
                          top: 16,
                          right: 12,
                          child: Text(
                            place.placeType!.name.toLowerCase(),
                            style: textTheme.smallBold
                                .copyWith(color: colorTheme.neutralWhite),
                          ),
                        ),
                      ],
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(16),
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
                          const SizedBox(height: 2),
                          Text(
                            place.description,
                            maxLines: 2,
                            style: textTheme.small.copyWith(
                                color: colorTheme.textSecondaryVariant),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 16,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
