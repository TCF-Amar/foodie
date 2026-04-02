import 'package:flutter/material.dart';
import 'package:calling_app/core/constant/colors/app_colors.dart';

class AppButton extends StatelessWidget {
  // ── Content ───────────────────────────────────────────────────
  final String? label;
  final Widget? child;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double iconSpacing;

  // ── Size ──────────────────────────────────────────────────────
  final double? width;
  final double? height;
  final double? minWidth;
  final EdgeInsetsGeometry? padding;

  // ── Style Overrides ───────────────────────────────────────────
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? splashColor;
  final Color? overlayColor;
  final Gradient? gradient;
  final double? borderRadius;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;
  final double? elevation;

  // ── Text Style ────────────────────────────────────────────────
  final TextStyle? textStyle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;

  // ── State ─────────────────────────────────────────────────────
  final bool enabled;
  final bool loading;
  final bool expanded;

  // ── Loading Widget ────────────────────────────────────────────
  final Widget? loadingWidget;
  final Color? loadingColor;
  final double loadingSize;

  // ── Callbacks ─────────────────────────────────────────────────
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  // ── Variant ───────────────────────────────────────────────────
  final _ButtonVariant _variant;

  // ─────────────────────────────────────────────
  //  PRIMARY — filled violet
  // ─────────────────────────────────────────────
  const AppButton({
    super.key,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 8,
    this.width,
    this.height = 52,
    this.minWidth,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.overlayColor,
    this.gradient,
    this.borderRadius,
    this.borderWidth = 0,
    this.boxShadow,
    this.elevation = 0,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize = 20,
    this.onPressed,
    this.onLongPress,
  }) : _variant = _ButtonVariant.primary;

  // ─────────────────────────────────────────────
  //  SECONDARY — outlined violet
  // ─────────────────────────────────────────────
  const AppButton.outlined({
    super.key,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 8,
    this.width,
    this.height = 52,
    this.minWidth,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.overlayColor,
    this.gradient,
    this.borderRadius,
    this.borderWidth = 1.5,
    this.boxShadow,
    this.elevation = 0,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize = 20,
    this.onPressed,
    this.onLongPress,
  }) : _variant = _ButtonVariant.outlined;

  // ─────────────────────────────────────────────
  //  GHOST — transparent, no border
  // ─────────────────────────────────────────────
  const AppButton.ghost({
    super.key,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 8,
    this.width,
    this.height = 52,
    this.minWidth,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.overlayColor,
    this.gradient,
    this.borderRadius,
    this.borderWidth = 0,
    this.boxShadow,
    this.elevation = 0,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize = 20,
    this.onPressed,
    this.onLongPress,
  }) : _variant = _ButtonVariant.ghost;

  // ─────────────────────────────────────────────
  //  SOFT — tinted background, no border
  // ─────────────────────────────────────────────
  const AppButton.soft({
    super.key,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 8,
    this.width,
    this.height = 52,
    this.minWidth,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.overlayColor,
    this.gradient,
    this.borderRadius,
    this.borderWidth = 0,
    this.boxShadow,
    this.elevation = 0,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize = 20,
    this.onPressed,
    this.onLongPress,
  }) : _variant = _ButtonVariant.soft;

