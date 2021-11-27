import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/helpers/shared_prefe_helper.dart';
import 'package:bmi_project/helpers/theme_helper.dart';
import 'package:bmi_project/modules/auth_pages/complete_info/complete_info_page.dart';
import 'package:bmi_project/modules/auth_pages/login_page.dart';
import 'package:bmi_project/modules/auth_pages/signUp_page.dart';
import 'package:bmi_project/modules/food_list_page.dart';
import 'package:bmi_project/modules/new_record_page.dart';
import 'package:bmi_project/modules/splash_page.dart';
import 'package:bmi_project/providers/app_provider.dart';
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'modules/food details/add_food_details_page.dart';
import 'modules/food details/edit_food_details_page.dart';
import 'modules/home_page/home_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPreferenceHelper.sharedHelper.initSharedPreferences();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/languages',
        fallbackLocale: Locale('en'),
        startLocale: Locale('en'),
        child: ScreenUtilInit(
          designSize: Size(392.7, 803.6),
          builder: ()=> MultiProvider(
            providers: [
              ChangeNotifierProvider<AppProvider>(
              create: (context) => AppProvider()),
              ChangeNotifierProvider<AuthProvider>(
                  create: (context) => AuthProvider()),
            ],
            child: MyApp()
          ),
        )),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: Provider.of<AppProvider>(context).isArabic
              ? Locale('ar')
              : Locale('en'),
          debugShowCheckedModeBanner: false,
          navigatorKey: RouteHelper.routeHelper.navKey,
          routes: {
            LoginPage.routeName: (context) => LoginPage(),
            SignUpPage.routeName: (context) => SignUpPage(),
            CompleteInfoPage.routeName: (context) => CompleteInfoPage(),
            NewRecordPage.routeName: (context) => NewRecordPage(),
            AddFoodDetailsPage.routeName: (context) => AddFoodDetailsPage(),
            EditFoodDetailsPage.routeName: (context) => EditFoodDetailsPage(),
            FoodListPage.routeName: (context) => FoodListPage(),
            HomePage.routeName: (context) => HomePage(),
          },
          ///I will do the custom dark theme soon///
          theme: Provider.of<AppProvider>(context).isDark?ThemeHelper.themeHelper.darkTheme:ThemeHelper.themeHelper.lightTheme,
          home: FirebaseConfiguration());
  }
}
class FirebaseConfiguration extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.done) {
            return SplashPage();
          }
          if (dataSnapshot.hasError) {
            return Scaffold(
              body: Center(child: Text(dataSnapshot.error.toString())),
            );
          }
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
    );
  }
}


