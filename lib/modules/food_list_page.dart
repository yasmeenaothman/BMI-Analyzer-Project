import 'dart:ui';

import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/modules/food%20details/edit_food_details_page.dart';
import 'package:bmi_project/providers/app_provider.dart';
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class FoodListPage extends StatelessWidget {
  static String routeName = 'FoodList';
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              'BMI Analyser',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Center(
                    child: Text('FoodList',
                        style: Theme.of(context).textTheme.headline1)),
                SizedBox(
                  height: 80,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.foodLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Image.network(
                                  provider.foodLists[index].foodPhotoUrl,
                                  fit: BoxFit.fill,
                                )),
                            Expanded(
                              child: VerticalDivider(
                                thickness: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(provider.foodLists[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .merge(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18))),
                                  Text(provider.foodLists[index].category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .merge(TextStyle(fontSize: 16))),
                                  Text(
                                      provider.foodLists[index].calory
                                          .toString() +'${provider.foodLists[index].unit}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(
                                        end: 5),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                            EdgeInsets.symmetric(
                                              vertical: 5,
                                            )),
                                        minimumSize:
                                        MaterialStateProperty.all<Size>(
                                          Size(double.infinity, 10),
                                        ),
                                      ),
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      onPressed: () {
                                        provider.changeSelectedFood(provider.foodLists[index]);
                                        provider.fillFields();
                                        RouteHelper.routeHelper.goToPage(EditFoodDetailsPage.routeName);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                      const EdgeInsetsDirectional.only(
                                          start: 40, top: 10),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          minimumSize: MaterialStateProperty
                                              .all<Size>(Size(15, 15)),
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                    Radius.circular(5),
                                                    bottomLeft:
                                                    Radius.circular(5)),
                                              )),
                                          padding: MaterialStateProperty
                                              .all<EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  vertical: 0)),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          provider.deleteFoodFromFireStore(provider.foodLists[index].name);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
/*class FoodListPage extends StatelessWidget {
  static String routeName = 'FoodListPage';

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
          builder: (context, provider, authProvider, x) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'foodList',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ).tr(),
                  SizedBox(
                    height: 60.h
                  ),
                  authProvider.foodLists!=null?ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 10,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: authProvider.isConnect == true ?
                                  Image.network(
                                    authProvider.foodLists[index].foodPhotoUrl,
                                    fit: BoxFit.fill,
                                  ):
                                  Text(
                                      'noInternet'.tr(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline1),
                                ),
                                SizedBox(
                                  width: 0,
                                  child: VerticalDivider(
                                    thickness: 1.2,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          authProvider.foodLists[index].name,
                                          style:
                                              Theme.of(context).textTheme.subtitle1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          authProvider.foodLists[index].category,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              .merge(TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                            authProvider.foodLists[index].calory.toString() + 'cal'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2
                                              .merge(TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: provider.isDark?Colors.white38:Colors.grey[600])),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(end: 3,),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            authProvider.changeSelectedFood(authProvider.foodLists[index]);
                                            authProvider.fillFields();
                                            RouteHelper.routeHelper.goToPage(EditFoodDetailsPage.routeName);
                                          },
                                          child: Text(
                                            'editBtn',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ).tr(),
                                          style: ButtonStyle(
                                              minimumSize:
                                                  MaterialStateProperty.all<Size>(
                                                      Size(double.infinity, 30.h)),
                                              padding: MaterialStateProperty.all<
                                                      EdgeInsets>(
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,))),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 40, top: 5),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              authProvider.deleteFoodFromFireStore(authProvider.foodLists[index].name);
                                            },
                                            child: Center(
                                              child: Icon(
                                                Icons.close,
                                                size: 15,
                                              ),
                                            ),
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      OutlinedBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight: Radius.circular(5),
                                                    bottomLeft: Radius.circular(5)),
                                              )),
                                              padding: MaterialStateProperty.all<
                                                      EdgeInsets>(
                                                  EdgeInsets.symmetric(
                                                      vertical: 0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 40.h,
                    ),
                    itemCount: authProvider.foodLists.length,
                  ):CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ));
  }
}*/
