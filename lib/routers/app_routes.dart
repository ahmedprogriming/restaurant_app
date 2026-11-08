import 'package:flutter/material.dart';
import 'package:restaurant/pages/tips/tips.dart';

class AppRoutes 
{
  static const String splash='/';

   static Route<dynamic> onGenerateRoute(RouteSettings setting)
  {
    switch(setting.name)
    {
   
   
   case splash:
   return MaterialPageRoute(builder: (_)=> const Tips());

    default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('الصفحة غير موجودة')),
          ),
        );
    }
  }
}