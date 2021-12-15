import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWithStyle extends StatelessWidget {
  TextEditingController controller;
  bool isAdd;
  TextFieldWithStyle({
    @required this.controller,
    this.isAdd
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color:Theme.of(context).primaryColor)
      ),
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.headline1,
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          label: isAdd?null:Text(controller.text),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(0),
          )/*OutlineInputBorder(
            borderSide: BorderSide.none
          )*/,
        ),
      ),
    );
  }
}
