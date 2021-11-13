import 'package:bmi_project/helpers/shared_prefe_helper.dart';
import 'package:bmi_project/helpers/theme_helper.dart';
import 'package:bmi_project/modules/auth_pages/complete_info/complete_info_page.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool isArabic = false;
  bool isDark = false;
  bool isVisible = true;
  double weight = 30;
  double length = 120;
  Gender groupValue = Gender.male;
  AppProvider(){
    notifyListeners();
  }
  changeIsisVisibleVar(){
    isVisible = !isVisible;
    notifyListeners();
  }
  changeGenderType(Gender gender){
    groupValue = gender;
    notifyListeners();
  }
  changeWeight(double weight){
    if(weight>=30&&weight<=250){
      this.weight = weight;
    }
    else{
      this.weight = 30;
    }
    notifyListeners();
  }
  changeLength(double length){
    if(length>=120&&length<=200){
      this.length = length;
    }
    else{
      this.length = 120;
    }
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