import 'package:flutter/material.dart';
import 'package:foodie/core/models/food_item_model.dart';
import 'package:foodie/core/widgets/index.dart';
import 'package:foodie/core/widgets/item_card.dart';

class ListItems extends StatelessWidget {
  const ListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final burger = FoodItemModel(
      id: '001',
      name: 'Smash Burger',
      description:
          'Double smashed patty, cheddar, pickles, special sauce and brioche bun, lettuce, tomato, secret sauce, ',
      restaurantId: 'r01',
      restaurantName: 'Burger Lab',
      categoryId: 'c01',
      categoryName: 'Burgers',
      price: 249,
      discountedPrice: 199,
      discountPercent: 20,
      images: [
        'https://plus.unsplash.com/premium_photo-1775113885029-648fe62b0da5?q=80&w=2068&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ],
      isVeg: false,
      isBestSeller: true,
      isSpicy: true,
      spiceLevel: 2,
      rating: 4.7,
      totalRatings: 1240,
      prepTimeMinutes: 15,
      calories: 650,
      badge: "Chef's Special",
      tags: ['trending', 'must-try'],
      allergens: ['gluten', 'dairy'],
      addOnGroups: [
        AddOnGroup(
          id: 'g1',
          name: 'Choose Size',
          isRequired: true,
          maxSelect: 1,
          items: [
            AddOnItem(id: 'a1', name: 'Regular', price: 0, isDefault: true),
            AddOnItem(id: 'a2', name: 'Large', price: 50),
          ],
        ),
        AddOnGroup(
          id: 'g2',
          name: 'Add-ons',
          maxSelect: 3,
          items: [
            AddOnItem(id: 'a3', name: 'Extra Cheese', price: 30),
            AddOnItem(id: 'a4', name: 'Extra Patty', price: 80),
            AddOnItem(id: 'a5', name: 'Bacon Strip', price: 60),
          ],
        ),
      ],
      nutrition: const NutritionInfo(
        calories: 650,
        protein: 32,
        carbs: 48,
        fat: 28,
        fiber: 3,
        sugar: 8,
      ),
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 6, 1),
    );
    return AppContainer(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.large("MOST ORDERED", fontWeight: FontWeight.bold),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: 11,
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, index) => ItemCard(item: burger),
          ),
        ],
      ),
    );
  }
}
