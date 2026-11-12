import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

/// Reusable location header matching the reference design.
/// Displays "Delivering to" label above "Current location" with a red dropdown arrow.
class DeliveryLocationHeader extends StatelessWidget {
  final String label;
  final String location;
  final VoidCallback? onTap;
  final Widget? trailing;

  const DeliveryLocationHeader({
    super.key,
    this.label = 'Delivering to',
    this.location = 'Current location',
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColor.textMuted,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: AppColor.textDark,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColor.primary,
                    size: 22,
                  ),
                ],
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
