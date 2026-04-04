// app_snackbar.dart
import 'package:foodie/core/constant/colors/app_colors.dart';
import 'package:foodie/core/widgets/app_keys.dart';
import 'package:flutter/material.dart';

enum SnackType { success, error, warning, info }

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackType type = SnackType.info,
    String? title,
    Widget? prefixIcon,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    EdgeInsets? margin,
    double? borderRadius,
    bool showCloseIcon = false,
  }) {
    final messenger = AppKeys.messengerKey.currentState;
    messenger?.hideCurrentSnackBar();
    messenger?.showSnackBar(
      _build(
        context,
        message: message,
        type: type,
        title: title,
        prefixIcon: prefixIcon,
        actionLabel: actionLabel,
        onAction: onAction,
        duration: duration,
        behavior: behavior,
        margin: margin,
        borderRadius: borderRadius,
        showCloseIcon: showCloseIcon,
      ),
    );
  }

  // ── Convenience helpers ────────────────────────────────────────
  static void success(
    BuildContext context,
    String message, {
    String? title,
    String? actionLabel,
    VoidCallback? onAction,
  }) => show(
    context,
    message: message,
    title: title,
    type: SnackType.success,
    actionLabel: actionLabel,
    onAction: onAction,
  );

  static void error(
    BuildContext context,
    String message, {
    String? title,
    String? actionLabel,
    VoidCallback? onAction,
  }) => show(
    context,
    message: message,
    title: title,
    type: SnackType.error,
    actionLabel: actionLabel,
    onAction: onAction,
  );

  static void warning(
    BuildContext context,
    String message, {
    String? title,
    String? actionLabel,
    VoidCallback? onAction,
  }) => show(
    context,
    message: message,
    title: title,
    type: SnackType.warning,
    actionLabel: actionLabel,
    onAction: onAction,
  );

  static void info(
    BuildContext context,
    String message, {
    String? title,
    String? actionLabel,
    VoidCallback? onAction,
  }) => show(
    context,
    message: message,
    title: title,
    type: SnackType.info,
    actionLabel: actionLabel,
    onAction: onAction,
  );

  // ── Internal builder ──────────────────────────────────────────
  static SnackBar _build(
    BuildContext context, {
    required String message,
    required SnackType type,
    String? title,
    Widget? prefixIcon,
    String? actionLabel,
    VoidCallback? onAction,
    required Duration duration,
    required SnackBarBehavior behavior,
    EdgeInsets? margin,
    double? borderRadius,
    bool showCloseIcon = false,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final config = _SnackConfig.of(type);
    final family = Theme.of(context).textTheme.bodyLarge?.fontFamily;

    return SnackBar(
      duration: duration,
      behavior: behavior,
      elevation: 0,
      margin:
          margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 14),
      ),
      content: Container(
        decoration: BoxDecoration(
          color: isLight ? const Color(0xFF1A1625) : AppColors.darkElevated,
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
          border: Border.all(
            color: config.color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // ── Left accent bar ──────────────────────────────
            Container(
              width: 3,
              height: title != null ? 40 : 20,
              decoration: BoxDecoration(
                color: config.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),

            // ── Icon ─────────────────────────────────────────
            prefixIcon ?? Icon(config.icon, color: config.color, size: 20),
            const SizedBox(width: 10),

            // ── Text ─────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null) ...[
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    message,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // ── Action ───────────────────────────────────────
            if (actionLabel != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  AppKeys.messengerKey.currentState?.hideCurrentSnackBar();
                  onAction?.call();
                },
                child: Text(
                  actionLabel,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: config.color,
                  ),
                ),
              ),
            ],

            // ── Close ────────────────────────────────────────
            if (showCloseIcon) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => AppKeys.messengerKey.currentState?.hideCurrentSnackBar(),
                child: const Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: Colors.white38,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SnackConfig {
  final Color color;
  final IconData icon;
  const _SnackConfig({required this.color, required this.icon});

  static _SnackConfig of(SnackType type) => switch (type) {
    SnackType.success => const _SnackConfig(
      color: AppColors.success,
      icon: Icons.check_circle_outline_rounded,
    ),
    SnackType.error => const _SnackConfig(
      color: AppColors.error,
      icon: Icons.error_outline_rounded,
    ),
    SnackType.warning => const _SnackConfig(
      color: AppColors.warning,
      icon: Icons.warning_amber_rounded,
    ),
    SnackType.info => const _SnackConfig(
      color: AppColors.primary,
      icon: Icons.info_outline_rounded,
    ),
  };
}
