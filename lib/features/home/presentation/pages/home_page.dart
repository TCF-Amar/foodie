import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:foodie/core/widgets/modern_refresh_indicator.dart';
import 'package:foodie/core/widgets/index.dart';
import 'package:foodie/features/home/presentation/home_controller.dart';
import 'package:foodie/features/home/presentation/widgets/categories_list.dart';
import 'package:foodie/features/home/presentation/widgets/home_app_bar.dart';
import 'package:foodie/features/home/presentation/widgets/home_hero.dart';
import 'package:foodie/features/home/presentation/widgets/best_seller.dart';
import 'package:foodie/features/home/presentation/widgets/recommended_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

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
              ],
            ),
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: SafeArea(
            //     child: AppContainer.pill(
            //       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //       height: 50,
            //       child: Row(
            //         children: [
            //           AppSvg.asset(AppIcons.home),
            //           // AppSvg.asset(AppIcons.bag),
            //           AppSvg.asset(AppIcons.heart),
            //           AppSvg.asset(AppIcons.user),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      drawer: Drawer(
        // clipBehavior: .none,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('DELIVER TO'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CrystalNavigationBar(
        items: [
          CrystalNavigationBarItem(icon: Icon(Icons.home)),
          CrystalNavigationBarItem(icon: Icon(Icons.search)),
          // CrystalNavigationBarItem(icon: Icon(Icons.bag)),
          CrystalNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
