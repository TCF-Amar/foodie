import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/core/constant/colors/app_colors.dart';

/// A modern, circular pull-to-refresh indicator with smooth animations
class ModernRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final double triggerDistance;
  final Color? color;
  final bool enableHaptic;

  const ModernRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.triggerDistance = 120,
    this.color,
    this.enableHaptic = true,
  });

  @override
  State<ModernRefreshIndicator> createState() => _ModernRefreshIndicatorState();
}

class _ModernRefreshIndicatorState extends State<ModernRefreshIndicator>
    with TickerProviderStateMixin {
  double _pullDistance = 0;
  bool _isRefreshing = false;
  bool _isTriggered = false;

  late final AnimationController _rotationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  late final AnimationController _shrinkController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  double get _progress =>
      (_pullDistance / widget.triggerDistance).clamp(0.0, 1.0);
  double get _elasticOffset {
    if (_pullDistance <= 0) return 0;
    return widget.triggerDistance *
        (1 - pow(0.5, _pullDistance / widget.triggerDistance));
  }

  @override
  void initState() {
    super.initState();
    _rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotationController.repeat();
      }
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (_isRefreshing) return false;

    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.pixels < 0) {
        setState(() {
          _pullDistance = (-notification.metrics.pixels).clamp(0.0, 200.0);
        });
      } else if (_pullDistance > 0 && notification.scrollDelta != null) {
        setState(() {
          _pullDistance = (_pullDistance - notification.scrollDelta!).clamp(
            0.0,
            200.0,
          );
        });
      }
    } else if (notification is OverscrollNotification) {
      setState(() {
        _pullDistance = (_pullDistance - notification.overscroll * 0.5).clamp(
          0.0,
          200.0,
        );
      });
    } else if (notification is ScrollEndNotification) {
      final wasTriggered = _isTriggered;
      _isTriggered = _pullDistance >= widget.triggerDistance;

      if (wasTriggered != _isTriggered && _isTriggered && widget.enableHaptic) {
        HapticFeedback.lightImpact();
      }

      if (_isTriggered) {
        _startRefresh();
      } else {
        _snapBack();
      }
    }

    return false;
  }

  Future<void> _startRefresh() async {
    if (_isRefreshing) return;

    setState(() => _isRefreshing = true);
    _rotationController.repeat();
    _shrinkController.forward();

    if (widget.enableHaptic) {
      HapticFeedback.mediumImpact();
    }

    try {
      await widget.onRefresh();
    } finally {
      _rotationController.stop();
      _rotationController.reset();
      _shrinkController.reverse();

      await Future.delayed(const Duration(milliseconds: 200));

      if (mounted) {
        setState(() {
          _isRefreshing = false;
          _pullDistance = 0;
          _isTriggered = false;
        });
      }
    }
  }

  Future<void> _snapBack() async {
    final completer = Completer<void>();
    _shrinkController.reverse().then((_) => completer.complete());
    await completer.future;

    if (mounted) {
      setState(() => _pullDistance = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.color ?? AppColors.primary;

    return Stack(
      children: [
        // Content with offset
        AnimatedBuilder(
          animation: _shrinkController,
          builder: (_, child) {
            // Only animate offset when pulling, not when refreshing
            final offset = _isRefreshing
                ? 60.0 // Fixed position while refreshing
                : _elasticOffset;
            return Transform.translate(offset: Offset(0, offset), child: child);
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: widget.child,
          ),
        ),

        // Refresh indicator
        if (_pullDistance > 0 || _isRefreshing)
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: AlwaysStoppedAnimation(_pullDistance > 0 ? 1.0 : 0.0),
              child: Center(child: _buildIndicator(accentColor)),
            ),
          ),
      ],
    );
  }

  Widget _buildIndicator(Color accentColor) {
    final size = 40.0;
    final strokeWidth = 3.0;

    return AnimatedBuilder(
      animation: _shrinkController,
      builder: (_, __) {
        final scale = _isRefreshing ? 0.6 + 0.4 * _shrinkController.value : 1.0;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accentColor.withValues(alpha: 0.1),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Center(
              child: _isRefreshing
                  ? RotationTransition(
                      turns: _rotationController,
                      child: SizedBox(
                        width: size * 0.6,
                        height: size * 0.6,
                        child: CircularProgressIndicator(
                          strokeWidth: strokeWidth,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            accentColor,
                          ),
                        ),
                      ),
                    )
                  : CustomPaint(
                      size: Size(size, size),
                      painter: _ArcPainter(
                        progress: _progress,
                        color: accentColor,
                        triggered: _isTriggered,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _shrinkController.dispose();
    super.dispose();
  }
}

// ─────────────────────────────────────────────────
//  ARC PAINTER FOR PULLING STATE
// ─────────────────────────────────────────────────
class _ArcPainter extends CustomPainter {
  final double progress;
  final bool triggered;
  final Color color;

  const _ArcPainter({
    required this.progress,
    required this.triggered,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    // Background circle
    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * progress;

    if (progress > 0.05) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        sweepAngle,
        false,
        arcPaint,
      );

      // Arrow head when triggered
      if (triggered && progress > 0.1) {
        final angle = -pi / 2 + sweepAngle;
        final tipX = center.dx + radius * cos(angle);
        final tipY = center.dy + radius * sin(angle);

        final arrowPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

        final arrowSize = 4.0;
        canvas.drawPath(
          Path()
            ..moveTo(tipX, tipY)
            ..lineTo(
              tipX + arrowSize * cos(angle - pi / 4),
              tipY + arrowSize * sin(angle - pi / 4),
            )
            ..lineTo(
              tipX + arrowSize * cos(angle + pi / 4),
              tipY + arrowSize * sin(angle + pi / 4),
            )
            ..close(),
          arrowPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.triggered != triggered ||
      oldDelegate.color != color;
}
