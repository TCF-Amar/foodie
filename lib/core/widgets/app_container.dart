import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget? child;

  // ── Size ──────────────────────────────────────
  final double? width;
  final double? height;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;

  // ── Padding & Margin ──────────────────────────
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  // ── Decoration ────────────────────────────────
  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final BoxBorder? border;
  final AppBorderSide borderSide;
  final List<double>? dashPattern; // null = solid border
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final DecorationImage? image;
  final BoxShape shape;
  final BlendMode? backgroundBlendMode;

  // ── Foreground ────────────────────────────────
  final Decoration? foregroundDecoration;

  // ── Transform ────────────────────────────────
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  // ── Alignment ────────────────────────────────
  final AlignmentGeometry? alignment;

  // ── Clip ─────────────────────────────────────
  final Clip clipBehavior;

  // ── Gesture ──────────────────────────────────
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;

  // ── Visibility & Opacity ─────────────────────
  final double opacity;
  final bool visible;

  // ── Flex ──────────────────────────────────────
  final bool expanded;
  final int? flex;

  // ── Variant ──────────────────────────────────
  final _ContainerVariant _variant;

  // ─────────────────────────────────────────────
  //  DEFAULT — blank slate
  // ─────────────────────────────────────────────
  const AppContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.margin,
    this.color,
    this.borderColor,
    this.borderWidth = 0,
    this.border,
    this.borderSide = AppBorderSide.all,
    this.dashPattern,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.image,
    this.shape = BoxShape.rectangle,
    this.backgroundBlendMode,
    this.foregroundDecoration,
    this.transform,
    this.transformAlignment,
    this.alignment,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.opacity = 1.0,
    this.visible = true,
    this.expanded = false,
    this.flex,
  }) : _variant = _ContainerVariant.plain;

  // ─────────────────────────────────────────────
  //  CARD — elevated card look
  // ─────────────────────────────────────────────
  const AppContainer.card({
    super.key,
    this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.color,
    this.borderColor,
    this.borderWidth = 1,
    this.border,
    this.borderSide = AppBorderSide.all,
    this.dashPattern,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.image,
    this.shape = BoxShape.rectangle,
    this.backgroundBlendMode,
    this.foregroundDecoration,
    this.transform,
    this.transformAlignment,
    this.alignment,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.opacity = 1.0,
    this.visible = true,
    this.expanded = false,
    this.flex,
  }) : _variant = _ContainerVariant.card;

  // ─────────────────────────────────────────────
  //  OUTLINED — transparent with border only
  // ─────────────────────────────────────────────
  const AppContainer.outlined({
    super.key,
    this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.color = Colors.transparent,
    this.borderColor,
    this.borderWidth = 1.5,
    this.border,
    this.borderSide = AppBorderSide.all,
    this.dashPattern,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.image,
    this.shape = BoxShape.rectangle,
    this.backgroundBlendMode,
    this.foregroundDecoration,
    this.transform,
    this.transformAlignment,
    this.alignment,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.opacity = 1.0,
    this.visible = true,
    this.expanded = false,
    this.flex,
  }) : _variant = _ContainerVariant.outlined;

  // ─────────────────────────────────────────────
  //  FILLED — solid primary color background
  // ─────────────────────────────────────────────
  const AppContainer.filled({
    super.key,
    this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.color,
    this.borderColor,
    this.borderWidth = 0,
    this.border,
    this.borderSide = AppBorderSide.all,
    this.dashPattern,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.image,
    this.shape = BoxShape.rectangle,
    this.backgroundBlendMode,
    this.foregroundDecoration,
    this.transform,
    this.transformAlignment,
    this.alignment,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.opacity = 1.0,
    this.visible = true,
    this.expanded = false,
    this.flex,
  }) : _variant = _ContainerVariant.filled;

  // ─────────────────────────────────────────────
  //  CIRCLE — perfect circle container
  // ─────────────────────────────────────────────
  const AppContainer.circle({
    super.key,
    this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding = const EdgeInsets.all(8),
    this.margin = const EdgeInsets.all(0),
    this.color,
    this.borderColor,
    this.borderWidth = 0,
    this.border,
    this.borderSide = AppBorderSide.all,
    this.dashPattern,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.image,
    this.shape = BoxShape.circle,
    this.backgroundBlendMode,
    this.foregroundDecoration,
    this.transform,
    this.transformAlignment,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.opacity = 1.0,
    this.visible = true,
    this.expanded = false,
    this.flex,
  }) : _variant = _ContainerVariant.circle;

  // ─────────────────────────────────────────────
  //  PILL — fully rounded horizontal container
  // ─────────────────────────────────────────────
  const AppContainer.pill({
    super.key,
    this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.margin = const EdgeInsets.all(0),
    this.color,
    this.borderColor,
    this.borderWidth = 0,
    this.border,
    this.borderSide = AppBorderSide.all,
    this.dashPattern,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.image,
    this.shape = BoxShape.rectangle,
    this.backgroundBlendMode,
    this.foregroundDecoration,
    this.transform,
    this.transformAlignment,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.opacity = 1.0,
    this.visible = true,
    this.expanded = false,
    this.flex,
  }) : _variant = _ContainerVariant.pill;

  // ─────────────────────────────────────────────
  //  DASHED — dashed border container
  // ─────────────────────────────────────────────
  const AppContainer.dashed({
    super.key,
    this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.color = Colors.transparent,
    this.borderColor,
    this.borderWidth = 1.5,
    this.border,
    this.borderSide = AppBorderSide.all,
    this.dashPattern = const [6, 4],
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.image,
    this.shape = BoxShape.rectangle,
    this.backgroundBlendMode,
    this.foregroundDecoration,
    this.transform,
    this.transformAlignment,
    this.alignment,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.opacity = 1.0,
    this.visible = true,
    this.expanded = false,
    this.flex,
  }) : _variant = _ContainerVariant.dashed;

  // ─────────────────────────────────────────────
  //  GRADIENT — gradient background
  // ─────────────────────────────────────────────
  const AppContainer.gradient({
    super.key,
    this.child,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.color,
    this.borderColor,
    this.borderWidth = 0,
    this.border,
    this.borderSide = AppBorderSide.all,
    this.dashPattern,
    this.borderRadius,
    this.boxShadow,
    required this.gradient,
    this.image,
    this.shape = BoxShape.rectangle,
    this.backgroundBlendMode,
    this.foregroundDecoration,
    this.transform,
    this.transformAlignment,
    this.alignment,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.opacity = 1.0,
    this.visible = true,
    this.expanded = false,
    this.flex,
  }) : _variant = _ContainerVariant.gradientBox;

  // ─────────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // ── Resolve variant defaults ───────────────
    final resolvedColor = color ?? _defaultColor(colorScheme);
    final resolvedBorderColor = borderColor ?? _defaultBorderColor(colorScheme);
    final resolvedBorderRadius = borderRadius ?? _defaultBorderRadius();
    final resolvedBoxShadow = boxShadow ?? _defaultBoxShadow(colorScheme);

    // ── Constraints ───────────────────────────
    BoxConstraints? constraints;
    if (minWidth != null ||
        maxWidth != null ||
        minHeight != null ||
        maxHeight != null) {
      constraints = BoxConstraints(
        minWidth: minWidth ?? 0.0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0.0,
        maxHeight: maxHeight ?? double.infinity,
      );
    }

    // ── Border ────────────────────────────────
    BoxBorder? resolvedBorder = border;
    if (resolvedBorder == null && borderWidth > 0 && dashPattern == null) {
      if (borderSide == AppBorderSide.all) {
        resolvedBorder = Border.all(color: resolvedBorderColor, width: borderWidth);
      } else if (borderSide != AppBorderSide.none) {
        final side = BorderSide(color: resolvedBorderColor, width: borderWidth);
        resolvedBorder = Border(
          top: (borderSide == AppBorderSide.top ||
                  borderSide == AppBorderSide.topBottom)
              ? side
              : BorderSide.none,
          bottom: (borderSide == AppBorderSide.bottom ||
                  borderSide == AppBorderSide.topBottom)
              ? side
              : BorderSide.none,
          left: (borderSide == AppBorderSide.left ||
                  borderSide == AppBorderSide.leftRight)
              ? side
              : BorderSide.none,
          right: (borderSide == AppBorderSide.right ||
                  borderSide == AppBorderSide.leftRight)
              ? side
              : BorderSide.none,
        );
      }
    }

    // ── Decoration ────────────────────────────
    final decoration = BoxDecoration(
      color: gradient != null ? null : resolvedColor,
      border: resolvedBorder,
      borderRadius: shape == BoxShape.circle ? null : resolvedBorderRadius,
      boxShadow: resolvedBoxShadow,
      gradient: gradient,
      image: image,
      shape: shape,
      backgroundBlendMode: backgroundBlendMode,
    );

    // ── Core container ────────────────────────
    Widget core = Container(
      width: width,
      height: height,
      padding: padding,
      margin: dashPattern != null ? null : margin,
      alignment: alignment,
      clipBehavior: clipBehavior,
      constraints: constraints,
      transform: transform,
      transformAlignment: transformAlignment,
      foregroundDecoration: foregroundDecoration,
      decoration: decoration,
      child: child,
    );

    // ── Dashed border wrapper ─────────────────
    if (dashPattern != null) {
      core = Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: resolvedBorderColor,
            strokeWidth: borderWidth,
            dashPattern: dashPattern!,
            borderRadius: shape == BoxShape.circle
                ? null
                : resolvedBorderRadius,
            shape: shape,
          ),
          child: core,
        ),
      );
    }

    // ── Opacity ───────────────────────────────
    if (opacity < 1.0) {
      core = Opacity(opacity: opacity.clamp(0.0, 1.0), child: core);
    }

    // ── Visibility ────────────────────────────
    if (!visible) {
      core = Visibility(visible: false, child: core);
    }

    // ── Gesture ───────────────────────────────
    if (onTap != null || onLongPress != null || onDoubleTap != null) {
      core = GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        behavior: HitTestBehavior.opaque,
        child: core,
      );
    }

    // ── Expanded / Flex ───────────────────────
    if (expanded) {
      core = Expanded(flex: flex ?? 1, child: core);
    }

    return core;
  }

  // ─────────────────────────────────────────────
  //  VARIANT DEFAULTS
  // ─────────────────────────────────────────────
  Color _defaultColor(ColorScheme cs) {
    switch (_variant) {
      case _ContainerVariant.card:
        return cs.surface;
      case _ContainerVariant.filled:
        return cs.primary;
      case _ContainerVariant.outlined:
        return Colors.transparent;
      case _ContainerVariant.circle:
        return cs.primaryContainer;
      case _ContainerVariant.pill:
        return cs.primaryContainer;
      case _ContainerVariant.dashed:
        return Colors.transparent;
      case _ContainerVariant.gradientBox:
        return Colors.transparent;
      case _ContainerVariant.plain:
        return Colors.transparent;
    }
  }

  Color _defaultBorderColor(ColorScheme cs) {
    switch (_variant) {
      case _ContainerVariant.outlined:
        return cs.outline;
      case _ContainerVariant.dashed:
        return cs.outline;
      case _ContainerVariant.card:
        return cs.outlineVariant;
      default:
        return Colors.transparent;
    }
  }

  BorderRadius _defaultBorderRadius() {
    switch (_variant) {
      case _ContainerVariant.pill:
        return BorderRadius.circular(999);
      case _ContainerVariant.card:
        return BorderRadius.circular(12);
      case _ContainerVariant.filled:
        return BorderRadius.circular(12);
      case _ContainerVariant.outlined:
        return BorderRadius.circular(12);
      case _ContainerVariant.dashed:
        return BorderRadius.circular(8);
      case _ContainerVariant.gradientBox:
        return BorderRadius.circular(8);
      default:
        return BorderRadius.circular(0);
    }
  }

  List<BoxShadow>? _defaultBoxShadow(ColorScheme cs) {
    switch (_variant) {
      case _ContainerVariant.card:
        return [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.06),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ];
      default:
        return null;
    }
  }
}

