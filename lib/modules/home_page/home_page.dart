import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/modules/food%20details/add_food_details_page.dart';
import 'package:bmi_project/modules/food_list_page.dart';
import 'package:bmi_project/modules/home_page/item_list_style.dart';
import 'package:bmi_project/modules/new_record_page.dart';
import 'package:bmi_project/providers/app_provider.dart';
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:bmi_project/shared_widgets/shared_container.dart';
import 'package:bmi_project/shared_widgets/shared_container_with_text.dart';
import 'package:bmi_project/shared_widgets/shared_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  static String routeName = 'HomePage';
  @override
  Widget build(BuildContext context) {
    //Provider.of<AuthProvider>(context,listen: false).checkInternet();
    return Consumer2<AppProvider,AuthProvider>(
      builder: (context, provider,authProvider, x) => Scaffold(
          appBar: AppBar(
            title: Text(
              'BMI',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ).tr(),
            actions: [
              IconButton(
                  onPressed: (){
                    provider.updateLanguage();
                    EasyLocalization.of(context).setLocale(provider.isArabic?Locale('ar'):Locale('en'));
                  },
                  icon: Icon(Icons.language)
              ),
              IconButton(
                  onPressed: (){
                    provider.updateTheme();
                  },
                  icon: provider.isDark?Icon(Icons.light_mode,size: 26,):Icon(Icons.dark_mode,size: 26,)
              )
            ],
          ),
          //Single Child
          body: authProvider.userData==null||authProvider.currentStatus==null?Center(child: CircularProgressIndicator()):SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'hi'.tr()+', '+toBeginningOfSentenceCase(authProvider.userData.name),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1.merge(TextStyle(fontSize: 25,fontWeight: FontWeight.w600)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(child: DefaultText(text: 'currentStatus'),alignment: AlignmentDirectional.topStart,),
                    SizedBox(
                      height: 10.h,
                    ),
                    //authProvider.currentStatus.status in below text
                    DefaultContainer(fromStatus: true,text: authProvider.changeStatus()==''?'${authProvider.currentStatus.status}':'${authProvider.currentStatus.status} (${authProvider.changeStatus()})',height: 50.h,radius: 5,),
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(child: DefaultText(text: 'oldStatus'),alignment: AlignmentDirectional.topStart,),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).primaryColor,
                      ),
                      child: authProvider.statuses.isEmpty?Center(child: Text('noAddStatus'.tr(),style: Theme.of(context).textTheme.headline1,)):Padding(
                        padding: const EdgeInsetsDirectional.only(top: 20,start: 35,end: 35,),
                        child:/*StreamBuilder(
                            stream: Connectivity().onConnectivityChanged,
                            builder: (BuildContext context,
                                AsyncSnapshot<ConnectivityResult> snapShot) {
                              if (!snapShot.hasData) return Center(child: CircularProgressIndicator());
                              var result = snapShot.data;
                              switch (result) {
                                case ConnectivityResult.none:
                                  print("no net");
                                  return Center(child: Text("No Internet Connection!"));
                                case ConnectivityResult.mobile:
                                case ConnectivityResult.wifi:
                                  print("yes net");
                                  authProvider.checkLengthOfStatusFromSQL();
                                  return ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context,index)=>ItemListStyle(index: index,),
                                    separatorBuilder: (context,index)=>SizedBox(
                                      height: 15.h,
                                    ),
                                    /// there length-1 becouse the list will be without the current that exist in the last
                                    itemCount: authProvider.statuses.length,
                                  );
                                default:
                                  return Center(child: Text("No Internet Connection!"));
                              }
                            })*/
                        ListView.separated(
                          physics: BouncingScrollPhysics(),
                          //shrinkWrap: true,
                          itemBuilder: (context,index)=>ItemListStyle(index: index,),
                          separatorBuilder: (context,index)=>SizedBox(
                            height: 15.h,
                          ),
                          itemCount: authProvider.statuses.length,
                        ),
                      )
                      ),
                    //),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              authProvider.cleanFields();
                              RouteHelper.routeHelper.goToPage(AddFoodDetailsPage.routeName);
                            },
                            child: Text('addFood').tr(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 25),
                            child: ElevatedButton(
                              onPressed: () {
                                RouteHelper.routeHelper.goToPage(NewRecordPage.routeName);
                              },
                              child: Text('addRecord').tr(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        authProvider.getAllFoods();
                        authProvider.checkInternet();
                        RouteHelper.routeHelper.goToPage(FoodListPage.routeName);
                      },
                      child: Text('viewFood').tr(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextButton(
                      child: Text('logout',
                        style: Theme.of(context).textTheme.headline1.merge(TextStyle(decoration: TextDecoration.underline))
                      ).tr(),
                      onPressed: (){
                        authProvider.logout();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
