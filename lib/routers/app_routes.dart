import 'package:flutter/material.dart';
import 'package:restaurant/models/product_model.dart';
import 'package:restaurant/pages/account/favorites_screen.dart';
import 'package:restaurant/pages/account/notifications_screen.dart';
import 'package:restaurant/pages/account/user_account_screen.dart';
import 'package:restaurant/pages/auth/forgot_password_screen.dart';
import 'package:restaurant/pages/auth/login_screen.dart';
import 'package:restaurant/pages/auth/sign_up_screen.dart';
import 'package:restaurant/pages/cart/cart_screen.dart';
import 'package:restaurant/pages/home/home_screen.dart';
import 'package:restaurant/pages/product/product_detail_screen.dart';
import 'package:restaurant/pages/splash/splash_screen.dart';
import 'package:restaurant/pages/tips/get_started.dart';
import 'package:restaurant/pages/tips/tips.dart';

class AppRoutes {
  static const String splash = '/';
  static const String getStarted = '/get-started';
  static const String home = '/home';
  static const String tips = '/tips';
  static const String signUp = '/sign-up';
  static const String register = '/register';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String account = '/account';
  static const String favorites = '/favorites';
  static const String notifications = '/notifications';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';

  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case getStarted:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const GetStarted(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        );

      case tips:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const Tips(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        );

      case signUp:
      case register:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const SignUpScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        );

      case login:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        );

      case forgotPassword:
        final isArabic = setting.arguments is bool ? (setting.arguments as bool) : false;
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) =>
              ForgotPasswordScreen(initialIsArabic: isArabic),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        );

      case home:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        );

      case account:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const UserAccountScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        );

      case favorites:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const FavoritesScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        );

      case notifications:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const NotificationsScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        );

      case productDetail:
        final product = setting.arguments is ProductModel
            ? (setting.arguments as ProductModel)
            : ProductModel.sampleProducts[0];
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) =>
              ProductDetailScreen(product: product),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        );

      case cart:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const CartScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('الصفحة غير موجودة')),
          ),
        );
    }
  }
}
