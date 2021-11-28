import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultContainer extends StatelessWidget {
  double height;
  String text;
  double radius;
  bool fromStatus;
  DefaultContainer({
    this.height = 28,
    this.text,
    this.radius = 0,
    this.fromStatus = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      child: Center(
        child: Text(
            text,
            style: fromStatus?Theme.of(context).textTheme.headline4.merge(TextStyle(fontSize: 16.sp)):Theme.of(context).textTheme.headline2),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: Theme.of(context).primaryColor)
      ),
    );
  }
}
