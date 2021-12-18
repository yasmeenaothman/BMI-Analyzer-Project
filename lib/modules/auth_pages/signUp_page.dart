import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/modules/auth_pages/complete_info/complete_info_page.dart';
import 'package:bmi_project/modules/auth_pages/login_page.dart';
import 'package:bmi_project/providers/auth_provider.dart';
import 'package:bmi_project/shared_widgets/defualt_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class SignUpPage extends StatelessWidget {
  static String routeName = 'SignUpPage';
  @override
  Widget build(BuildContext context) {
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
              Text('createAccount',style: Theme.of(context).textTheme.bodyText1).tr(),
              SizedBox(height: 15.h,),
              Text('ifNot',style: Theme.of(context).textTheme.bodyText2).tr(),
              SizedBox(height: 70.h,),
              Padding(
                  padding: const EdgeInsets.only(left: 15,right: 50),
                  child: DefaultTextField(
                    hint: 'name',
                    controller: provider.nameController,
                  )
              ),
              SizedBox(height: 30.h,),
              Padding(
                  padding: const EdgeInsets.only(left: 15,right: 50),
                  child: DefaultTextField(
                    hint: 'email',
                    controller: provider.emailController,
                  )
              ),
              SizedBox(height: 35.h,),
              Padding(
                  padding: const EdgeInsets.only(left: 15,right: 50),
                  child: DefaultTextField(
                    isPass: true,
                    hint: 'pass',
                    controller: provider.passwordController,
                  )
              ),
              SizedBox(height: 35.h,),
              Padding(
                  padding: const EdgeInsets.only(left: 15,right: 50),
                  child: DefaultTextField(
                    hint: 're_pass',
                    controller: provider.rePasswordController,
                  )
              ),
              SizedBox(height: 90.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: ElevatedButton(
                  onPressed: (){
                    ///auth in firebase
                    Provider.of<AuthProvider>(context,listen: false).register();
                  },
                  child: Text('createBtn').tr(),
                ),
              ),
              SizedBox(height: 35.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('haveAccount',style: Theme.of(context).textTheme.headline1).tr(),
                  TextButton(
                      onPressed: (){
                        RouteHelper.routeHelper.goToPageWithReplacement(LoginPage.routeName);
                      },
                      child: Text(
                          'LogTextBtn',
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
