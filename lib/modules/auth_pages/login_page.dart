import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/modules/auth_pages/signUp_page.dart';
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:bmi_project/shared_widgets/defualt_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatelessWidget {
  static String routeName = 'LoginPage';
  @override
  Widget build(BuildContext context) {
    /*print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);*/
    return Consumer<AuthProvider>(
      builder: (context,provider,x)=>Scaffold(
        appBar: AppBar(
          title: Text('BMI',style: Theme.of(context).appBarTheme.titleTextStyle,).tr(),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 110.h,),
              Text('WB',style: Theme.of(context).textTheme.bodyText1).tr(),
              SizedBox(height: 15.h,),
              Text('If',style: Theme.of(context).textTheme.bodyText2).tr(),
              SizedBox(height: 70.h,),
              Padding(
                  padding: const EdgeInsets.only(left: 15,right: 50),
                  child: DefaultTextField(
                    hint: 'username',
                    controller: provider.nameController,
                   /* onSave: (v){},
                    validate: (v){},*/
                  )
              ),
              SizedBox(height: 35.h,),
              Padding(
                  padding: const EdgeInsets.only(left: 15,right: 50),
                  child: DefaultTextField(
                    isPass: true,
                    hint: 'pass',
                    controller: provider.passwordController,
                    /*onSave: (v){},
                    validate: (v){},*/
                  )
              ),
              SizedBox(height: 90.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: ElevatedButton(
                  onPressed: (){
                    Provider.of<AuthProvider>(context,listen: false).login();
                  },
                  child: Text('login').tr(),
                ),
              ),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('notAccount',style: Theme.of(context).textTheme.headline1).tr(),
                  TextButton(
                      onPressed: (){
                        RouteHelper.routeHelper.goToPageWithReplacement(SignUpPage.routeName);
                      },
                      child: Text(
                          'signUp',
                          style: Theme.of(context).textTheme.headline2).tr()
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }
}
