import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeHelper {
  ThemeHelper._();

  static ThemeHelper themeHelper = ThemeHelper._();
  ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: HexColor('#1589D8'),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 30,color: Colors.white,),
          backgroundColor: ThemeData.light().primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark)),
      textTheme: TextTheme(
          title: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)));
}