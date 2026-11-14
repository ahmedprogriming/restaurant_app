import 'package:flutter/material.dart';
import 'package:restaurant/core/cart_state.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/routers/app_routes.dart';

/// A reusable floating or app bar cart button with a reactive live badge.
class CartBadgeIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;

  const CartBadgeIcon({
    super.key,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColor.primary,
    this.size = 46.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CartState.itemsNotifier,
      builder: (context, items, _) {
        final totalCount = CartState.totalCount;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              elevation: 2,
              shadowColor: Colors.black.withValues(alpha: 0.12),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: onTap ??
                    () {
                      Navigator.pushNamed(context, AppRoutes.cart);
                    },
                child: SizedBox(
                  width: size,
                  height: size,
                  child: Center(
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: iconColor,
                      size: size * 0.52,
                    ),
                  ),
                ),
              ),
            ),
            if (totalCount > 0)
              Positioned(
                top: -4,
                right: -4,
                child: AnimatedScale(
                  scale: totalCount > 0 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primary.withValues(alpha: 0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        totalCount > 99 ? '99+' : '$totalCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
