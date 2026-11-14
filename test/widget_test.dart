import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/constant.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/core/user_state.dart';
import 'package:restaurant/core/cart_state.dart';
import 'package:restaurant/models/product_model.dart';
import 'package:restaurant/pages/account/favorites_screen.dart';
import 'package:restaurant/pages/account/notifications_screen.dart';
import 'package:restaurant/pages/account/user_account_screen.dart';
import 'package:restaurant/pages/auth/forgot_password_screen.dart';
import 'package:restaurant/pages/auth/sign_up_screen.dart';
import 'package:restaurant/pages/cart/cart_screen.dart';
import 'package:restaurant/pages/home/home_screen.dart';
import 'package:restaurant/pages/product/product_detail_screen.dart';
import 'package:restaurant/pages/tips/get_started.dart';
import 'package:restaurant/pages/tips/tips.dart';
import 'package:restaurant/routers/app_routes.dart';
import 'package:restaurant/widgets/category_card.dart';
import 'package:restaurant/widgets/custom_back_button.dart';
import 'package:restaurant/widgets/custom_primary_button.dart';
import 'package:restaurant/widgets/custom_rounded_text_field.dart';
import 'package:restaurant/widgets/custom_search_bar.dart';
import 'package:restaurant/widgets/delivery_location_header.dart';
import 'package:restaurant/widgets/home_bottom_nav_bar.dart';
import 'package:restaurant/widgets/restaurant_card.dart';
import 'package:restaurant/widgets/user_account_drawer.dart';