  // ─────────────────────────────────────────────
  //  GRADIENT
  // ─────────────────────────────────────────────
  const AppButton.gradient({
    super.key,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 8,
    this.width,
    this.height = 52,
    this.minWidth,
    this.padding,
    this.backgroundColor,
    this.foregroundColor = AppColors.textOnPrimary,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.overlayColor,
    this.gradient = const LinearGradient(
      colors: [AppColors.primary, Color(0xFF6D3EE8)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    this.borderRadius,
    this.borderWidth = 0,
    this.boxShadow,
    this.elevation = 0,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize = 20,
    this.onPressed,
    this.onLongPress,
  }) : _variant = _ButtonVariant.gradientBtn;

  // ─────────────────────────────────────────────
  //  DANGER — error/red
  // ─────────────────────────────────────────────
  const AppButton.danger({
    super.key,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 8,
    this.width,
    this.height = 52,
    this.minWidth,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.overlayColor,
    this.gradient,
    this.borderRadius,
    this.borderWidth = 0,
    this.boxShadow,
    this.elevation = 0,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize = 20,
    this.onPressed,
    this.onLongPress,
  }) : _variant = _ButtonVariant.danger;

  // ─────────────────────────────────────────────
  //  SUCCESS — green
  // ─────────────────────────────────────────────
  const AppButton.success({
    super.key,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 8,
    this.width,
    this.height = 52,
    this.minWidth,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.overlayColor,
    this.gradient,
    this.borderRadius,
    this.borderWidth = 0,
    this.boxShadow,
    this.elevation = 0,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize = 20,
    this.onPressed,
    this.onLongPress,
  }) : _variant = _ButtonVariant.success;

  // ─────────────────────────────────────────────
  //  ICON ONLY — square / circle
  // ─────────────────────────────────────────────
  const AppButton.icon({
    super.key,
    required Widget icon,
    this.label,
    this.child,
    this.suffixIcon,
    this.iconSpacing = 0,
    this.width = 48,
    this.height = 48,
    this.minWidth,
    this.padding = const EdgeInsets.all(0),
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.overlayColor,
    this.gradient,
    this.borderRadius = 14,
    this.borderWidth = 0,
    this.boxShadow,
    this.elevation = 0,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize = 20,
    this.onPressed,
    this.onLongPress,
  }) : prefixIcon = icon,
       _variant = _ButtonVariant.iconOnly;

  // ─────────────────────────────────────────────
  //  SMALL — compact pill button
  // ─────────────────────────────────────────────
  const AppButton.small({
    super.key,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 6,
    this.width,
    this.height = 36,
    this.minWidth,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.overlayColor,
    this.gradient,
    this.borderRadius = 10,
    this.borderWidth = 0,
    this.boxShadow,
    this.elevation = 0,
    this.textStyle,
    this.fontSize = 13,
    this.fontWeight = FontWeight.w600,
    this.letterSpacing,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize = 14,
    this.onPressed,
    this.onLongPress,
  }) : _variant = _ButtonVariant.small;

  // ─────────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final isActive = enabled && !loading;

    // ── Resolved colors per variant ──────────────────────────
    final bg = backgroundColor ?? _defaultBg(isLight);
    final fg = foregroundColor ?? _defaultFg(isLight);
    final bc = borderColor ?? _defaultBorderColor(isLight);

    final disabledBg =
        disabledBackgroundColor ??
        (isLight ? AppColors.borderLight : AppColors.darkBorder);
    final disabledFg =
        disabledForegroundColor ??
        (isLight ? AppColors.textDisabled : AppColors.darkTextHint);

    final resolvedRadius = borderRadius ?? _defaultRadius;
    final resolvedPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 0);

    // ── Text style ───────────────────────────────────────────
    final resolvedTextStyle =
        (textStyle ??
                TextStyle(
                  fontFamily: theme.textTheme.bodyLarge?.fontFamily,
                  fontSize: fontSize ?? 15,
                  fontWeight: fontWeight ?? FontWeight.w700,
                  letterSpacing: letterSpacing ?? 0.2,
                ))
            .copyWith(color: isActive ? fg : disabledFg);

    // ── Button content ───────────────────────────────────────
    Widget content = loading
        ? loadingWidget ??
              SizedBox(
                width: loadingSize,
                height: loadingSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(loadingColor ?? fg),
                ),
              )
        : _buildContent(resolvedTextStyle, isActive ? fg : disabledFg);

    // ── Gradient wrapper ─────────────────────────────────────
    final hasGradient = gradient != null && isActive;

