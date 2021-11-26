import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  String text;
  DefaultText({
    @required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Text(text.tr(), style: Theme.of(context).textTheme.headline3,);
  }
}
