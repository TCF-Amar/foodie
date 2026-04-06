import 'package:flutter/material.dart';
import 'package:foodie/core/models/food_item_model.dart';
import 'package:foodie/core/widgets/index.dart';

class ItemCard extends StatelessWidget {
  final FoodItemModel item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AppContainer.card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(height: 130, width: 130),
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    AppText.large(
                      item.name,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    AppText.medium(
                      "₹${item.price}",
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    AppText.small(
                      item.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: AppContainer.pill(
                    padding: const EdgeInsets.all(1),
                    borderRadius: BorderRadius.circular(2),
                    borderWidth: 1,
                    borderColor: item.isVeg
                        ? AppColors.secondary500
                        : AppColors.error,
                    color: Colors.transparent,
                    child: Icon(
                      color: item.isVeg
                          ? AppColors.secondary500
                          : AppColors.error,
                      Icons.circle,
                      size: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Stack(
              // alignment: Alignment.,
              children: [
                SizedBox(height: 130, width: 130),
                AppImage.network(
                  item.images.first,

                  height: 110,
                  borderRadius: BorderRadius.circular(10),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  left: 10,
                  child: AppContainer.pill(
                    borderRadius: BorderRadius.circular(10),

                    // padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppText.large("Add"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
