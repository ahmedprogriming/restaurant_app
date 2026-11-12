import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/core/constant.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/pages/auth/sign_up_screen.dart';
import 'package:restaurant/pages/tips/get_started.dart';
import 'package:restaurant/pages/tips/tips.dart';

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
}
