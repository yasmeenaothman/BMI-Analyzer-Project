import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CompleteInfoPage extends StatelessWidget {
  static String routeName = 'CompleteInfoPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI',style: Theme.of(context).appBarTheme.titleTextStyle,).tr(),
      ),
      body: Column(
        children: [
          SizedBox(height: 110.h,),
          Text('completeInfo',style: Theme.of(context).textTheme.bodyText1).tr(),
          SizedBox(height: 50.h,),
          Row(
            children: [
              
            ],
          )
        ],
      ),
    );
  }
}
