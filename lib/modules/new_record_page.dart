import 'package:bmi_project/providers/app_provider.dart';
import 'package:bmi_project/shared_widgets/shared_container.dart';
import 'package:bmi_project/shared_widgets/shared_container_with_text.dart';
import 'package:bmi_project/shared_widgets/shared_text.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NewRecordPage extends StatelessWidget {
  static String routeName = 'NewRecordPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'BMI',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ).tr(),
        ),
        //Single Child
        body: Consumer<AppProvider>(
          builder: (context, provider, x) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    'newRecord',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1,
                    textAlign: TextAlign.center,
                  ).tr(),
                  SizedBox(
                    height: 100.h,
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 35,
                        mainAxisExtent: provider.isArabic?30:25),
                    children: [
                      DefaultText(text: 'weight'),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 3),
                        child: DefaultContainerWithText(
                          text: 'kg',
                          isWeight: true,
                        ),
                      ),
                      DefaultText(text: 'length'),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 3),
                        child: DefaultContainerWithText(
                          text: 'cm',
                          isWeight: false,
                        ),
                      ),
                      DefaultText(text: 'date'),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 3,end: 22),
                        child: GestureDetector(
                            onTap: () async{
                              await provider.pickDate(context);
                            },
                            child: DefaultContainer(text: provider.date,)
                        ),
                      ),
                      DefaultText(text: 'time'),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 3,end: 22),
                        child: GestureDetector(
                          child: DefaultContainer(text: provider.time,),
                          onTap: () async{
                            await provider.pickTime(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ///save info in firebase and transform to home(current state.....)
                    },
                    child: Text('saveDataBtn').tr(),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