// ─────────────────────────────────────────────────
//  ENUM
// ─────────────────────────────────────────────────
enum _ContainerVariant {
  plain,
  card,
  outlined,
  filled,
  circle,
  pill,
  dashed,
  gradientBox,
}

// ─────────────────────────────────────────────────
//  DASHED BORDER PAINTER
// ─────────────────────────────────────────────────
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = _buildPath(size);
    final dashedPath = _buildDashedPath(path);
    canvas.drawPath(dashedPath, paint);
  }

  Path _buildPath(Size size) {
    if (shape == BoxShape.circle) {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = (size.width < size.height ? size.width : size.height) / 2;
      return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
    }
    final rect = Offset.zero & size;
    if (borderRadius != null) {
      return Path()..addRRect(borderRadius!.toRRect(rect));
    }
    return Path()..addRect(rect);
  }

  Path _buildDashedPath(Path source) {
    final metric = source.computeMetrics().first;
    final total = metric.length;
    final result = Path();
    double distance = 0;
    int i = 0;

    while (distance < total) {
      final dash = dashPattern[i % dashPattern.length];
      final gap = dashPattern[(i + 1) % dashPattern.length];
      final end = (distance + dash).clamp(0.0, total);
      result.addPath(metric.extractPath(distance, end), Offset.zero);
      distance += dash + gap;
      i += 2;
    }
    return result;
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.dashPattern != dashPattern ||
      old.borderRadius != borderRadius;
}

// ─────────────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────────────
enum AppBorderSide { all, top, bottom, left, right, topBottom, leftRight, none }
