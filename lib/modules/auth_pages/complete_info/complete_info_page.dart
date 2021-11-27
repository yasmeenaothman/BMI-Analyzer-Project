import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/modles/bmi_status.dart';
import 'package:bmi_project/modles/user_data.dart';
import 'package:bmi_project/modules/auth_pages/complete_info/shared_radio.dart';
import 'package:bmi_project/providers/app_provider.dart';
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:bmi_project/shared_widgets/shared_container.dart';
import 'package:bmi_project/shared_widgets/shared_container_with_text.dart';
import 'package:bmi_project/shared_widgets/shared_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../home_page/home_page.dart';

enum Gender { male, female }
class CompleteInfoPage extends StatelessWidget {
  static String routeName = 'CompleteInfoPage';
  //here update user data and add to fireStore
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
        body: Consumer2<AppProvider,AuthProvider>(
          builder: (context, provider,authProvider, x) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  Text(
                    'completeInfo',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .merge(TextStyle(height: 1.4)),
                    textAlign: TextAlign.center,
                  ).tr(),
                  SizedBox(
                    height: 60.h,
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 35,
                        mainAxisExtent: 25),
                    children: [
                      DefaultText(text: 'gender'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultRadio(
                            value: Gender.male,
                            text: 'male',
                            onTap: () {
                              provider.changeGenderType(Gender.male);
                            },
                          ),
                          Expanded(
                            child: DefaultRadio(
                              value: Gender.female,
                              text: 'female',
                              onTap: () {
                                provider.changeGenderType(Gender.female);
                              },
                            ),
                          ),
                        ],
                      ),
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
                      DefaultText(text: 'dOfB'),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 3),
                        child: GestureDetector(
                            onTap: () async {
                              await provider.pickDateOfBirth(context);
                            },
                            child: DefaultContainer(text: provider.dateOfBirth.toString(),)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ///save info in firebase and transform to home(current state.....)
                      //  +احسبي ال  BMI وضيفي الى جدول الحالات
                      UserData userData = UserData(
                        id: authProvider.userData.id,
                        name: authProvider.userData.name,
                        email: authProvider.userData.email,
                        gender: provider.groupValue.toString(),
                        dateOfBirth: provider.dateOfBirth
                      );
                      authProvider.updateUserData(userData);
                      authProvider.addUserTOFireStore();
                      /*authProvider.addBMIStatusTOFireStore(
                        BMIStatus(
                            userId: authProvider.userData.id,
                            height: provider.length,
                            weight: provider.weight,
                            status: authProvider.calculateBMIStatus(authProvider.userData, provider.weight, provider.length),
                            date: DateTime.now().toString(),
                            time: TimeOfDay.now().format(context))
                      );*/
                      RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
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
