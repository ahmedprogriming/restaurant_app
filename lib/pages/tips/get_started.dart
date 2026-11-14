import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/routers/app_routes.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  void _navigateToNext(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.tips);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return ListenableBuilder(
      listenable: AppLanguage.currentLocale,
      builder: (context, _) {
        final isArabic = AppLanguage.isArabic;
        final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: AppColor.primary,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Directionality(
              textDirection: textDirection,
              child: Stack(
                children: [
                  // Main content: food collage on top + bottom coral card
                  Column(
                    children: [
                      // Top section: Food illustration collage
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: SafeArea(
                            bottom: false,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 8.0,
                              ),
                              child: Image.asset(
                                'assets/images/listFoods.png',
                                fit: BoxFit.contain,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Bottom section: Rounded card matching the design
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          left: 28.0,
                          right: 28.0,
                          top: 36.0,
                          bottom: bottomPadding + 28.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // App Brand Title
                            Text(
                              isArabic ? 'وجبات سعيدة' : 'Happy Meals',
                              style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Subtitle
                            Text(
                              isArabic
                                  ? 'اكتشف أفضل الأطعمة من أكثر من 1000 مطعم واحصل على توصيل سريع إلى باب منزلك'
                                  : 'Discover the best foods from over 1,000\nrestaurants and fast delivery to your\ndoorstep',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.5,
                                height: 1.45,
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Get Started CTA Button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () => _navigateToNext(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF2B2D42),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: Text(
                                  isArabic ? 'ابدأ الآن' : 'Get Started',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2B2D42),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Language Switcher floating pill at top (The single screen for language change)
                  SafeArea(
                    child: Align(
                      alignment: isArabic
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Material(
                          color: Colors.white.withValues(alpha: 0.9),
                          elevation: 2,
                          shadowColor: Colors.black12,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              AppLanguage.toggleLanguage();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.language,
                                    size: 16,
                                    color: AppColor.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    isArabic ? 'English' : 'عربي',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
