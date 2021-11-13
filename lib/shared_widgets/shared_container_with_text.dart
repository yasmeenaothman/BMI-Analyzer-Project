import 'package:bmi_project/providers/app_provider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DefaultContainerWithText extends StatelessWidget {
  String text;
  bool isWeight;
  DefaultContainerWithText({
    @required this.text,
    @required this.isWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, x) => Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      isWeight
                          ? provider.changeWeight(--provider.weight)
                          : provider.changeLength(--provider.length);
                    },
                    child: SizedBox(
                      width: 15.w,
                      child: Icon(
                        Icons.remove,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1.5,
                    color: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                              isWeight
                                  ? provider.weight.toString()
                                  : provider.length.toString(),
                              style: Theme.of(context).textTheme.headline2))),
                  SizedBox(
                    width: 0,
                    child: VerticalDivider(
                      thickness: 1.5,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isWeight
                          ? provider.changeWeight(++provider.weight)
                          : provider.changeLength(++provider.length);
                    },
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor)),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Text(
            text.tr(),
            style: Theme.of(context)
                .textTheme
                .headline2
                .merge(TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
