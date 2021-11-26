import 'dart:io';

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
  BMIStatus currentStatus;
  List<FoodDetails> foodLists = [];
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
    getUserFromFireStore();
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
}