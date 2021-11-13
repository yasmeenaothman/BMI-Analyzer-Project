import 'package:bmi_project/modules/auth_pages/complete_info/complete_info_page.dart';
import 'package:bmi_project/providers/app_provider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultRadio extends StatelessWidget {
  Gender value;
  String text;
  Function onTap;
  DefaultRadio({
    @required this.value,
    @required this.text,
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 25,
            child: Radio(
                value: value,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: Provider.of<AppProvider>(context,listen: false).groupValue,
                onChanged: (v) {
                  Provider.of<AppProvider>(context).changeGenderType(v);
                }),
          ),
          Text(text.tr(),
              style: Theme.of(context).textTheme.headline2),
        ],
      ),
    );
  }
}