    // ── Core button ──────────────────────────────────────────
    Widget button = SizedBox(
      width: _variant == _ButtonVariant.iconOnly ? width : null,
      height: height,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        onLongPress: isActive ? onLongPress : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: hasGradient
              ? Colors.transparent
              : (isActive ? bg : disabledBg),
          foregroundColor: isActive ? fg : disabledFg,
          disabledBackgroundColor: hasGradient
              ? Colors.transparent
              : disabledBg,
          disabledForegroundColor: disabledFg,
          elevation: hasGradient ? 0 : (elevation ?? 0),
          shadowColor: Colors.transparent,
          padding: resolvedPadding,
          minimumSize: Size(
            minWidth ?? (_variant == _ButtonVariant.iconOnly ? width ?? 48 : 0),
            height ?? 52,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(resolvedRadius),
            side: borderWidth > 0
                ? BorderSide(
                    color: isActive ? bc : disabledBg,
                    width: borderWidth,
                  )
                : BorderSide.none,
          ),
          //   overlayColor: WidgetStateProperty.resolveWith((states) {
          //     if (states.contains(WidgetState.pressed)) {
          //       return overlayColor ?? fg.withOpacity(0.12);
          //     }
          //     if (states.contains(WidgetState.hovered)) {
          //       return overlayColor ?? fg.withOpacity(0.06);
          //     }
          //     return null;
          //   }),
        ),
        child: content,
      ),
    );

    // ── Gradient clip ────────────────────────────────────────
    if (hasGradient) {
      button = DecoratedBox(
        decoration: BoxDecoration(
          gradient: isActive ? gradient : null,
          color: isActive ? null : disabledBg,
          borderRadius: BorderRadius.circular(resolvedRadius),
          boxShadow: boxShadow,
        ),
        child: button,
      );
    } else if (boxShadow != null) {
      button = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(resolvedRadius),
          boxShadow: boxShadow,
        ),
        child: button,
      );
    }

    // ── Expanded ─────────────────────────────────────────────
    if (expanded) {
      button = SizedBox(width: double.infinity, child: button);
    } else if (width != null && _variant != _ButtonVariant.iconOnly) {
      button = SizedBox(width: width, child: button);
    }

    return button;
  }

  // ── Content builder ───────────────────────────────────────────
  Widget _buildContent(TextStyle style, Color iconColor) {
    final hasLabel = label != null || child != null;
    final labelWidget =
        child ?? (label != null ? Text(label!, style: style) : null);

    if (_variant == _ButtonVariant.iconOnly) {
      return prefixIcon ?? const SizedBox.shrink();
    }

    if (prefixIcon == null && suffixIcon == null) {
      return labelWidget ?? const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          IconTheme(
            data: IconThemeData(color: iconColor, size: 18),
            child: prefixIcon!,
          ),
          if (hasLabel) SizedBox(width: iconSpacing),
        ],
        if (labelWidget != null) Flexible(child: labelWidget),
        if (suffixIcon != null) ...[
          if (hasLabel) SizedBox(width: iconSpacing),
          IconTheme(
            data: IconThemeData(color: iconColor, size: 18),
            child: suffixIcon!,
          ),
        ],
      ],
    );
  }

  // ── Variant defaults ──────────────────────────────────────────
  Color _defaultBg(bool isLight) => switch (_variant) {
    _ButtonVariant.primary => AppColors.primary,
    _ButtonVariant.outlined => Colors.transparent,
    _ButtonVariant.ghost => Colors.transparent,
    _ButtonVariant.soft => isLight ? AppColors.primary50 : AppColors.primary800,
    _ButtonVariant.gradientBtn => AppColors.primary,
    _ButtonVariant.danger => AppColors.error,
    _ButtonVariant.success => AppColors.success,
    _ButtonVariant.iconOnly =>
      isLight ? AppColors.bgSecondary : AppColors.darkCard,
    _ButtonVariant.small => AppColors.primary,
  };

  Color _defaultFg(bool isLight) => switch (_variant) {
    _ButtonVariant.primary => AppColors.textOnPrimary,
    _ButtonVariant.outlined => AppColors.primary,
    _ButtonVariant.ghost => AppColors.primary,
    _ButtonVariant.soft => AppColors.primary,
    _ButtonVariant.gradientBtn => AppColors.textOnPrimary,
    _ButtonVariant.danger => AppColors.textOnPrimary,
    _ButtonVariant.success =>
      isLight ? AppColors.secondary900 : AppColors.textOnDark,
    _ButtonVariant.iconOnly =>
      isLight ? AppColors.textSecondary : AppColors.darkTextSecondary,
    _ButtonVariant.small => AppColors.textOnPrimary,
  };

  Color _defaultBorderColor(bool isLight) => switch (_variant) {
    _ButtonVariant.outlined => AppColors.primary,
    _ButtonVariant.danger => AppColors.error,
    _ButtonVariant.success => AppColors.success,
    _ButtonVariant.iconOnly =>
      isLight ? AppColors.borderLight : AppColors.darkBorder,
    _ => Colors.transparent,
  };

  double get _defaultRadius => switch (_variant) {
    _ButtonVariant.small => 10,
    _ButtonVariant.iconOnly => 14,
    _ => 14,
  };
}

// ─────────────────────────────────────────────────
//  ENUM
// ─────────────────────────────────────────────────
enum _ButtonVariant {
  primary,
  outlined,
  ghost,
  soft,
  gradientBtn,
  danger,
  success,
  iconOnly,
  small,
}
