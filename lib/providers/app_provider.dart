import 'dart:io';

import 'package:bmi_project/helpers/shared_prefe_helper.dart';
import 'package:bmi_project/helpers/theme_helper.dart';
import 'package:bmi_project/modules/auth_pages/complete_info/complete_info_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AppProvider extends ChangeNotifier {
  bool isArabic = false;
  bool isDark = false;
  bool isVisible = true;
  double weight = 30;
  double length = 120;
  Gender groupValue = Gender.male;
  String date = '';
  String time = '';
  String selectedCategory;
  TextEditingController nameController = TextEditingController();
  TextEditingController caloryController = TextEditingController();
  File imageFile;
  List<String> dropItems = [
    'fruits',
    'fish',
    'carbohydrate',
    'vegetables',
    'dairy',
    'grains',
    'protein',
    'oils',
  ];
  AppProvider(){
    selectedCategory = dropItems.first;
    notifyListeners();
  }
  changeSelectedCategory(String value){
    this.selectedCategory = value;
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

  pickDate(BuildContext context) async {
    date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime((DateTime.now().year) - 1),
            lastDate: DateTime((DateTime.now().year) + 1))
        .then((value) => value == null ? '' : DateFormat.yMMMd().format(value));
    notifyListeners();
  }

  pickTime(BuildContext context) async {
    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) => value == null ? '' : value.format(context));
    notifyListeners();
  }
  pickImage() async{
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file != null){
      imageFile = File(file.path);
      notifyListeners();
    }
  }
}