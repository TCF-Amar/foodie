// app_dialog.dart
import 'package:calling_app/core/constant/colors/app_colors.dart';
import 'package:calling_app/core/widgets/app_keys.dart';
import 'package:flutter/material.dart';
import 'app_button.dart';
import 'app_text.dart';

enum DialogType { info, success, warning, danger }

class AppDialog {
  AppDialog._();

  // ── Confirm ───────────────────────────────────────────────────
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    DialogType type = DialogType.info,
    Widget? illustration,
    bool barrierDismissible = true,
  }) => show<bool>(
    context,
    barrierDismissible: barrierDismissible,
    title: title,
    message: message,
    type: type,
    illustration: illustration,
    actions: (ctx) => [
      AppButton.outlined(
        label: cancelLabel,
        expanded: true,
        height: 46,
        onPressed: () => Navigator.pop(ctx, false),
      ),
      const SizedBox(width: 10),
      _primaryBtn(ctx, type, confirmLabel, true),
    ],
  );

  // ── Alert ─────────────────────────────────────────────────────
  static Future<void> alert(
    BuildContext context, {
    required String title,
    required String message,
    String okLabel = 'Got it',
    DialogType type = DialogType.info,
    Widget? illustration,
  }) => show<void>(
    context,
    title: title,
    message: message,
    type: type,
    illustration: illustration,
    actions: (ctx) => [_primaryBtn(ctx, type, okLabel, null)],
  );

  // ── Delete / Destructive ──────────────────────────────────────
  static Future<bool?> delete(
    BuildContext context, {
    required String title,
    String message = 'This action cannot be undone.',
    String deleteLabel = 'Delete',
    String cancelLabel = 'Cancel',
  }) => confirm(
    context,
    title: title,
    message: message,
    confirmLabel: deleteLabel,
    cancelLabel: cancelLabel,
    type: DialogType.danger,
  );

  // ── Custom / Raw ──────────────────────────────────────────────
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? message,
    DialogType type = DialogType.info,
    Widget? illustration,
    Widget? body,
    List<Widget> Function(BuildContext ctx)? actions,
    bool barrierDismissible = true,
    double? maxWidth,
    EdgeInsets? contentPadding,
  }) => showDialog<T>(
    context: AppKeys.navigatorKey.currentContext ?? context,
    barrierDismissible: barrierDismissible,
    barrierColor: AppColors.overlay60,
    builder: (ctx) => _AppDialogWidget<T>(
      title: title,
      message: message,
      type: type,
      illustration: illustration,
      body: body,
      actions: actions,
      maxWidth: maxWidth,
      contentPadding: contentPadding,
    ),
  );

  // ── Internal helper ───────────────────────────────────────────
  static Widget _primaryBtn(
    BuildContext ctx,
    DialogType type,
    String label,
    bool? result,
  ) {
    if (type == DialogType.danger) {
      return AppButton.danger(
        label: label,
        expanded: true,
        height: 46,
        onPressed: () => Navigator.pop(ctx, result),
      );
    }
    return AppButton(
      label: label,
      expanded: true,
      height: 46,
      onPressed: () => Navigator.pop(ctx, result),
    );
  }
}

// ── Dialog widget ──────────────────────────────────────────────
class _AppDialogWidget<T> extends StatelessWidget {
  final String? title;
  final String? message;
  final DialogType type;
  final Widget? illustration;
  final Widget? body;
  final List<Widget> Function(BuildContext ctx)? actions;
  final double? maxWidth;
  final EdgeInsets? contentPadding;

  const _AppDialogWidget({
    this.title,
    this.message,
    this.type = DialogType.info,
    this.illustration,
    this.body,
    this.actions,
    this.maxWidth,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final config = _DialogConfig.of(type);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? 400),
        child: Container(
          decoration: BoxDecoration(
            color: isLight ? AppColors.surface : AppColors.darkCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isLight ? AppColors.borderLight : AppColors.darkBorder,
              width: 1,
            ),
          ),
          padding: contentPadding ?? const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Illustration / Icon ──────────────────────
              illustration ??
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: config.bgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(config.icon, color: config.color, size: 30),
                  ),
              const SizedBox(height: 20),

              // ── Title ────────────────────────────────────
              if (title != null) ...[
                AppText.large(
                  title!,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 8),
              ],

              // ── Message ──────────────────────────────────
              if (message != null) ...[
                AppText.medium(
                  message!,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  height: 1.5,
                ),
                const SizedBox(height: 24),
              ],

              // ── Custom body ───────────────────────────────
              if (body != null) ...[body!, const SizedBox(height: 24)],

              // ── Actions ───────────────────────────────────
              if (actions != null) Row(children: actions!(context)),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogConfig {
  final Color color;
  final Color bgColor;
  final IconData icon;
  const _DialogConfig({
    required this.color,
    required this.bgColor,
    required this.icon,
  });

  static _DialogConfig of(DialogType type) => switch (type) {
    DialogType.success => _DialogConfig(
      color: AppColors.success,
      bgColor: AppColors.successLight,
      icon: Icons.check_circle_outline_rounded,
    ),
    DialogType.warning => _DialogConfig(
      color: AppColors.warning,
      bgColor: AppColors.warningLight,
      icon: Icons.warning_amber_rounded,
    ),
    DialogType.danger => _DialogConfig(
      color: AppColors.error,
      bgColor: AppColors.errorLight,
      icon: Icons.delete_outline_rounded,
    ),
    DialogType.info => _DialogConfig(
      color: AppColors.primary,
      bgColor: AppColors.primary50,
      icon: Icons.info_outline_rounded,
    ),
  };
}
