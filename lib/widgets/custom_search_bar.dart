import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

/// Reusable search bar widget matching the reference mockup.
/// Features a soft grey container, search prefix icon, "Search foods" hint,
/// and a coral-colored filter lines trailing icon.
class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onFilterTap;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Search foods',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onFilterTap,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(
            Icons.search_rounded,
            color: Color(0xFF8D99AE),
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              style: const TextStyle(
                fontSize: 14.5,
                color: AppColor.textDark,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9EA3B0),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onFilterTap,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: CustomPaint(
                  size: const Size(18, 14),
                  painter: _FilterIconPainter(color: AppColor.primary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A custom painter matching the 3 horizontal sliders/lines in the reference mockup.
class _FilterIconPainter extends CustomPainter {
  final Color color;

  _FilterIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Top line (long)
    canvas.drawLine(Offset(0, h * 0.15), Offset(w, h * 0.15), paint);

    // Middle line (medium)
    canvas.drawLine(Offset(w * 0.25, h * 0.5), Offset(w, h * 0.5), paint);

    // Bottom line (short)
    canvas.drawLine(Offset(w * 0.5, h * 0.85), Offset(w, h * 0.85), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
