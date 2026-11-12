import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

/// A reusable, pixel-perfect category card matching the reference design.
/// Consists of a rounded soft-toned card with food icon/image and a title below.
class CategoryCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final Widget? customIcon;
  final IconData? iconData;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final double cardSize;
  final double imageSize;

  const CategoryCard({
    super.key,
    required this.title,
    this.imagePath,
    this.customIcon,
    this.iconData,
    this.isSelected = false,
    this.onTap,
    this.backgroundColor = const Color(0xFFFFF6EE),
    this.cardSize = 74.0,
    this.imageSize = 44.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (customIcon != null) {
      content = customIcon!;
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      content = Image.asset(
        imagePath!,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.fastfood_rounded,
          size: imageSize * 0.7,
          color: AppColor.primary,
        ),
      );
    } else if (iconData != null) {
      content = Icon(
        iconData,
        size: imageSize * 0.7,
        color: isSelected ? AppColor.primary : AppColor.textDark,
      );
    } else {
      content = const Icon(
        Icons.restaurant_rounded,
        color: AppColor.primary,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: cardSize,
              height: cardSize,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primary.withValues(alpha: 0.12)
                    : backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppColor.primary
                      : Colors.transparent,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColor.primary.withValues(alpha: 0.18),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: content,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? AppColor.primary : AppColor.textDark,
          ),
        ),
      ],
    );
  }
}

/// A custom painted gift box widget replicating the "Offers" category icon in the design.
class OffersGiftBoxIcon extends StatelessWidget {
  final double size;

  const OffersGiftBoxIcon({super.key, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GiftBoxPainter(),
      ),
    );
  }
}

class _GiftBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()
      ..color = const Color(0xFFFFCC33)
      ..style = PaintingStyle.fill;

    final boxShadowPaint = Paint()
      ..color = const Color(0xFFF5B800)
      ..style = PaintingStyle.fill;

    final ribbonPaint = Paint()
      ..color = const Color(0xFFF55B61)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Box dimensions
    final boxLeft = w * 0.18;
    final boxRight = w * 0.82;
    final boxWidth = boxRight - boxLeft;
    final boxTop = h * 0.38;
    final boxBottom = h * 0.86;

    // Draw main box body
    final bodyRRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(boxLeft, boxTop, boxRight, boxBottom),
      const Radius.circular(3),
    );
    canvas.drawRRect(bodyRRect, boxPaint);

    // Box lid (slightly wider)
    final lidLeft = w * 0.14;
    final lidRight = w * 0.86;
    final lidHeight = h * 0.13;
    final lidRRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(lidLeft, boxTop - lidHeight * 0.7, lidRight, boxTop + lidHeight * 0.3),
      const Radius.circular(3),
    );
    canvas.drawRRect(lidRRect, boxShadowPaint);

    // Vertical ribbon
    final ribbonW = boxWidth * 0.22;
    final ribbonLeft = (w - ribbonW) / 2;
    final ribbonRRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(ribbonLeft, boxTop - lidHeight * 0.7, ribbonLeft + ribbonW, boxBottom),
      const Radius.circular(1),
    );
    canvas.drawRRect(ribbonRRect, ribbonPaint);

    // Horizontal ribbon across body
    final horizRibbonH = h * 0.1;
    final horizRibbonTop = (boxTop + boxBottom - horizRibbonH) / 2;
    canvas.drawRect(
      Rect.fromLTRB(boxLeft, horizRibbonTop, boxRight, horizRibbonTop + horizRibbonH),
      ribbonPaint,
    );

    // Bow loops on top of the lid
    final bowPaint = Paint()
      ..color = const Color(0xFFF55B61)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.08
      ..strokeCap = StrokeCap.round;

    final pathLeft = Path();
    pathLeft.moveTo(w * 0.5, boxTop - lidHeight * 0.7);
    pathLeft.cubicTo(
      w * 0.22,
      boxTop - lidHeight * 2.2,
      w * 0.25,
      boxTop - lidHeight * 0.2,
      w * 0.48,
      boxTop - lidHeight * 0.6,
    );
    canvas.drawPath(pathLeft, bowPaint);

    final pathRight = Path();
    pathRight.moveTo(w * 0.5, boxTop - lidHeight * 0.7);
    pathRight.cubicTo(
      w * 0.78,
      boxTop - lidHeight * 2.2,
      w * 0.75,
      boxTop - lidHeight * 0.2,
      w * 0.52,
      boxTop - lidHeight * 0.6,
    );
    canvas.drawPath(pathRight, bowPaint);

    // Bow knot center
    final knotPaint = Paint()
      ..color = const Color(0xFFE0434A)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.5, boxTop - lidHeight * 0.65), w * 0.07, knotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
