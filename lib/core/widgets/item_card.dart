import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodie/core/models/food_item_model.dart';
import 'package:foodie/core/widgets/index.dart';

class ItemCard extends StatelessWidget {
  final FoodItemModel item;
  final BorderRadius? borderRadius;
  const ItemCard({super.key, required this.item, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final savedAmount = item.price - item.effectivePrice;
    final hasDiscount = savedAmount > 0;
    final cardRadius = borderRadius ?? BorderRadius.circular(16);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: cardRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Image Section with overlaid name + desc ──────────────────
          Stack(
            children: [
              AppImage.network(
                item.images.isNotEmpty ? item.images.first : '',
                height: 240,
                width: double.infinity,
                borderRadius: BorderRadius.zero,
              ),

              // Dark gradient scrim at bottom
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.45, 1.0],
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.88),
                      ],
                    ),
                  ),
                ),
              ),

              // Veg/Non-Veg Indicator (top-left)

              // Item name + description overlaid on image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: item.isVeg
                                    ? AppColors.secondary500
                                    : AppColors.error,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.circle,
                                size: 8,
                                color: item.isVeg
                                    ? AppColors.secondary500
                                    : AppColors.error,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                shadows: [
                                  Shadow(blurRadius: 4, color: Colors.black54),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.description,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 13,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Dashed Separator ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomPaint(
              painter: _DashedLinePainter(
                color: Colors.white.withValues(alpha: 0.2),
              ),
              child: const SizedBox(height: 1, width: double.infinity),
            ),
          ),

          // ── Price + Action Bar ────────────────────────────────────────
          Container(
            color: const Color(0xFF1C1C1E),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Price info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "₹${item.effectivePrice.toInt()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          if (hasDiscount) ...[
                            const SizedBox(width: 8),
                            Text(
                              "₹${item.price.toInt()}",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.45),
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white54,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E7A3C),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "Save ₹${savedAmount.toInt()}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Crust / config row
                      Row(
                        children: [
                          Text(
                            "${item.categoryName} | Regular Crust",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.55),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.chevron_right,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.55),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Right: Add button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.add, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Dashed line painter for the separator
class _DashedLinePainter extends CustomPainter {
  final Color color;
  _DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    const dashWidth = 6.0;
    const dashSpace = 5.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashWidth, 0), paint);
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter old) => old.color != color;
}
