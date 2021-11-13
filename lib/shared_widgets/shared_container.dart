import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultContainer extends StatelessWidget {
  double height;
  String text;
  DefaultContainer({
    this.height = 28,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      child: Center(
        child: Text(
            text,
            style: Theme.of(context).textTheme.headline2),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)
      ),
    );
  }
}
