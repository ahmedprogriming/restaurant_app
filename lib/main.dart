import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurant/core/constant.dart';
import 'package:restaurant/core/theam_color.dart';

import 'package:restaurant/routers/app_routes.dart';void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

 @override

 Widget build(BuildContext contex)
 {
      
    
     return MaterialApp(
        localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
       title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme:ThemeData(
  primaryColor: AppColor.primary,
),
          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          
        );
    
 }
}
