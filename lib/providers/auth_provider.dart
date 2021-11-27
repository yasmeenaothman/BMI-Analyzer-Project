import 'dart:io';
import 'dart:math';

import 'package:bmi_project/helpers/AuthHelper.dart';
import 'package:bmi_project/helpers/firestorage_helper.dart';
import 'package:bmi_project/helpers/firestore_helper.dart';
import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/modles/bmi_status.dart';
import 'package:bmi_project/modles/food_details.dart';
import 'package:bmi_project/modles/user_data.dart';
import 'package:bmi_project/modules/auth_pages/complete_info/complete_info_page.dart';
import 'package:bmi_project/modules/auth_pages/login_page.dart';
import 'package:bmi_project/modules/home_page/home_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nameFoodController = TextEditingController();
  TextEditingController caloryController = TextEditingController();
  String selectedCategory;
  User user;
  UserData userData;
  FoodDetails selectedFood;
  File imageFile;
  File updateFile;
  String foodImageUrlFromStorage;
  List<FoodDetails> foodLists = [];
  List<BMIStatus> statuses = [];
  BMIStatus currentStatus;
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
  AuthProvider(){
    selectedCategory = dropItems.first;
    getCurrentUser();
    notifyListeners();
  }
  changeSelectedCategory(String value){
    this.selectedCategory = value;
    notifyListeners();
  }
  changeSelectedFood(FoodDetails food){
    this.selectedFood = food;
    notifyListeners();
  }
  register() async{
    if(nameController.text!=''&&emailController.text!=''&&passwordController.text!=''&&rePasswordController.text!=''){
      if(passwordController.text == rePasswordController.text){
        bool value = await AuthHelper.authHelper.signUp(emailController.text, passwordController.text);
        if(value){
          getCurrentUser();
          userData = UserData(
            id: user.uid,
            name: nameController.text,
            email: emailController.text,
          );
          RouteHelper.routeHelper.goToPageWithReplacement(CompleteInfoPage.routeName);
          cleanControllers();
        }
      }
      else{
        AuthHelper.authHelper.showToast('passNotMatch'.tr());
      }
    }
    else{
      AuthHelper.authHelper.showToast('fillAllFields'.tr());
    }
  }

  login() async {
    if (nameController.text != '' && passwordController.text != '') {
      String email = await FireStoreHelper.fireStoreHelper
          .getUserEmailFromFireStoreByUserName(nameController.text.trim());
      if (email != null) {
        bool result = await AuthHelper.authHelper
            .signIn(email, passwordController.text.trim());
        if (result) {
          getCurrentUser();
          RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
        }
      } else {
        AuthHelper.authHelper.showToast('noUserName'.tr());
      }
    } else {
      AuthHelper.authHelper.showToast('fillAllFields'.tr());
    }
    cleanControllers();
  }

  getCurrentUser(){
    user= AuthHelper.authHelper.getCurrentUser();
    if(user!=null){
      getUserFromFireStore();
      //getAllBMIStatus();
    }
    notifyListeners();
  }
  cleanControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
  }
  updateUserData(UserData userData){
    this.userData = userData;
    notifyListeners();
  }
  checkIsLogin(){
    getCurrentUser();
    if(user==null){
      RouteHelper.routeHelper.goToPageWithReplacement(LoginPage.routeName);
    }
    else{
      RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
    }
  }
  logout() async{
    await AuthHelper.authHelper.logout();
    cleanControllers();
    RouteHelper.routeHelper.goToPageWithReplacement(LoginPage.routeName);
  }
  addUserTOFireStore() async{
    await FireStoreHelper.fireStoreHelper.addUserTOFireStore(userData);
  }
  getUserFromFireStore() async{
    userData = await FireStoreHelper.fireStoreHelper.getUserFromFireStore(user.uid);
    notifyListeners();
  }
  uploadFile() async{
    foodImageUrlFromStorage = await FireStorageHelper.fireStorageHelper.uploadFile(imageFile);
    notifyListeners();
  }
  pickImage() async{
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file != null){
      imageFile = File(file.path);
      notifyListeners();
    }
  }
  pickUpdateImage() async{
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file != null){
      updateFile = File(file.path);
      notifyListeners();
    }
  }
  addFoodTOFireStore(FoodDetails foodDetails) async{
    await FireStoreHelper.fireStoreHelper.addFoodTOFireStore(foodDetails);
    await cleanFields();
    await getAllFoods();
    AuthHelper.authHelper.showToast('addedSuccessfully'.tr());
  }
  addBMIStatusTOFireStore(BMIStatus bmiStatus) async{
    await FireStoreHelper.fireStoreHelper.addBMIStatusTOFireStore(bmiStatus);
    await getAllBMIStatus();
    AuthHelper.authHelper.showToast('addStatus'.tr());
  }
  updateFoodTOFireStore(FoodDetails foodDetails) async{
    await FireStoreHelper.fireStoreHelper.updateFoodTOFireStore(foodDetails);
    await cleanFields();
    await getAllFoods();
    AuthHelper.authHelper.showToast('updatedSuccessfully'.tr());
  }
  getAllFoods() async{
    foodLists = await FireStoreHelper.fireStoreHelper.getAllFoods(user.uid);
    notifyListeners();
  }
  deleteFoodFromFireStore(String name) async{
    await FireStoreHelper.fireStoreHelper.deleteFoodFromFireStore(name);
    await getAllFoods();
    AuthHelper.authHelper.showToast('deletedSuccessfully'.tr());
  }
  getAllBMIStatus() async{
    statuses = await FireStoreHelper.fireStoreHelper.getAllBMIStatus(user.uid);
    currentStatus = statuses.last;
    notifyListeners();
  }
  Future<FoodDetails> fillFoodInfo(bool isAdd) async {
    String imageUrl;
    if (updateFile != null) {
      imageUrl =
          await FireStorageHelper.fireStorageHelper.uploadFile(updateFile);
    } else {
      imageUrl = isAdd
          ? await FireStorageHelper.fireStorageHelper.uploadFile(imageFile)
          : selectedFood.foodPhotoUrl;
    }
    return isAdd
        ? FoodDetails(
            userId: user.uid,
            name: nameFoodController.text,
            category: selectedCategory,
            calory: double.parse(caloryController.text.trim()),
            foodPhotoUrl: imageUrl)
        : FoodDetails(
            userId: selectedFood.userId,
            name: nameFoodController.text,
            category: selectedCategory,
            calory: double.parse(caloryController.text),
            foodPhotoUrl: imageUrl);
  }

  cleanFields(){
    nameFoodController.clear();
    caloryController.clear();
    selectedCategory = dropItems.first;
    imageFile = null;
    updateFile = null;
    selectedFood = null;
    notifyListeners();
  }
  fillFields(){
    nameFoodController.text = selectedFood.name;
    caloryController.text = selectedFood.calory.toString();
    selectedCategory = selectedFood.category;
    notifyListeners();
  }
  Future<FoodDetails> check(File file,bool isAdd) async{
    if (nameFoodController.text != '' &&
        selectedCategory != null &&
        caloryController.text != '' &&
        isAdd?file!= null:true) {
      return await fillFoodInfo(isAdd);
    }
    else{
      return null;
    }
  }
  double calculateBMIValue(UserData user,double weight,double height){
    double percentage;
    int age = DateTime.now().year - int.parse(user.dateOfBirth);
    if(age>=2 && age<=10){
      percentage = 70/100;
    }
    else if(age>10 && age<=20 && user.gender =='male'){
      percentage = 90/100;
    }
    else if(age>10 && age<=20 && user.gender =='female'){
      percentage = 80/100;
    }
    else if(age>20){
      percentage = 100/100;
    }
    return (weight/pow(height/100, 2))* percentage ;
  }
  String calculateBMIStatus(UserData user,double weight,double height){
    String bmiStatus;
    double bmiValue = calculateBMIValue(user,weight,height);
    // these status write them in en, ar
    if(bmiValue < 18.5){
      bmiStatus = 'UnderWeight';
    }
    if(bmiValue >= 18.5 && bmiValue< 25){
      bmiStatus = 'Normal';
    }
    if(bmiValue >= 25 && bmiValue< 30){
      bmiStatus = 'OverWeight';
    }
    if(bmiValue >30){
      bmiStatus = 'Obesity';
    }
    return bmiStatus;
  }
  String changeStatus(){
    String changeStatus;
    BMIStatus lastStatus = statuses.last;
    BMIStatus beforeLastStatus = statuses[statuses.length-2];
    double bmiValueLastStatus = calculateBMIValue(userData,lastStatus.weight,lastStatus.height);
    double bmiValueBeforeLastStatus = calculateBMIValue(userData,beforeLastStatus.weight,beforeLastStatus.height);
    double difference = bmiValueLastStatus - bmiValueBeforeLastStatus;
    // these status write them in en, ar
    if(difference<-1){
      if(currentStatus.status =='UnderWeight'){
        changeStatus = 'So Bad';
      }
      if(currentStatus.status =='Normal'){
        changeStatus = 'So Bad';
      }
      if(currentStatus.status =='OverWeight'){
        changeStatus = 'Be Careful';
      }
      if(currentStatus.status =='Obesity'){
        changeStatus = 'Be Careful';
      }
    }
    else if(difference>=-1 && difference <-0.6){
      if(currentStatus.status =='UnderWeight'){
        changeStatus = 'So Bad';
      }
      if(currentStatus.status =='Normal'){
        changeStatus = 'Be Careful';
      }
      if(currentStatus.status =='OverWeight'){
        changeStatus = 'Go Ahead';
      }
      if(currentStatus.status =='Obesity'){
        changeStatus = 'Go Ahead';
      }
    }
    else if(difference>=-0.6 && difference <-0.3){
      if(currentStatus.status =='UnderWeight'){
        changeStatus = 'So Bad';
      }
      if(currentStatus.status =='Normal'){
        changeStatus = 'Be Careful';
      }
      if(currentStatus.status =='OverWeight'){
        changeStatus = 'Still Good';
      }
      if(currentStatus.status =='Obesity'){
        changeStatus = 'Little Changes';
      }
    }
    else if(difference>=-0.3 && difference <0){
      if(currentStatus.status =='UnderWeight'){
        changeStatus = 'Little Changes';
      }
      if(currentStatus.status =='Normal'){
        changeStatus = 'Little Changes';
      }
      if(currentStatus.status =='OverWeight'){
        changeStatus = 'Little Changes';
      }
      if(currentStatus.status =='Obesity'){
        changeStatus = 'Little Changes';
      }
    }
    else if(difference>=0.3 && difference <0.6){
      if(currentStatus.status =='UnderWeight'){
        changeStatus = 'Still Good';
      }
      if(currentStatus.status =='Normal'){
        changeStatus = 'Be Careful';
      }
      if(currentStatus.status =='OverWeight'){
        changeStatus = 'Be Careful';
      }
      if(currentStatus.status =='Obesity'){
        changeStatus = 'So Bad';
      }
    }
    else if(difference>=0.6 && difference <1){
      if(currentStatus.status =='UnderWeight'){
        changeStatus = 'Go Ahead';
      }
      if(currentStatus.status =='Normal'){
        changeStatus = 'Be Careful';
      }
      if(currentStatus.status =='OverWeight'){
        changeStatus = 'So Bad';
      }
      if(currentStatus.status =='Obesity'){
        changeStatus = 'So Bad';
      }
    }
    else if(difference>=1){
      if(currentStatus.status =='UnderWeight'){
        changeStatus = 'Go Ahead';
      }
      if(currentStatus.status =='Normal'){
        changeStatus = 'Be Careful';
      }
      if(currentStatus.status =='OverWeight'){
        changeStatus = 'So Bad';
      }
      if(currentStatus.status =='Obesity'){
        changeStatus = 'So Bad';
      }
    }
    return changeStatus;
  }
}