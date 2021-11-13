import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultContainer extends StatelessWidget {
  double height;
  DefaultContainer({
    this.height = 28,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)
      ),
    );
  }
}
