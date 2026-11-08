import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/routers/app_routes.dart';

/// Data model representing a single onboarding tip/screen
class TipItem {
  final String image;
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;

  const TipItem({
    required this.image,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
  });
}

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  late final PageController _pageController;
  int _currentPage = 0;
  bool _isArabic = false;

  final List<TipItem> _tips = const [
    TipItem(
      image: 'assets/images/tip1.png',
      titleEn: 'Find foods you love',
      titleAr: 'ابحث عن طعامك المفضّل',
      descriptionEn: 'Discover the best foods from\nover 1,000 restaurants.',
      descriptionAr: 'اكتشف أشهى المأكولات والمطاعم\nمن بين أكثر من 1,000 مطعم متميز.',
    ),
    TipItem(
      image: 'assets/images/tip2.png',
      titleEn: 'Fast Delivery',
      titleAr: 'توصيل سريع وفعّال',
      descriptionEn: 'Fast delivery to your home, office\nand wherever you are.',
      descriptionAr: 'توصيل سريع ومباشر إلى منزلك،\nمكتبك وأينما كنت في أي وقت.',
    ),
    TipItem(
      image: 'assets/images/tip3.png',
      titleEn: 'Live Tracking',
      titleAr: 'تتبع مباشر ولحظي',
      descriptionEn: 'Real time tracking of your food\non the app after ordered.',
      descriptionAr: 'تتبع فوري لموقع طعامك خطوة\nبخطوة عبر التطبيق حتى وصوله.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  void _showActionFeedback(String actionName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isArabic
              ? 'تم الضغط على: $actionName'
              : 'Pressed: $actionName',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: AppColor.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = _isArabic ? TextDirection.rtl : TextDirection.ltr;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: textDirection,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    // Top Bar: Language toggle (leading) & Log in (trailing)
                    _buildTopBar(),

                    // PageView with Tips Content (Illustration + Title + Subtitle + Dots)
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _tips.length,
                        onPageChanged: _onPageChanged,
                        itemBuilder: (context, index) {
                          final tip = _tips[index];
                          return _buildTipSlide(tip, constraints.maxHeight);
                        },
                      ),
                    ),

                    // Dot indicators (placed right beneath the text with smooth sync)
                    _buildPageIndicator(),

                    const SizedBox(height: 28),

                    // Bottom Action Buttons ("Create Account" & "Continue with Facebook")
                    _buildBottomButtons(),

                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Top Bar with "Log in" action and language switch pill
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Subtle language switcher to support Arabic / English
          InkWell(
            onTap: () {
              setState(() {
                _isArabic = !_isArabic;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5F8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.language_rounded,
                    size: 15,
                    color: AppColor.textDark,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _isArabic ? 'English' : 'عربي',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Log in Text Button (matches the screenshot in top right)
          TextButton(
            onPressed: () => _navigateToHome(),
            style: TextButton.styleFrom(
              foregroundColor: AppColor.primary,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              _isArabic ? 'تسجيل الدخول' : 'Log in',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Single slide containing the illustration, title, and description
  Widget _buildTipSlide(TipItem tip, double totalHeight) {
    // Dynamic image height based on available screen space
    final double imageHeight = (totalHeight * 0.38).clamp(180.0, 310.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),

          // Illustration Image with subtle rounded box
          SizedBox(
            height: imageHeight,
            child: Image.asset(
              tip.image,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),

          const Spacer(flex: 1),

          // Main Title
          Text(
            _isArabic ? tip.titleAr : tip.titleEn,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: AppColor.primary,
              letterSpacing: -0.4,
            ),
          ),

          const SizedBox(height: 12),

          // Subtitle / Description
          Text(
            _isArabic ? tip.descriptionAr : tip.descriptionEn,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.5,
              color: Color(0xFF8D99AE),
              height: 1.45,
              fontWeight: FontWeight.w400,
            ),
          ),

          const Spacer(flex: 1),
        ],
      ),
    );
  }

  /// 3-dot animated page indicator
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_tips.length, (index) {
        final bool isActive = index == _currentPage;
        return GestureDetector(
          onTap: () => _goToPage(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: isActive ? 22 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColor.primary
                  : AppColor.primary.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }

  /// Bottom action buttons ("Create Account" and "Continue with Facebook")
  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary Button: "Create Account"
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => _showActionFeedback(
                _isArabic ? 'إنشاء حساب' : 'Create Account',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Text(
                _isArabic ? 'إنشاء حساب' : 'Create Account',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Secondary Button: "Continue with Facebook"
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => _showActionFeedback(
                _isArabic ? 'المتابعة مع فيسبوك' : 'Continue with Facebook',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF1F3F6),
                foregroundColor: const Color(0xFF2B2D42),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Classic Facebook 'f' badge
                  Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1877F2),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      'f',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'sans-serif',
                        height: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _isArabic
                        ? 'المتابعة باستخدام فيسبوك'
                        : 'Continue with Facebook',
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2B2D42),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
