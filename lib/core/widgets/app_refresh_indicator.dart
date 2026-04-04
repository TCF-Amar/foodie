import 'package:flutter/material.dart';

class CustomRefreshWrapper extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomRefreshWrapper({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<CustomRefreshWrapper> createState() => _CustomRefreshWrapperState();
}

class _CustomRefreshWrapperState extends State<CustomRefreshWrapper> {
  double _pullDistance = 0.0;
  bool _isRefreshing = false;

  static const double _triggerDistance = 120;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (_isRefreshing) return false;

            if (notification is OverscrollNotification) {
              if (notification.overscroll < 0) {
                setState(() {
                  _pullDistance += (-notification.overscroll);
                });
              }
            }

            if (notification is ScrollEndNotification) {
              if (_pullDistance > _triggerDistance) {
                _startRefresh();
              } else {
                _reset();
              }
            }

            return false;
          },
          child: widget.child,
        ),

        /// 🔴 Custom Indicator
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _buildIndicator(screenWidth),
        ),
      ],
    );
  }

  Widget _buildIndicator(double screenWidth) {
    final width = screenWidth * 0.4;

    /// pull progress (0 → 1)
    final progress = (_pullDistance / _triggerDistance).clamp(0.0, 1.0);

    if (_pullDistance == 0 && !_isRefreshing) {
      return const SizedBox();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: _isRefreshing
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _line(width / 2 - 4),
                  const SizedBox(width: 8),
                  _line(width / 2 - 4),
                ],
              )
            : _line(width * progress),
      ),
    );
  }

  Widget _line(double width) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 8,
      width: width,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Future<void> _startRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    await widget.onRefresh();

    _reset();
  }

  void _reset() {
    setState(() {
      _pullDistance = 0;
      _isRefreshing = false;
    });
  }
}