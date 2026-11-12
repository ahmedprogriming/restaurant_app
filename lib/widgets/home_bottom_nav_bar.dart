import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

/// Reusable bottom navigation bar matching the reference mockup.
/// Features 3 items: Restaurants, Offers, Account, and the bottom home indicator pill.
class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isArabic;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isArabic = false,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    final List<Map<String, dynamic>> items = [
      {
        'labelEn': 'Restaurants',
        'labelAr': 'المطاعم',
        'icon': Icons.storefront_rounded,
        'activeIcon': Icons.storefront_rounded,
      },
      {
        'labelEn': 'Offers',
        'labelAr': 'العروض',
        'icon': Icons.local_fire_department_outlined,
        'activeIcon': Icons.local_fire_department_rounded,
      },
      {
        'labelEn': 'Account',
        'labelAr': 'حسابي',
        'icon': Icons.person_outline_rounded,
        'activeIcon': Icons.person_rounded,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: bottomInset > 0 ? 4 : 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  final isSelected = index == currentIndex;
                  final item = items[index];
                  final label = isArabic ? item['labelAr'] : item['labelEn'];
                  final iconData = (isSelected ? item['activeIcon'] : item['icon']) as IconData;

                  return InkWell(
                    onTap: () => onTap(index),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            iconData,
                            size: 24,
                            color: isSelected ? AppColor.primary : const Color(0xFF9EA3B0),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? AppColor.primary : const Color(0xFF9EA3B0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 6),
              // iOS Home Indicator pill bar matching mockup
              Center(
                child: Container(
                  width: 134,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
