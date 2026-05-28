import 'package:flutter/material.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:foodie/core/utils/time_variant.dart';
import 'package:foodie/core/widgets/index.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> banners = [
      {
        'title': 'Get 50% OFF\non your first order',
        'badge': 'Limited Offer',
        'image': AppImages.loginBackground, // use real assets
        'color1': Theme.of(context).primaryColor,
        'color2': Theme.of(context).primaryColor.withValues(alpha: 0.7),
        'badgeColor': Theme.of(context).primaryColor,
      },
      // ... other banners
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Row
          Row(
            children: [
              AppText.extraLarge("Hey User, ", fontWeight: FontWeight.normal),
              AppText.extraLarge(
                "${TimeVariant.greeting}!",
                fontWeight: FontWeight.w900,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 170,
              viewportFraction: 0.9,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              clipBehavior: Clip.none,
            ),
            items: banners
                .map(
                  (banner) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: _buildBannerItem(context, banner),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerItem(BuildContext context, Map<String, dynamic> banner) {
    return AppContainer.card(
      width: double.infinity,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(24),

      image: DecorationImage(
        image: AssetImage(banner['image']),
        fit: BoxFit.cover,
      ),

      child: Stack(
        children: [
          AppContainer.filled(color: Colors.black.withValues(alpha: 0.5)),

          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    banner['badge'],
                    style: TextStyle(
                      color: banner['badgeColor'],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  banner['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          // Food image
        ],
      ),
    );
  }
}

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: Theme.of(context).brightness == Brightness.light
          ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ]
          : null,

      child: Row(
        children: [
          Icon(
            Icons.search,
            color:
                Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withValues(alpha: 0.5) ??
                AppColors.textHint,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Search your favorite dishes...",
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:
                        Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withValues(alpha: 0.5) ??
                        AppColors.textHint,
                  ) ??
                  TextStyle(color: AppColors.textHint, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
