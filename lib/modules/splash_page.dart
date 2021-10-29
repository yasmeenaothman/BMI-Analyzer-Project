import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/modules/auth_pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5))
        .then((value) => RouteHelper.routeHelper.goToPageWithReplacement(LoginPage.routeName)
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset('assets/images/Logo.png',),
            ),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10,end: 25),
              child: TextButton(
                child: Text('next',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                      decoration: TextDecoration.underline
                  ),
                ).tr(),
                onPressed: (){
                  RouteHelper.routeHelper.goToPageWithReplacement(LoginPage.routeName);
                },
              ),
            ),
            alignment: AlignmentDirectional.bottomEnd,
          ),

        ],
      ),
    );
  }
}
