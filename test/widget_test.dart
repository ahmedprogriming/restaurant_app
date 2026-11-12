import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/core/constant.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/pages/auth/forgot_password_screen.dart';
import 'package:restaurant/pages/auth/sign_up_screen.dart';
import 'package:restaurant/pages/home/home_screen.dart';
import 'package:restaurant/pages/tips/get_started.dart';
import 'package:restaurant/pages/tips/tips.dart';
import 'package:restaurant/widgets/category_card.dart';
import 'package:restaurant/widgets/custom_back_button.dart';
import 'package:restaurant/widgets/custom_primary_button.dart';
import 'package:restaurant/widgets/custom_rounded_text_field.dart';
import 'package:restaurant/widgets/custom_search_bar.dart';
import 'package:restaurant/widgets/delivery_location_header.dart';
import 'package:restaurant/widgets/home_bottom_nav_bar.dart';
import 'package:restaurant/widgets/restaurant_card.dart';

void main() {
  testWidgets('App launches with splash screen and brand info',
      (WidgetTester tester) async {
    await tester.pumpWidget(const RestaurantApp());
    expect(find.text(AppConstants.appName), findsOneWidget);
    expect(find.text(AppConstants.appNameEn), findsOneWidget);
  });

  testWidgets('GetStarted screen renders title, button, and image',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: GetStarted(),
      ),
    );

    // Initial state: English matching the design image
    expect(find.text('Happy Meals'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Tap language toggle to switch to Arabic
    await tester.tap(find.text('عربي'));
    await tester.pumpAndSettle();

    // Verify Arabic content is displayed
    expect(find.text('وجبات سعيدة'), findsOneWidget);
    expect(find.text('ابدأ الآن'), findsOneWidget);
  });

  testWidgets('Tips screen renders initial slide (Find foods you love) and buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Tips(),
      ),
    );

    // Verify slide 1 elements
    expect(find.text('Find foods you love'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Continue with Facebook'), findsOneWidget);

    // Swipe to slide 2
    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();

    // Verify slide 2 elements
    expect(find.text('Fast Delivery'), findsOneWidget);

    // Swipe to slide 3
    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();

    // Verify slide 3 elements
    expect(find.text('Live Tracking'), findsOneWidget);
  });

  testWidgets('SignUp screen renders form fields matching mockup',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );

    // Title
    expect(find.text('Create your\naccount'), findsOneWidget);

    // 4 Form fields hint texts
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Phone'), findsOneWidget);

    // Submit button
    expect(find.text('Sign up'), findsOneWidget);

    // Bottom prompt
    expect(find.text('Already an account? '), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);

    // Language switch to Arabic
    await tester.tap(find.text('عربي'));
    await tester.pumpAndSettle();

    expect(find.text('إنشاء\nحسابك'), findsOneWidget);
    expect(find.text('اسم المستخدم'), findsOneWidget);
    expect(find.text('البريد الإلكتروني'), findsOneWidget);
    expect(find.text('كلمة المرور'), findsOneWidget);
    expect(find.text('رقم الهاتف'), findsOneWidget);
    expect(find.text('إنشاء حساب'), findsOneWidget);
  });

  testWidgets('ForgotPassword screen matches reference mockup and reuses components',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ForgotPasswordScreen(),
      ),
    );

    // Title matching the image
    expect(find.text('Forgot password'), findsOneWidget);

    // Subtitle matching the image
    expect(
      find.text(
        'Please enter your email to receive a link to create a new password via email.',
      ),
      findsOneWidget,
    );

    // Email field matching the image
    expect(find.text('Email'), findsOneWidget);

    // Send button matching the image
    expect(find.text('Send'), findsOneWidget);

    // Check back button exists
    expect(find.byType(CustomBackButton), findsOneWidget);

    // Check reusable primary button exists
    expect(find.byType(CustomPrimaryButton), findsOneWidget);

    // Check reusable text field exists
    expect(find.byType(CustomRoundedTextField), findsOneWidget);

    // Tap Send with empty field - shows validation error
    await tester.tap(find.text('Send'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email'), findsOneWidget);

    // Enter invalid email
    await tester.enterText(find.byType(TextFormField), 'invalid-email');
    await tester.tap(find.text('Send'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a valid email address'), findsOneWidget);

    // Switch to Arabic
    await tester.tap(find.text('عربي'));
    await tester.pumpAndSettle();

    expect(find.text('نسيت كلمة المرور'), findsOneWidget);
    expect(find.text('إرسال'), findsOneWidget);
    expect(find.text('البريد الإلكتروني'), findsOneWidget);
  });

  testWidgets('HomeScreen matches reference mockup and reuses modular widgets',
      (WidgetTester tester) async {
    // Set a phone screen size so all widgets layout properly
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify reusable widgets exist
    expect(find.byType(DeliveryLocationHeader), findsOneWidget);
    expect(find.byType(CustomSearchBar), findsOneWidget);
    expect(find.byType(CategoryCard), findsWidgets);
    expect(find.byType(RestaurantCard), findsWidgets);
    expect(find.byType(HomeBottomNavBar), findsOneWidget);

    // Verify header elements matching mockup
    expect(find.text('Delivering to'), findsOneWidget);
    expect(find.text('Current location'), findsOneWidget);

    // Verify search bar hint
    expect(find.text('Search foods'), findsOneWidget);

    // Verify categories matching mockup
    expect(find.text('Offers'), findsWidgets);
    expect(find.text('Burgers'), findsOneWidget);
    expect(find.text('Asian'), findsOneWidget);
    expect(find.text('Pizza'), findsOneWidget);

    // Verify restaurant card matching mockup
    expect(find.text('Hollywood Starz Cafe'), findsOneWidget);
    expect(find.text('20 - 30 mins'), findsWidgets);

    // Verify bottom nav items matching mockup
    expect(find.text('Restaurants'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);

    // Test language switch to Arabic
    await tester.tap(find.text('عربي'));
    await tester.pumpAndSettle();

    expect(find.text('التوصيل إلى'), findsOneWidget);
    expect(find.text('الموقع الحالي'), findsOneWidget);
    expect(find.text('ابحث عن الوجبات أو المطاعم'), findsOneWidget);
    expect(find.text('العروض'), findsWidgets);
    expect(find.text('المطاعم'), findsOneWidget);
  });
}
