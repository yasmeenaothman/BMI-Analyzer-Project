import 'package:flutter/material.dart';

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
      child: Center(
        child: TextField(
          style: Theme.of(context).textTheme.headline1,
          controller: controller,
          decoration: InputDecoration(
            label: isAdd?null:Text(controller.text),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none
            ),
          ),
        ),
      ),
    );
  }
}
