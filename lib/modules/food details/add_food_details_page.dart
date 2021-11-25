
import 'package:bmi_project/modules/food%20details/shared_style_between_add_edit.dart';
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFoodDetailsPage extends StatelessWidget {
  static String routeName = 'AddFoodDetailsPage';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1)).then((value) => Provider.of<AuthProvider>(context,listen: false).cleanFields());
    return SharedAddAndEditStyle(isAdd: true);
  }
}
