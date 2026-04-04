import 'package:foodie/core/widgets/index.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.large("CATEGORIES"),
                AppText.large("See All", color: AppColors.accent200),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                spacing: 20,
                children: List.generate(
                  10,
                  (index) => AppContainer.filled(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.05),
                    padding: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                      left: 8,
                      right: 16,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      spacing: 8,
                      children: [
                        AppImage.asset(
                          AppImages.loginBackground,
                          width: 45,
                          height: 45,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        AppText.large(
                          "All Calls",
                          // margin: const EdgeInsets.only(left: 8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
