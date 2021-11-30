
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider provider = Provider.of<AuthProvider>(context);
   /* Future.delayed(Duration(seconds: 3))
        .then((value) => provider.checkIsLogin()
    );*/
    return Scaffold(
      //Theme.of(context).primaryColor
      backgroundColor: HexColor('#1589D8'),
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
                onPressed: () {
                  //provider.logout();
                  provider.checkIsLogin();
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
