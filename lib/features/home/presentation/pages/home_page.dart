import 'package:foodie/core/utils/time_variant.dart';
import 'package:foodie/core/widgets/index.dart';
// import 'package:foodie/features/auth/presentation/controller/auth_controller.dart';
import 'package:foodie/features/home/presentation/widgets/categories_list.dart';
import 'package:foodie/features/home/presentation/widgets/home_app_bar.dart';
import 'package:foodie/features/home/presentation/widgets/recommended_items.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: HomeAppBar(),
      body: CustomScrollView(
        slivers: [
          // keep the outer AppBar at top and add inner floating SliverAppBar for search etc.
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            toolbarHeight: kMinInteractiveDimension * 2.5,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppText.extraLarge(
                          "Hey User, ",
                          fontWeight: FontWeight.normal,
                        ),
                        AppText.extraLarge(
                          "${TimeVariant.greeting}!",
                          fontWeight: FontWeight.w900,
                        ),
                      ],
                    ),
                    AppContainer.pill(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      alignment: Alignment.center,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.black.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(10),

                      child: Row(
                        spacing: 8,
                        children: [
                          AppSvg.asset(
                            AppIcons.search,
                            // width: 12,
                            // height: 12,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                          AppText.medium(
                            "Search dishes",
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                            // margin: const EdgeInsets.only(left: 8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: CategoriesList()),

          SliverToBoxAdapter(child: RecommendedItems()),
        ],
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
    );
  }
}
