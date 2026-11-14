import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/constant.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/routers/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLanguage.currentLocale,
      builder: (context, locale, _) {
        return MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: AppColor.primary,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.primary,
              primary: AppColor.primary,
            ),
          ),
          locale: locale,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
