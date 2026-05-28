import 'package:foodie/core/routes/app_routes.dart';
import 'package:foodie/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      // leading: AppContainer.circle(
      //   onTap: () => Scaffold.of(context).openDrawer(),
      //   margin: const EdgeInsets.only(left: 10),
      //   height: 50,
      //   width: 50,
      //   color: AppColors.darkElevated.withValues(alpha: 0.2),
      //   padding: const EdgeInsets.only(
      //     bottom: 12,
      //     top: 12,
      //     left: 14,
      //     right: 10,
      //   ),
      //   child: AppSvg.asset(
      //     AppIcons.menu,
      //     width: 16,
      //     height: 16,
      //     color: iconColor,
      //   ),
      // ),
      title: Row(
        spacing: 8,
        children: [
          AppImage.asset(AppImages.logo, height: 30),
          AppText.extraLarge(
            "FOODIE",
            color: AppColors.accent200,
            fontSize: 22,
          ),
        ],
      ),
      actions: [
        AppContainer.circle(
          onTap: () {
            context.pushNamed(AppRoutes.camera.name);
          },
          margin: const EdgeInsets.only(right: 10),
          color: AppColors.darkElevated.withValues(alpha: 0.2),
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(10),
          child: Badge(
            label: Text("3"),
            backgroundColor: AppColors.primary,
            textColor: Colors.white,
            child: AppSvg.asset(
              AppIcons.bag,
              width: 20,
              height: 20,
              color: iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
