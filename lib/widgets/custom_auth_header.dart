import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

/// A reusable header component displaying the screen title and optional subtitle.
class CustomAuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color titleColor;
  final Color subtitleColor;
  final double titleFontSize;
  final double subtitleFontSize;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomAuthHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.titleColor = AppColor.primary,
    this.subtitleColor = const Color(0xFF8D99AE),
    this.titleFontSize = 26.0,
    this.subtitleFontSize = 14.5,
    this.spacing = 12.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w700,
            color: titleColor,
            letterSpacing: -0.3,
            height: 1.2,
          ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          SizedBox(height: spacing),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: subtitleFontSize,
              fontWeight: FontWeight.w400,
              color: subtitleColor,
              height: 1.45,
            ),
          ),
        ],
      ],
    );
  }
}
