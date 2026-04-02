// app_tooltip.dart
import 'package:calling_app/core/constant/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final TooltipPosition position;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize;
  final EdgeInsets? padding;
  final Duration waitDuration;
  final Duration showDuration;
  final bool preferBelow;

  const AppTooltip({
    super.key,
    required this.child,
    required this.message,
    this.position = TooltipPosition.below,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.fontSize,
    this.padding,
    this.waitDuration = const Duration(milliseconds: 500),
    this.showDuration = const Duration(seconds: 2),
    this.preferBelow = true,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final family = Theme.of(context).textTheme.bodyLarge?.fontFamily;

    return Tooltip(
      message: message,
      preferBelow: position == TooltipPosition.below,
      waitDuration: waitDuration,
      showDuration: showDuration,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isLight ? const Color(0xFF1A1625) : AppColors.darkElevated),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      textStyle: TextStyle(
        fontFamily: family,
        fontSize: fontSize ?? 12,
        fontWeight: FontWeight.w500,
        color: textColor ?? Colors.white,
      ),
      child: child,
    );
  }
}

enum TooltipPosition { above, below }
