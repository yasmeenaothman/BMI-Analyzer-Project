import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class LoginPage extends StatelessWidget {
  static String routeName = 'LoginPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI').tr(),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      ),
    );
  }
}
