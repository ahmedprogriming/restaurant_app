import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/routers/app_routes.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  // Toggle between English (matching the reference design) and Arabic
  bool _isArabic = false;

  void _navigateToNext() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.tips);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final textDirection = _isArabic ? TextDirection.rtl : TextDirection.ltr;

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
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33F55B61),
                          blurRadius: 20,
                          offset: Offset(0, -6),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(
                      28,
                      36,
                      28,
                      bottomPadding > 0 ? bottomPadding + 16 : 28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        Text(
                          _isArabic ? 'وجبات سعيدة' : 'Happy Meals',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Subtitle
                        Text(
                          _isArabic
                              ? 'اكتشف أشهى المأكولات من\nأكثر من 1,000 مطعم.'
                              : 'Discover the best foods from\nover 1,000 restaurants.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.92),
                            fontSize: 16,
                            height: 1.45,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Get Started Button
                        ElevatedButton(
                          onPressed: _navigateToNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColor.textDark,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 34,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            _isArabic ? 'ابدأ الآن' : 'Get Started',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2B2D42),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Language Switcher floating pill at top
              SafeArea(
                child: Align(
                  alignment: _isArabic
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
                          setState(() {
                            _isArabic = !_isArabic;
                          });
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
                                _isArabic ? 'English' : 'عربي',
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
  }
}
