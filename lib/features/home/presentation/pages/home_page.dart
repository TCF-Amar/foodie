import 'package:foodie/core/widgets/app_footer.dart';
import 'package:foodie/core/widgets/modern_refresh_indicator.dart';
import 'package:foodie/core/widgets/index.dart';
import 'package:foodie/features/home/presentation/controllers/home_controller.dart';
import 'package:foodie/features/home/presentation/widgets/categories_list.dart';
import 'package:foodie/features/home/presentation/widgets/home_app_bar.dart';
import 'package:foodie/features/home/presentation/widgets/home_hero.dart';
import 'package:foodie/features/home/presentation/widgets/best_seller.dart';
import 'package:foodie/features/home/presentation/widgets/recommended_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: HomeAppBar(),
      body: ModernRefreshIndicator(
        // enableHaptic: true,
        onRefresh: () async {
          await controller.refreshData();
        },
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: HomeHero()),
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  toolbarHeight: 68,
                  flexibleSpace: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: HomeSearchBar(),
                  ),
                ),
                SliverToBoxAdapter(child: CategoriesList()),

                SliverToBoxAdapter(child: RecommendedItems()),

                SliverToBoxAdapter(child: ListItems()),

                SliverToBoxAdapter(child: AppFooter()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
