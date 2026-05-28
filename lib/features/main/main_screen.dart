// main_screen.dart
import 'package:flutter/material.dart';
import 'package:foodie/features/menu/presentation/pages/menu_screen.dart';
import 'package:get/get.dart';
import 'package:foodie/core/widgets/index.dart';
import 'package:foodie/features/home/presentation/pages/home_page.dart';
import 'main_controller.dart';

const _navItems = [
  (icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
  (
    icon: Icons.grid_view_outlined,
    activeIcon: Icons.grid_view_rounded,
    label: 'Menu',
  ),
  (
    icon: Icons.person_outline,
    activeIcon: Icons.person_rounded,
    label: 'Profile',
  ),
];

// ─────────────────────────────────────────────────
//  MAIN SCREEN
// ─────────────────────────────────────────────────
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(MainController());

    return Scaffold(
      body: PageView(
        controller: ctrl.pageController,
        // physics: const NeverScrollableScrollPhysics(),
        children: const [HomePage(), MenuScreen(), AppContainer()],
      ),
      bottomNavigationBar: Obx(
        () => _AppNavBar(
          currentIndex: ctrl.currentIndex.value,
          onTap: ctrl.onTap,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────
//  NAV BAR
// ─────────────────────────────────────────────────
class _AppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _AppNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final family = Theme.of(context).textTheme.bodyLarge?.fontFamily;

    return Container(
      decoration: BoxDecoration(
        color: isLight ? AppColors.surface : AppColors.darkSurface,
        border: Border(
          top: BorderSide(
            color: isLight ? AppColors.borderLight : AppColors.darkBorder,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(_navItems.length, (i) {
              final item = _navItems[i];
              final isActive = currentIndex == i;
              final color = isActive
                  ? AppColors.primary
                  : (isLight ? AppColors.textHint : AppColors.darkTextHint);

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ── Top active line ────────────────────────
                      Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          height: 3,
                          width: isActive ? 28 : 0,
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      // ── Icon ──────────────────────────────────
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          isActive ? item.activeIcon : item.icon,
                          key: ValueKey(isActive),
                          color: color,
                          size: 24,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // ── Label ─────────────────────────────────
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 11,
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: color,
                        ),
                        child: Text(item.label),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
