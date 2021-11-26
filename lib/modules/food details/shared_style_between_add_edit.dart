import 'package:bmi_project/helpers/AuthHelper.dart';
import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/modles/food_details.dart';
import 'package:bmi_project/modules/home_page/home_page.dart';
import 'package:bmi_project/providers/app_provider.dart';
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:bmi_project/shared_widgets/shared_text.dart';
import 'package:bmi_project/shared_widgets/text_field_with_style.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SharedAddAndEditStyle extends StatelessWidget {
  bool isAdd;
  SharedAddAndEditStyle({
    @required this.isAdd,
  });

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
        body: Consumer2<AppProvider, AuthProvider>(
          builder: (context, provider, authProvider, x) =>
              SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 40, end: 60),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    isAdd ? 'addFoodDetails' : 'editFoodDetails',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .merge(TextStyle(height: 1.4)),
                    textAlign: TextAlign.center,
                  ).tr(),
                  SizedBox(
                    height: 90.h,
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
                      DefaultText(text: 'name'),
                      TextFieldWithStyle(
                        controller: authProvider.nameFoodController,
                        isAdd: isAdd,
                      ),
                      DefaultText(text: 'category'),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        padding: EdgeInsetsDirectional.only(start: 5),
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            DropdownButton(
                              underline: Container(),
                              isExpanded: true,
                              iconEnabledColor: Theme.of(context).primaryColor,
                              iconSize: 26,
                              value: authProvider.selectedCategory,
                              items: authProvider.dropItems
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      child: Text(
                                        e.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                authProvider.changeSelectedCategory(v);
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 18),
                              child: Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: VerticalDivider(
                                  thickness: 1.5,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      DefaultText(text: 'calory'),
                      Row(
                        children: [
                          Expanded(
                              child: TextFieldWithStyle(
                            controller: authProvider.caloryController,
                            isAdd: isAdd,
                          )),
                          Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 5),
                              child: Text(
                                'cal'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .merge(TextStyle(fontSize: 15.sp)),
                              )),
                        ],
                      ),
                      DefaultText(text: 'photo'),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 220.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: authProvider.imageFile == null&&authProvider.updateFile == null
                        ? isAdd
                            ? Center(
                                child: Text(
                                  'noImage'.tr(),
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              )
                            : Image.network(
                                authProvider.selectedFood.foodPhotoUrl,
                                fit: BoxFit.cover,
                              )
                        : Image.file(
                            isAdd?authProvider.imageFile:authProvider.updateFile,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            isAdd
                                ? authProvider.pickImage()
                                : authProvider.pickUpdateImage();
                          },
                          child: Text('uploadPhoto').tr(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 35),
                          child: ElevatedButton(
                            onPressed: () async {
                              FoodDetails foodDetails =
                                  await authProvider.check(authProvider.imageFile,isAdd);
                              if (foodDetails != null) {
                                isAdd
                                    ? authProvider
                                        .addFoodTOFireStore(foodDetails)
                                    : authProvider
                                        .updateFoodTOFireStore(foodDetails);
                                RouteHelper.routeHelper.goToPageAndRemoveUntil(
                                    HomePage.routeName);
                              } else {
                                AuthHelper.authHelper
                                    .showToast('fillAllFields'.tr());
                              }
                            },
                            child: Text(isAdd
                                    ? 'saveFoodDetails'
                                    : 'updateFoodDetails')
                                .tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
