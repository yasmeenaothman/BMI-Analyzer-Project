
import 'package:bmi_project/modules/food%20details/shared_style_between_add_edit.dart';
import 'package:flutter/material.dart';

class EditFoodDetailsPage extends StatelessWidget {
  static String routeName = 'EditFoodDetailsPage';

  @override
  Widget build(BuildContext context) {
    /// here be attention to make selectedFileIMage variable in provider with other things
    return SharedAddAndEditStyle(isAdd: false);
  }
}
