import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/core/constant.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/pages/tips/get_started.dart';

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
}
