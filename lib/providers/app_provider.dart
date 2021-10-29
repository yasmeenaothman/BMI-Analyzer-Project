import 'package:bmi_project/helpers/shared_prefe_helper.dart';
import 'package:bmi_project/helpers/theme_helper.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool isArabic = false;
  bool isDark = false;
  AppProvider(){
    notifyListeners();
  }
  updateLanguage({bool fromShared}) async {
    if(fromShared!=null){
      isArabic = fromShared;
    }
    else{
      isArabic = !isArabic;
      await SharedPreferenceHelper.sharedHelper.putBoolean('isArabic', isArabic);
    }
    notifyListeners();
  }
}