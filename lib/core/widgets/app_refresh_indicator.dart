import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:foodie/core/constant/colors/app_colors.dart';

class AppRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final double triggerDistance;
  final Color? color;

  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.triggerDistance = 130,
    this.color,
  });

  @override
  State<AppRefreshIndicator> createState() => _State();
}

class _State extends State<AppRefreshIndicator> with TickerProviderStateMixin {
  double _pull = 0;
  bool _refreshing = false;

  late final AnimationController _snapCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );
  late final AnimationController _dotCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  double get _progress => (_pull / widget.triggerDistance).clamp(0.0, 1.0);
  bool get _triggered => _pull >= widget.triggerDistance;
  double get _elastic => _pull <= 0
      ? 0
      : widget.triggerDistance * (1 - pow(0.5, _pull / widget.triggerDistance));
  double get _holdOffset => 56.0;

  // ── Dot bounce animations (staggered) ────────────────────────
  late final List<Animation<double>> _dots = List.generate(3, (i) {
    final s = (i * 0.2).clamp(0.0, 1.0);
    return TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: -10.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -10.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 60,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _dotCtrl,
        curve: Interval(s, (s + 0.5).clamp(0.0, 1.0)),
      ),
    );
  });

  bool _onScroll(ScrollNotification n) {
    if (_refreshing) return false;

    if (n is ScrollUpdateNotification) {
      if (n.metrics.pixels < 0) {
        setState(() => _pull = (-n.metrics.pixels).clamp(0.0, 160.0));
      } else if (_pull > 0 && n.scrollDelta != null) {
        setState(() => _pull = (_pull - n.scrollDelta!).clamp(0.0, 160.0));
      }
    } else if (n is OverscrollNotification) {
      if (n.metrics.pixels < 0) {
        setState(() => _pull = (-n.metrics.pixels).clamp(0.0, 160.0));
      } else {
        setState(() => _pull = (_pull - n.overscroll * 0.6).clamp(0.0, 160.0));
      }
    }

    if (n is ScrollEndNotification) _triggered ? _startRefresh() : _snapBack();
    return false;
  }

  Future<void> _startRefresh() async {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    _dotCtrl.repeat();
    await widget.onRefresh();
    _dotCtrl.stop();
    _dotCtrl.reset();
    await _snapBack(from: _holdOffset);
  }

  Future<void> _snapBack({double? from}) async {
    final start = from ?? _elastic;
    // ignore: unused_local_variable
    final anim = Tween<double>(begin: start, end: 0).animate(
      CurvedAnimation(
        parent: _snapCtrl,
        curve: from != null ? Curves.easeOutCubic : Curves.easeOutBack,
      ),
    );
    _snapCtrl.forward(from: 0).then((_) {
      if (mounted) {
        setState(() {
          _pull = 0;
          _refreshing = false;
        });
      }
      _snapCtrl.reset();
    });
    // Rebuild on anim tick
    _snapCtrl.addListener(() {
      if (mounted) setState(() {});
    });
  }

  double get _contentOffset {
    if (_refreshing) {
      return _snapCtrl.isAnimating
          ? Tween(begin: _holdOffset, end: 0.0).evaluate(_snapCtrl)
          : _holdOffset;
    }
    if (_snapCtrl.isAnimating) return _snapAnim;
    return _elastic;
  }

  double get _snapAnim => Tween<double>(
    begin: _elastic,
    end: 0,
  ).evaluate(CurvedAnimation(parent: _snapCtrl, curve: Curves.easeOutBack));

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final accent = widget.color ?? AppColors.primary;
    final bg = isLight ? AppColors.surface : AppColors.darkCard;
    final border = isLight ? AppColors.borderLight : AppColors.darkBorder;

    return Stack(
      children: [
        // ── Content ──────────────────────────────────────────────
        AnimatedBuilder(
          animation: _snapCtrl,
          builder: (_, child) => Transform.translate(
            offset: Offset(0, _contentOffset),
            child: child,
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: widget.child,
          ),
        ),

        // ── Indicator ────────────────────────────────────────────
        if (_pull > 0 || _refreshing)
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: ScaleTransition(scale: anim, child: child),
                ),
                child: _refreshing
                    ? _DotsWidget(
                        key: const ValueKey('d'),
                        dots: _dots,
                        color: accent,
                        bg: bg,
                        border: border,
                      )
                    : _ArcWidget(
                        key: const ValueKey('a'),
                        progress: _progress,
                        triggered: _triggered,
                        color: accent,
                        bg: bg,
                        border: border,
                      ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _snapCtrl.dispose();
    _dotCtrl.dispose();
    super.dispose();
  }
}

// ─────────────────────────────────────────────────
//  ARC WIDGET
// ─────────────────────────────────────────────────

class _ArcWidget extends StatelessWidget {
  final double progress;
  final bool triggered;
  final Color color, bg, border;

  const _ArcWidget({
    super.key,
    required this.progress,
    required this.triggered,
    required this.color,
    required this.bg,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    final t = Curves.easeInOut.transform(progress);

    const dotSize = 10.0;
    const pieceW0 = 22.0; // 3 × 22 = 66px = full bar width at start
    final pieceW = lerpDouble(pieceW0, dotSize, t)!;
    final gap = lerpDouble(0.0, 12.0, t)!;
    final innerRad = lerpDouble(0.0, dotSize / 2, t)!; // inner corners open up
    const outerRad = dotSize / 2; // outer ends always round

    return SizedBox(
      height: 44,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(3, (i) {
          // staggered lift — left dot rises first
          final liftT = ((t - i * 0.15) / 0.55).clamp(0.0, 1.0);
          final liftY = 24.0 * Curves.easeOut.transform(liftT);

          // at t=0: only outer ends rounded → seamless single bar
          final br = BorderRadius.horizontal(
            left: Radius.circular(i == 0 ? outerRad : innerRad),
            right: Radius.circular(i == 2 ? outerRad : innerRad),
          );

          return Transform.translate(
            offset: Offset(0, liftY),
            child: Container(
              width: pieceW,
              height: dotSize,
              margin: EdgeInsets.only(left: i == 0 ? 0 : gap),
              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: triggered ? 1.0 : 0.45 + 0.55 * t,
                ),
                borderRadius: br,
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────
//  DOTS WIDGET
// ─────────────────────────────────────────────────
class _DotsWidget extends StatelessWidget {
  final List<Animation<double>> dots;
  final Color color, bg, border;

  const _DotsWidget({
    super.key,
    required this.dots,
    required this.color,
    required this.bg,
    required this.border,
  });

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: dots.first,
    builder: (_, _) => Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        dots.length,
        (i) => Transform.translate(
          offset: Offset(0, dots[i].value),
          child: Container(
            width: i == 1 ? 9 : 7,
            height: i == 1 ? 9 : 7,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: i == 1 ? 1.0 : 0.65),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    ),
  );
}
