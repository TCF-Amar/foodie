import 'package:flutter/material.dart';
import 'package:foodie/core/models/food_item_model.dart';
import 'package:foodie/core/widgets/index.dart';
import 'package:foodie/features/menu/presentation/controllers/menu_controller.dart';
import 'package:get/get.dart';

class MenuScreen extends GetView<AppMenuController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final surface = isLight ? AppColors.surface : AppColors.darkSurface;
    final divider = isLight ? AppColors.borderLight : AppColors.darkBorder;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // ── App bar area ──────────────────────────────────────────────
          Container(
            color: surface,
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: AppText.extraLarge(
                      "Menu",
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // ── Filter pills row ─────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                    child: Obx(
                      () => Row(
                        children: [
                          _FilterPill(
                            icon: Icons.circle,
                            iconColor: AppColors.secondary500,
                            label: "Veg Only",
                            selected: controller.vegOnly.value,
                            onTap: controller.toggleVegOnly,
                          ),
                          const SizedBox(width: 8),
                          _FilterPill(
                            icon: Icons.change_history,
                            iconColor: AppColors.error,
                            label: "Non Veg Only",
                            selected: controller.nonVegOnly.value,
                            onTap: controller.toggleNonVegOnly,
                          ),
                          const Spacer(),
                          _SortButton(onTap: () {}),
                        ],
                      ),
                    ),
                  ),

                  // ── Divider ──────────────────────────────────────────
                  Divider(height: 1, thickness: 0.5, color: divider),

                  // ── Category Tab row ─────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          controller: controller.tabController,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          indicatorColor: AppColors.primary,
                          labelColor: AppColors.primary,
                          unselectedLabelColor: AppColors.textSecondary,
                          dividerColor: Colors.transparent,
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          padding: EdgeInsets.zero,
                          tabs: AppMenuController.categories.map((cat) {
                            return _CategoryTab(
                              label: cat.label,
                              badge: cat.badge,
                            );
                          }).toList(),
                        ),
                      ),
                      // Menu list icon
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: divider, width: 1),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.menu_rounded,
                              size: 22,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Divider(height: 1, thickness: 0.5, color: divider),
                ],
              ),
            ),
          ),

          // ── Body: Tab content ─────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: AppMenuController.categories.map((cat) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: 10,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final mockItem = FoodItemModel(
                      id: "id_$index",
                      name: "${cat.label} Item $index",
                      description:
                          "Delicious ${cat.label} prepared with fresh ingredients.",
                      restaurantId: "res_1",
                      restaurantName: "Foodie Deluxe",
                      categoryId: "cat_$index",
                      categoryName: cat.label,
                      price: (index + 2) * 100.0,
                      discountedPrice: index % 3 == 0
                          ? (index + 1) * 100.0
                          : null,
                      isVeg: index % 2 == 0,
                      isBestSeller: index % 3 == 0,
                      images: [
                        "https://pub-aaa82e9851064d22b954c3ebbafc9ae6.r2.dev/legacy/webp/burger-with-melted-cheese-m-Y1i3jpYYJZYfOEfX5dX.webp",
                      ],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    return ItemCard(
                      item: mockItem,
                      borderRadius: BorderRadius.zero,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Filter Pill ────────────────────────────────────────────────────────────────
class _FilterPill extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterPill({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? iconColor.withValues(alpha: 0.12)
              : (isLight ? Colors.grey.shade100 : Colors.grey.shade800),
          border: Border.all(
            color: selected ? iconColor : Colors.transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 11, color: iconColor),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: isLight ? Colors.black87 : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sort Button ───────────────────────────────────────────────────────────────
class _SortButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SortButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isLight ? Colors.grey.shade100 : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sort by",
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: isLight ? Colors.black87 : Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.swap_vert_rounded,
              size: 16,
              color: isLight ? Colors.black87 : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Category Tab with badge ────────────────────────────────────────────────────
class _CategoryTab extends StatelessWidget {
  final String label;
  final String? badge;

  const _CategoryTab({required this.label, this.badge});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (badge != null)
            Container(
              margin: const EdgeInsets.only(bottom: 2),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
