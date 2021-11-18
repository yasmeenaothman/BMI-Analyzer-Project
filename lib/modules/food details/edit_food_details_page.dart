import 'package:bmi_project/modules/food%20details/shared_style_between_add_edit.dart';
import 'package:bmi_project/providers/app_provider.dart';
import 'package:bmi_project/shared_widgets/shared_container.dart';
import 'package:bmi_project/shared_widgets/shared_container_with_text.dart';
import 'package:bmi_project/shared_widgets/shared_text.dart';
import 'package:bmi_project/shared_widgets/text_field_with_style.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditFoodDetailsPage extends StatelessWidget {
  static String routeName = 'EditFoodDetailsPage';
  @override
  Widget build(BuildContext context) {
    /// here be attention to make selectedFileIMage variable in provider with other things
    return SharedAddAndEditStyle(isAdd: false);
  }
}
