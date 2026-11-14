import 'package:flutter/material.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/widgets/custom_back_button.dart';

/// Clean Notifications Screen ("الإشعارات")
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLanguage.currentLocale,
      builder: (context, _) {
        final isArabic = AppLanguage.isArabic;
        final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

        final notifications = [
          {
            'titleAr': 'عرض خاص اليوم! خصم 25%',
            'titleEn': 'Special Offer Today! 25% Off',
            'descAr': 'استخدم كود خصم YUMMY25 واحصل على خصم فوري على جميع وجبات البرجر',
            'descEn': 'Use coupon code YUMMY25 and get instant discount on all burger meals',
            'timeAr': 'منذ 10 دقائق',
            'timeEn': '10 mins ago',
            'icon': Icons.local_offer_rounded,
            'isRead': false,
          },
          {
            'titleAr': 'تم توصيل طلبك بنجاح ✅',
            'titleEn': 'Order Delivered Successfully ✅',
            'descAr': 'نتمنى لك وجبة شهية من مطعم أوشن للسلمون، لا تنس تقييم الطلب!',
            'descEn': 'Enjoy your meal from Ocean Fresh Salmon, don\'t forget to rate us!',
            'timeAr': 'منذ ساعة',
            'timeEn': '1 hour ago',
            'icon': Icons.delivery_dining_rounded,
            'isRead': true,
          },
          {
            'titleAr': 'أهلاً بك في مطعم الواحة 🎉',
            'titleEn': 'Welcome to Oasis Restaurant 🎉',
            'descAr': 'يسعدنا انضمامك إلينا! استمتع بألذ الأطباق وأسرع خدمة توصيل إلى باب بيتك',
            'descEn': 'We are glad to have you! Enjoy delicious dishes and fast delivery',
            'timeAr': 'منذ يومين',
            'timeEn': '2 days ago',
            'icon': Icons.celebration_rounded,
            'isRead': true,
          },
        ];

        return Directionality(
          textDirection: textDirection,
          child: Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              leading: CustomBackButton(
                onPressed: () => Navigator.pop(context),
                isRtl: isArabic,
              ),
              title: Text(
                isArabic ? 'الإشعارات' : 'Notifications',
                style: const TextStyle(
                  color: AppColor.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: notifications.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = notifications[index];
                final isRead = item['isRead'] as bool;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: isRead
                        ? null
                        : Border.all(color: AppColor.primary.withValues(alpha: 0.3), width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: (item['icon'] == Icons.local_offer_rounded
                                  ? AppColor.primary
                                  : AppColor.accent)
                              .withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: item['icon'] == Icons.local_offer_rounded
                              ? AppColor.primary
                              : const Color(0xFFD48B00),
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    isArabic
                                        ? item['titleAr'] as String
                                        : item['titleEn'] as String,
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: isRead ? FontWeight.w600 : FontWeight.w800,
                                      color: AppColor.textDark,
                                    ),
                                  ),
                                ),
                                if (!isRead)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColor.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isArabic
                                  ? item['descAr'] as String
                                  : item['descEn'] as String,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF6C757D),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isArabic
                                  ? item['timeAr'] as String
                                  : item['timeEn'] as String,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColor.textMuted,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
