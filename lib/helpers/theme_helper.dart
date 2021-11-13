import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ThemeHelper {
  ThemeHelper._();

  static ThemeHelper themeHelper = ThemeHelper._();
  ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: HexColor('#1589D8'),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.sp,color: Colors.white,),
          backgroundColor: ThemeData.light().primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark)),
      textTheme: TextTheme(
        headline6: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
        bodyText1: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 29.sp,
          color: HexColor('#178BDA')
        ),
        bodyText2: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey
        ),
        headline4: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey[600]
        ),
        headline1: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
            color: Colors.black
        ),
        headline2:  TextStyle(
            fontSize: 12.sp,
            color: HexColor('#42A5F5')
        ),
        headline3:  TextStyle(
          fontSize: 18.sp,
          color: HexColor('#42A5F5'),
          fontWeight: FontWeight.w700

        ),
      ),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: HexColor('#178BDA')),
        ),
      contentPadding: EdgeInsets.only(left: 5,bottom:2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(HexColor('#1589d8')),
        textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700
            )
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )
        ),
        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity,35.h)),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 12))
      )
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(HexColor('#42A5F5')),
    )
  );
}