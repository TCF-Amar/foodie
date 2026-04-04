// app_bottom_sheet.dart
import 'package:foodie/core/constant/colors/app_colors.dart';
import 'package:foodie/core/widgets/app_keys.dart';
import 'package:flutter/material.dart';
import 'app_text.dart';

class AppBottomSheet {
  AppBottomSheet._();

  // ── Simple ────────────────────────────────────────────────────
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    String? subtitle,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showDragHandle = true,
    bool isScrollControlled = true,
    bool showCloseButton = false,
    double? initialChildSize,
    double minChildSize = 0.25,
    double maxChildSize = 0.92,
    Color? backgroundColor,
    EdgeInsets? padding,
    bool useScrollable = false,
  }) => showModalBottomSheet<T>(
    context: AppKeys.navigatorKey.currentContext ?? context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: isScrollControlled,
    barrierColor: AppColors.overlay60,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _AppBottomSheetWidget<T>(
      title: title,
      subtitle: subtitle,
      showDragHandle: showDragHandle,
      showCloseButton: showCloseButton,
      initialSize: initialChildSize,
      minSize: minChildSize,
      maxSize: maxChildSize,
      backgroundColor: backgroundColor,
      padding: padding,
      useScrollable: useScrollable,
      child: child,
    ),
  );

  // ── Scrollable with DraggableScrollable ───────────────────────
  static Future<T?> scrollable<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    String? subtitle,
    double initialSize = 0.5,
    double minSize = 0.25,
    double maxSize = 0.92,
    bool isDismissible = true,
    bool showCloseButton = false,
    Color? backgroundColor,
    EdgeInsets? padding,
  }) => show<T>(
    context,
    title: title,
    subtitle: subtitle,
    isDismissible: isDismissible,
    initialChildSize: initialSize,
    minChildSize: minSize,
    maxChildSize: maxSize,
    showCloseButton: showCloseButton,
    backgroundColor: backgroundColor,
    padding: padding,
    useScrollable: true,
    child: child,
  );

  // ── Menu / Options list ───────────────────────────────────────
  static Future<T?> menu<T>(
    BuildContext context, {
    required List<AppSheetMenuItem<T>> items,
    String? title,
  }) => show<T>(
    context,
    title: title,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: items.map((item) => _MenuTile<T>(item: item)).toList(),
    ),
  );
}

// ── Bottom sheet widget ────────────────────────────────────────
class _AppBottomSheetWidget<T> extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final bool showDragHandle;
  final bool showCloseButton;
  final double? initialSize;
  final double minSize;
  final double maxSize;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool useScrollable;

  const _AppBottomSheetWidget({
    required this.child,
    this.title,
    this.subtitle,
    this.showDragHandle = true,
    this.showCloseButton = false,
    this.initialSize,
    this.minSize = 0.25,
    this.maxSize = 0.92,
    this.backgroundColor,
    this.padding,
    this.useScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final bg =
        backgroundColor ??
        (isLight ? AppColors.surface : AppColors.darkSurface);

    Widget header = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Drag handle ───────────────────────────────────
        if (showDragHandle)
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isLight ? AppColors.borderStrong : AppColors.darkBorder,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

        // ── Header Content ────────────────────────────────
        if (title != null || showCloseButton)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        AppText.large(title!, fontWeight: FontWeight.w700),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        AppText.small(subtitle!),
                      ],
                    ],
                  ),
                ),
                if (showCloseButton)
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isLight ? AppColors.bgSecondary : AppColors.darkCard,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: isLight
                            ? AppColors.textSecondary
                            : AppColors.darkTextSecondary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );

    if (useScrollable) {
      return DraggableScrollableSheet(
        initialChildSize: initialSize ?? 0.5,
        minChildSize: minSize,
        maxChildSize: maxSize,
        expand: false,
        builder: (ctx, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              border: Border(
                top: BorderSide(
                  color: isLight ? AppColors.borderLight : AppColors.darkBorder,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                header,
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: padding ?? const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    children: [child],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          );
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(
            color: isLight ? AppColors.borderLight : AppColors.darkBorder,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          Padding(
            padding: padding ?? const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: child,
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }
}

// ── Menu item model ────────────────────────────────────────────
class AppSheetMenuItem<T> {
  final String label;
  final IconData? icon;
  final Color? color;
  final T value;
  final bool isDestructive;

  const AppSheetMenuItem({
    required this.label,
    required this.value,
    this.icon,
    this.color,
    this.isDestructive = false,
  });
}

class _MenuTile<T> extends StatelessWidget {
  final AppSheetMenuItem<T> item;
  const _MenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final color = item.isDestructive
        ? AppColors.error
        : (item.color ??
              (isLight ? AppColors.textPrimary : AppColors.darkTextPrimary));

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      leading: item.icon != null
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: item.isDestructive
                    ? AppColors.errorLight
                    : (isLight ? AppColors.bgSecondary : AppColors.darkCard),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: color, size: 20),
            )
          : null,
      title: Text(
        item.label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: color,
          fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
        ),
      ),
      onTap: () => Navigator.pop(context, item.value),
    );
  }
}
