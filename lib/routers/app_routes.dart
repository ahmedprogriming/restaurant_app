import 'package:flutter/material.dart';
import 'package:restaurant/pages/home/home_screen.dart';
import 'package:restaurant/pages/splash/splash_screen.dart';
import 'package:restaurant/pages/tips/get_started.dart';
import 'package:restaurant/pages/tips/tips.dart';

class AppRoutes {
  static const String splash = '/';
  static const String getStarted = '/get-started';
  static const String home = '/home';
  static const String tips = '/tips';

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

      case home:
        return PageRouteBuilder(
          settings: setting,
          pageBuilder: (_, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
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
