import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/modules/food%20details/add_food_details_page.dart';
import 'package:bmi_project/modules/food_list_page.dart';
import 'package:bmi_project/modules/new_record_page.dart';
import 'package:bmi_project/providers/app_provider.dart';
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:bmi_project/shared_widgets/shared_container.dart';
import 'package:bmi_project/shared_widgets/shared_container_with_text.dart';
import 'package:bmi_project/shared_widgets/shared_text.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String routeName = 'HomePage';
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
                    height: 50.h,
                  ),
                  Text(
                    'hi',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1,
                    textAlign: TextAlign.center,
                  ).tr(),
                  SizedBox(
                    height: 100.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            RouteHelper.routeHelper.goToPage(AddFoodDetailsPage.routeName);
                          },
                          child: Text('addFood').tr(),
                        ),
                      ),
                      SizedBox(
                        width: 20.h,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            RouteHelper.routeHelper.goToPage(NewRecordPage.routeName);
                          },
                          child: Text('addRecord').tr(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authProvider.getAllFoods();
                      RouteHelper.routeHelper.goToPage(FoodListPage.routeName);
                    },
                    child: Text('viewFood').tr(),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  TextButton(
                    child: Text('logout',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.black,
                          decoration: TextDecoration.underline
                      ),
                    ).tr(),
                    onPressed: (){
                      authProvider.logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