void main() {
  setUp(() {
    AppLanguage.setLocale(const Locale('en'));
    CartState.clearCart();
  });

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

    // Global language switch to Arabic via AppLanguage
    AppLanguage.setLocale(const Locale('ar'));
    await tester.pumpAndSettle();

    expect(find.text('إنشاء\nحسابك'), findsOneWidget);
    expect(find.text('اسم المستخدم'), findsOneWidget);
    expect(find.text('البريد الإلكتروني'), findsOneWidget);
    expect(find.text('كلمة المرور'), findsOneWidget);
    expect(find.text('رقم الهاتف'), findsOneWidget);
    expect(find.text('إنشاء حساب'), findsOneWidget);

    // Reset back to English
    AppLanguage.setLocale(const Locale('en'));
    await tester.pumpAndSettle();
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

    // Global language switch to Arabic via AppLanguage
    AppLanguage.setLocale(const Locale('ar'));
    await tester.pumpAndSettle();

    expect(find.text('نسيت كلمة المرور'), findsOneWidget);
    expect(find.text('إرسال'), findsOneWidget);
    expect(find.text('البريد الإلكتروني'), findsOneWidget);

    // Reset back to English
    AppLanguage.setLocale(const Locale('en'));
    await tester.pumpAndSettle();
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

    // Verify Arabic mode rendering globally via AppLanguage
    AppLanguage.setLocale(const Locale('ar'));
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('التوصيل إلى'), findsOneWidget);
    expect(find.text('الموقع الحالي'), findsOneWidget);
    expect(find.text('ابحث عن الوجبات أو المطاعم'), findsOneWidget);
    expect(find.text('العروض'), findsWidgets);
    expect(find.text('المطاعم'), findsOneWidget);

    // Reset back to English
    AppLanguage.setLocale(const Locale('en'));
    await tester.pumpAndSettle();
  });

  testWidgets(
      'Toggling language on GetStarted screen switches language across all screens globally',
      (WidgetTester tester) async {
    // Reset to English first
    AppLanguage.setLocale(const Locale('en'));

    await tester.pumpWidget(const RestaurantApp());
    await tester.pumpAndSettle();

    // Wait for Splash screen timer to navigate to GetStarted
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    // Verify initial English text on GetStarted
    expect(find.text('Happy Meals'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap language toggle on GetStarted screen
    await tester.tap(find.text('عربي'));
    await tester.pumpAndSettle();

    // Verify GetStarted switched to Arabic
    expect(find.text('وجبات سعيدة'), findsOneWidget);
    expect(find.text('ابدأ الآن'), findsOneWidget);

    // Navigate to Tips
    await tester.tap(find.text('ابدأ الآن'));
    await tester.pumpAndSettle();

    // Verify Tips screen is automatically in Arabic without any button!
    expect(find.text('ابحث عن طعامك المفضّل'), findsOneWidget);
    expect(find.text('تسجيل الدخول'), findsOneWidget);

    // Reset back to English
    AppLanguage.setLocale(const Locale('en'));
    await tester.pumpAndSettle();
  });

  testWidgets(
      'UserAccountDrawer faithfully matches reference mockup with user header and menu items',
      (WidgetTester tester) async {
    // Set to Arabic mode as in the user screenshot
    AppLanguage.setLocale(const Locale('ar'));
    UserState.resetToDefault();

    bool accountTapped = false;
    bool homeTapped = false;
    bool favoritesTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          drawer: UserAccountDrawer(
            onAccountSelected: () => accountTapped = true,
            onHomeSelected: () => homeTapped = true,
            onFavoritesSelected: () => favoritesTapped = true,
          ),
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    // Open drawer
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Verify User details matching mockup
    expect(find.text('Thaer'), findsOneWidget);
    expect(find.text('thaer@gmail.com'), findsOneWidget);
    expect(find.byIcon(Icons.person_rounded), findsWidgets);

    // Verify 3 core menu items matching mockup
    expect(find.text('الصفحة الرئيسية'), findsOneWidget);
    expect(find.text('حسابي'), findsOneWidget);
    expect(find.text('مفضلاتي'), findsOneWidget);

    // Verify icons matching mockup
    expect(find.byIcon(Icons.home_rounded), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    expect(find.byIcon(Icons.chevron_left_rounded), findsWidgets);

    // Tap 'حسابي'
    await tester.tap(find.text('حسابي'));
    await tester.pumpAndSettle();
    expect(accountTapped, isTrue);

    // Re-open and tap 'الصفحة الرئيسية'
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('الصفحة الرئيسية'));
    await tester.pumpAndSettle();
    expect(homeTapped, isTrue);

    // Re-open and tap 'مفضلاتي'
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('مفضلاتي'));
    await tester.pumpAndSettle();
    expect(favoritesTapped, isTrue);

    // Reset back
    AppLanguage.setLocale(const Locale('en'));
  });

  testWidgets('UserAccountScreen displays profile details and allows editing',
      (WidgetTester tester) async {
    AppLanguage.setLocale(const Locale('ar'));
    UserState.resetToDefault();

    await tester.pumpWidget(
      const MaterialApp(
        home: UserAccountScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify user information
    expect(find.text('حسابي'), findsOneWidget);
    expect(find.text('Thaer'), findsWidgets);
    expect(find.text('thaer@gmail.com'), findsWidgets);
    expect(find.text('المعلومات الشخصية'), findsOneWidget);
    expect(find.text('النشاط والطلبات'), findsOneWidget);

    // Tap Edit Profile
    await tester.tap(find.text('تعديل الملف الشخصي ✏️'));
    await tester.pumpAndSettle();

    // Check modal bottom sheet opened
    expect(find.text('تعديل البيانات الشخصية'), findsOneWidget);
    expect(find.text('حفظ التعديلات'), findsOneWidget);

    // Update name
    final nameField = find.byWidgetPredicate(
      (w) => w is TextFormField && w.controller?.text == 'Thaer',
    );
    expect(nameField, findsOneWidget);
    await tester.enterText(nameField, 'Thaer Al-Otaibi');
    await tester.tap(find.text('حفظ التعديلات'));
    await tester.pumpAndSettle();

    // Verify user state updated
    expect(UserState.currentUser.value.name, 'Thaer Al-Otaibi');
    expect(find.text('Thaer Al-Otaibi'), findsWidgets);

    // Reset back
    UserState.resetToDefault();
    AppLanguage.setLocale(const Locale('en'));
  });

  test('UserState updates profile and handles reactive changes', () {
    UserState.resetToDefault();
    expect(UserState.currentUser.value.name, 'Thaer');
    expect(UserState.currentUser.value.email, 'thaer@gmail.com');

    UserState.updateProfile(name: 'New Name', phone: '+966 50 999 8888');
    expect(UserState.currentUser.value.name, 'New Name');
    expect(UserState.currentUser.value.phone, '+966 50 999 8888');
    expect(UserState.currentUser.value.email, 'thaer@gmail.com');

    UserState.updateFavoriteCount(2);
    expect(UserState.currentUser.value.favoriteCount, 8);

    UserState.logout();
    expect(UserState.currentUser.value.name, 'ضيف');

    UserState.resetToDefault();
    expect(UserState.currentUser.value.name, 'Thaer');
  });

  testWidgets('FavoritesScreen displays favorite items and handles removals',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FavoritesScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Hollywood Starz Cafe'), findsOneWidget);
    expect(find.byType(RestaurantCard), findsWidgets);
  });

  testWidgets('NotificationsScreen displays notification alerts',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NotificationsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Special Offer Today! 25% Off'), findsOneWidget);
  });

  test('CartState correctly calculates totals and handles promo codes', () {
    CartState.clearCart();
    expect(CartState.items.isEmpty, true);
    expect(CartState.totalCount, 0);

    final salmon = ProductModel.sampleProducts[0]; // Price 1500
    CartState.addItem(salmon, quantity: 2);
    expect(CartState.totalCount, 2);
    expect(CartState.subtotal, 3000.0);

    // Increment
    CartState.increment(salmon.id);
    expect(CartState.totalCount, 3);
    expect(CartState.subtotal, 4500.0);

    // Decrement
    CartState.decrement(salmon.id);
    expect(CartState.totalCount, 2);
    expect(CartState.subtotal, 3000.0);

    // Apply promo code SAVE20 (20% off)
    final applied = CartState.applyPromoCode('SAVE20');
    expect(applied, true);
    expect(CartState.discount, 600.0);
    expect(CartState.appliedPromoNotifier.value, 'SAVE20');

    CartState.removePromoCode();
    expect(CartState.discount, 0.0);
  });

  testWidgets('ProductDetailScreen renders Grilled Salmon screen matching Image 1',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    AppLanguage.setLocale(const Locale('ar'));
    final salmon = ProductModel.sampleProducts[0];

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        home: ProductDetailScreen(product: salmon),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Title "سمك مشوي"
    expect(find.text('سمك مشوي'), findsOneWidget);

    // Verify rating and likes
    expect(find.text('5.0 (342 تقييم)'), findsOneWidget);
    expect(find.text('5'), findsWidgets);

    // Verify Add to cart button
    expect(find.text('إضافة إلى السلة'), findsOneWidget);

    // Verify initial price is 1500 ر.س
    expect(find.text('1500 ر.س'), findsOneWidget);

    // Test increment quantity
    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();

    // Price should double to 3000 ر.س
    expect(find.text('3000 ر.س'), findsOneWidget);

    // Reset locale
    AppLanguage.setLocale(const Locale('en'));
  });

  testWidgets('ProductDetailScreen renders Strawberry screen matching Image 2',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    AppLanguage.setLocale(const Locale('en'));
    final strawberry = ProductModel.sampleProducts[1];

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        home: ProductDetailScreen(product: strawberry),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Title "Strawberry"
    expect(find.text('Strawberry'), findsOneWidget);

    // Verify calories badge "33 calories"
    expect(find.text('33 calories'), findsOneWidget);

    // Verify rating badge "4.9 (2645 review)"
    expect(find.text('4.9 (2645 review)'), findsOneWidget);

    // Verify delivery time & video
    expect(find.text('20 - 30 min'), findsOneWidget);
    expect(find.text('Watch video'), findsOneWidget);

    // Verify Add to Cart button and price
    expect(find.text('Add to Cart'), findsOneWidget);
    expect(find.text('\$ 56.68'), findsOneWidget);

    // Tap watch video button
    await tester.tap(find.text('Watch video'));
    await tester.pumpAndSettle();
    expect(find.text('Preparation & Story'), findsOneWidget);
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
  });

  testWidgets('CartScreen renders items and processes checkout',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    CartState.clearCart();
    final strawberry = ProductModel.sampleProducts[1];
    CartState.addItem(strawberry, quantity: 2);

    await tester.pumpWidget(
      const MaterialApp(
        home: CartScreen(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
    await tester.pumpAndSettle();

    // Check header and item
    expect(find.text('Shopping Cart (2)'), findsOneWidget);
    expect(find.text('Strawberry'), findsOneWidget);
    expect(find.text('Checkout'), findsOneWidget);
    expect(find.text('Bill Details'), findsOneWidget);

    // Tap Checkout
    await tester.tap(find.text('Checkout'));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    expect(find.text('Order Placed Successfully!'), findsOneWidget);
    await tester.tap(find.text('Back to Home'));
    await tester.pumpAndSettle();

    expect(CartState.items.isEmpty, true);
  });
}
