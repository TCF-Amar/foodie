// app_loader.dart
import 'package:foodie/core/constant/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'app_text.dart';

class AppLoader extends StatelessWidget {
  // ── Variant ───────────────────────────────────────────────────
  final _LoaderVariant _variant;

  // ── Config ────────────────────────────────────────────────────
  final double size;
  final Color? color;
  final double strokeWidth;
  final String? message;
  final bool overlay;
  final Color? overlayColor;

  // ─── Spinner ──────────────────────────────────────────────────
  const AppLoader({
    super.key,
    this.size = 36,
    this.color,
    this.strokeWidth = 3,
    this.message,
    this.overlay = false,
    this.overlayColor,
  }) : _variant = _LoaderVariant.spinner;

  // ── Small inline spinner ──────────────────────────────────────
  const AppLoader.small({
    super.key,
    this.size = 20,
    this.color,
    this.strokeWidth = 2.5,
    this.message,
    this.overlay = false,
    this.overlayColor,
  }) : _variant = _LoaderVariant.spinner;

  // ── Full screen overlay ───────────────────────────────────────
  const AppLoader.overlay({
    super.key,
    this.size = 40,
    this.color,
    this.strokeWidth = 3,
    this.message,
    this.overlay = true,
    this.overlayColor,
  }) : _variant = _LoaderVariant.spinner;

  // ── Shimmer box ───────────────────────────────────────────────
  const AppLoader.shimmer({
    super.key,
    this.size = 0,
    this.color,
    this.strokeWidth = 0,
    this.message,
    this.overlay = false,
    this.overlayColor,
  }) : _variant = _LoaderVariant.shimmer;

  // ── Static show / hide helpers (overlay) ──────────────────────
  static OverlayEntry? _entry;

  static void show(BuildContext context, {String? message}) {
    _entry?.remove();
    _entry = OverlayEntry(builder: (_) => const AppLoader.overlay());
    Overlay.of(context).insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final spinColor = color ?? AppColors.primary;

    if (_variant == _LoaderVariant.shimmer) {
      return const _ShimmerBox();
    }

    final spinner = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(spinColor),
            strokeCap: StrokeCap.round,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 14),
          AppText.small(message!, textAlign: TextAlign.center),
        ],
      ],
    );

    if (!overlay) return spinner;

    return Positioned.fill(
      child: ColoredBox(
        color:
            overlayColor ??
            (isLight ? AppColors.overlay10 : Colors.black.withOpacity(0.55)),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            decoration: BoxDecoration(
              color: isLight ? AppColors.surface : AppColors.darkCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isLight ? AppColors.borderLight : AppColors.darkBorder,
              ),
            ),
            child: spinner,
          ),
        ),
      ),
    );
  }
}

// ── Shimmer box ────────────────────────────────────────────────
class _ShimmerBox extends StatefulWidget {
  const _ShimmerBox();
  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _anim = Tween<double>(
      begin: -1.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final base = isLight ? AppColors.shimmerBase : AppColors.darkCard;
    final highlight = isLight
        ? AppColors.shimmerHighlight
        : AppColors.darkElevated;

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [base, highlight, base],
          stops: const [0.0, 0.5, 1.0],
          transform: _SlideGradient(_anim.value),
        ).createShader(bounds),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bar(double.infinity, 18),
            const SizedBox(height: 10),
            _bar(double.infinity, 14),
            const SizedBox(height: 6),
            _bar(200, 14),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _bar(double.infinity, 80)),
                const SizedBox(width: 12),
                Expanded(child: _bar(double.infinity, 80)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar(double width, double height) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: AppColors.shimmerBase,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class _SlideGradient extends GradientTransform {
  final double value;
  const _SlideGradient(this.value);
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * value, 0, 0);
}

enum _LoaderVariant { spinner, shimmer }
