import 'package:bmi_project/providers/auth_provider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, x) => Container(
        height: MediaQuery.of(context).size.height / 9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Center(
                    child: Text(
                      '20/10/2020',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  )),
                  Divider(
                    indent: 0,
                    thickness: 1.2,
                    color: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                      child: Text(
                    'Normal',
                    style: Theme.of(context).textTheme.subtitle2,
                  ))
                ],
              ),
            ),
            SizedBox(
              width: 0,
              child: VerticalDivider(
                thickness: 1.2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //from currentStatus object i can get height ,wight ,date ,status
                  Expanded(
                      child: Center(
                    child: Text(
                      '60 ' + 'kg'.tr(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  )),
                  Divider(
                    thickness: 1.2,
                    color: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                      child: Text(
                    '170 ' + 'cm'.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
