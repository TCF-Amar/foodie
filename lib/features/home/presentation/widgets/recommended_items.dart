import 'package:foodie/core/widgets/index.dart';
import 'package:flutter/material.dart';

class RecommendedItems extends StatelessWidget {
  const RecommendedItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: AppText.large(
              "RECOMMENDED FOR YOU",
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            // (card height × 2 rows) + (row spacing × 1) + (label/time heights)
            height: 320,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 rows
                crossAxisSpacing: 12, // vertical gap between rows
                mainAxisSpacing: 12, // horizontal gap between columns
                mainAxisExtent: 130, // card width
              ),
              itemCount: 10,
              itemBuilder: (_, index) => const _RecommendedCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  const _RecommendedCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Stack(
          children: [
            AppImage.asset(
              AppImages.loginBackground,
              width: 130,
              height: 80,
              borderRadius: BorderRadius.circular(12),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: AppContainer(
                width: 40,
                color: AppColors.secondary700,
                borderRadius: BorderRadius.circular(8),
                alignment: Alignment.center,
                child: AppText.small("4.5", color: Colors.white),
              ),
            ),
          ],
        ),
        AppText.medium(
          "Delicious Pizza",
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600,
        ),
        Row(
          spacing: 4,
          children: [
            AppSvg.asset(
              AppIcons.watch,
              width: 16,
              height: 16,
              color: AppColors.accent200,
            ),
            AppText.small("20 min", color: Colors.grey),
          ],
        ),
      ],
    );
  }
}
