import 'package:flutter/material.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';

/// A reusable minimalist back button responding dynamically to language direction:
/// - In Arabic (RTL): Guaranteed to point to the right (>)
/// - In English (LTR): Guaranteed to point to the left (<)
class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final double size;
  final bool? isRtl;

  // Explicit unmirrored chevron glyphs to avoid double-mirroring by Flutter's RTL auto-transform:
  // 0xf63a is chevron_left (<)
  // 0xf63b is chevron_right (>)
  static const IconData chevronLeft = IconData(
    0xf63a,
    fontFamily: 'MaterialIcons',
    matchTextDirection: false,
  );
  static const IconData chevronRight = IconData(
    0xf63b,
    fontFamily: 'MaterialIcons',
    matchTextDirection: false,
  );

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.color = AppColor.textDark,
    this.size = 26.0,
    this.isRtl,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLanguage.currentLocale,
      builder: (context, _) {
        final bool rtl = isRtl ?? AppLanguage.isArabic;

        return InkWell(
          onTap: onPressed ?? () => Navigator.of(context).maybePop(),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            child: Icon(
              rtl ? chevronRight : chevronLeft,
              size: size + 4,
              color: color,
            ),
          ),
        );
      },
    );
  }
}
