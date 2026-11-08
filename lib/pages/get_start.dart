import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

class GetStarted
 extends StatelessWidget {
  const GetStarted
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column
    (
      children: [

        Container(
          height: 70,
          child:
        
         Image.asset('assets/images/listFoods.png')),

         Expanded(
           child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.primary
            ),
            child: Text(' وجبات سعيدة',style: TextStyle(fontSize: 20),),
           ),
         )
      ],

    
    );
  }
}