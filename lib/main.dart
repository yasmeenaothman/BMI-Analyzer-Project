import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/helpers/theme_helper.dart';
import 'package:bmi_project/modules/auth_pages/complete_info/complete_info_page.dart';
import 'package:bmi_project/modules/auth_pages/login_page.dart';
import 'package:bmi_project/modules/auth_pages/signUp_page.dart';
import 'package:bmi_project/modules/splash_page.dart';
import 'package:bmi_project/providers/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/languages',
        fallbackLocale: Locale('en'),
        startLocale: Locale('en'),
        child: ScreenUtilInit(
          designSize: Size(392.7, 803.6),
          builder: ()=> ChangeNotifierProvider(
            create: (context) => AppProvider(),
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
          },
          ///I will do the custom dark theme soon///
          theme: Provider.of<AppProvider>(context).isDark?ThemeData.dark():ThemeHelper.themeHelper.lightTheme,
          home: CompleteInfoPage());
  }
}


