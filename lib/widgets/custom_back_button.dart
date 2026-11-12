import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

/// A reusable minimalist back button matching the reference design.
class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final double size;
  final bool? isRtl;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.color = AppColor.textDark,
    this.size = 26.0,
    this.isRtl,
  });

  @override
  Widget build(BuildContext context) {
    final bool rtl = isRtl ?? (Directionality.of(context) == TextDirection.rtl);

    return InkWell(
      onTap: onPressed ?? () => Navigator.of(context).maybePop(),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        child: Icon(
          rtl ? Icons.arrow_forward_ios_rounded : Icons.chevron_left_rounded,
          size: rtl ? size - 4 : size + 4,
          color: color,
        ),
      ),
    );
  }
}
