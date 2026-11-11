import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

/// The type of SnackBar to display, each with its own color scheme.
enum SnackBarType { success, error, warning, info }


void showAppSnackbar(
  BuildContext context,
  String message, {
  SnackBarType type = SnackBarType.info,
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  Color backgroundColor;
  Color borderColor;
  Color textColor;
  IconData iconData;

  switch (type) {
    case SnackBarType.success:
      // Warm green that complements the coral primary
      backgroundColor = const Color(0xFFF0FFF4);
      borderColor = const Color(0xFF48BB78);
      textColor = const Color(0xFF22543D);
      iconData = Icons.check_circle_rounded;
      break;

    case SnackBarType.error:
      // Uses the app's primary coral / red family
      backgroundColor = const Color(0xFFFFF5F5);
      borderColor = AppColor.primaryDark;
      textColor = const Color(0xFF742A2A);
      iconData = Icons.error_rounded;
      break;

    case SnackBarType.warning:
      // Uses the app's accent amber
      backgroundColor = const Color(0xFFFFFBF0);
      borderColor = AppColor.accent;
      textColor = const Color(0xFF7B4B00);
      iconData = Icons.warning_rounded;
      break;

    case SnackBarType.info:
      // Soft blue to contrast with the warm palette
      backgroundColor = const Color(0xFFF0F4FF);
      borderColor = const Color(0xFF4C8BF5);
      textColor = const Color(0xFF1E3A5F);
      iconData = Icons.info_rounded;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      duration: duration,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: borderColor.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            // Circular icon badge
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: borderColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: borderColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            // Message text
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
