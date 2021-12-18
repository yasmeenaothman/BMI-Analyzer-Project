import 'dart:io';
import 'package:bmi_project/helpers/AuthHelper.dart';
import 'package:bmi_project/helpers/calculation_method_helper.dart';
import 'package:bmi_project/helpers/firestorage_helper.dart';
import 'package:bmi_project/helpers/firestore_helper.dart';
import 'package:bmi_project/helpers/route_helper.dart';
import 'package:bmi_project/helpers/sqfl_db_helper.dart';
import 'package:bmi_project/modles/bmi_status.dart';
import 'package:bmi_project/modles/food_details.dart';
import 'package:bmi_project/modles/user_data.dart';
import 'package:bmi_project/modules/auth_pages/complete_info/complete_info_page.dart';
import 'package:bmi_project/modules/auth_pages/login_page.dart';
import 'package:bmi_project/modules/home_page/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqlite_api.dart';

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
  List<BMIStatus> sortedStatuses = [];
  List<BMIStatus> statusesFromSQL = [];
  Database db ;
  BMIStatus currentStatus;
  bool isConnect;
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
    db = DbHelper.helper.database;
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
          getData();
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
  checkIsLogin() async {
    getCurrentUser();
    if(user==null){
      RouteHelper.routeHelper.goToPageWithReplacement(LoginPage.routeName);
    }
    else{
      await getData();
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
    //AuthHelper.authHelper.showToast(isConnect?'addedSuccessfully'.tr():'whenConnect'.tr());
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
    //AuthHelper.authHelper.showToast(isConnect?'updatedSuccessfully'.tr():'whenConnect'.tr());
  }
  getAllFoods() async{
    foodLists = await FireStoreHelper.fireStoreHelper.getAllFoods(user.uid);
    foodLists = foodLists.reversed.toList();
    notifyListeners();
  }
  deleteFoodFromFireStore(String name) async{
    await FireStoreHelper.fireStoreHelper.deleteFoodFromFireStore(name);
    await getAllFoods();
    AuthHelper.authHelper.showToast('deletedSuccessfully'.tr());
  }
  getAllBMIStatus() async{
    statuses = await FireStoreHelper.fireStoreHelper.getAllBMIStatus(user.uid);
    notifyListeners();
    statuses.sort((a,b){
      return a.date.compareTo(b.date);
    });
    currentStatus = statuses.last;
    statuses.removeLast();
    statuses = statuses.reversed.toList();
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
    if (nameFoodController.text!='' &&
        caloryController.text!='' &&
        selectedCategory != null &&
        (isAdd?file!= null:true)) {
      return await fillFoodInfo(isAdd);
    }
    else{
      return null;
    }
  }
  getData(){
    getUserFromFireStore();
    getAllBMIStatus();
    getAllFoods();
  }
  double calculateBMIValue(UserData user,double weight,double height){
    return CalculationMethodHelper.calculateBMIValue(user, weight, height);
  }
  String calculateBMIStatus(UserData user,double weight,double height){
    return CalculationMethodHelper.calculateBMIStatus(user, weight, height);
  }
  String changeStatus(){
    return CalculationMethodHelper.changeStatus(currentStatus: currentStatus,statuses: statuses,userData: userData);
  }
  deleteAllBMIStatus() async{
    await DbHelper.helper.deleteAllBMIStatus();
    statusesFromSQL = [];
    notifyListeners();
  }
  getAllStatuses() async{
    statusesFromSQL = await DbHelper.helper.getAllStatuses();
    notifyListeners();
  }
  insertBMIStatus(BMIStatus status) async{
    await DbHelper.helper.insertBMIStatus(status, db);
    getAllStatuses();
    print('statusesFromSQL.length = ${statusesFromSQL.length}');
    notifyListeners();
  }
  checkInternet() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isConnect = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      isConnect = false;
      notifyListeners();
    }
    notifyListeners();
  }
/* checkInternet(BMIStatus bmiStatus) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        addBMIStatusTOFireStore(bmiStatus);
      }
    } on SocketException catch (_) {
      print('not connected');
      insertBMIStatus(bmiStatus);
    }
  }*/
 /* Future checkLengthOfStatusFromSQL() async{
    if(statusesFromSQL.length!=0){
      statusesFromSQL.map((e) {
        addBMIStatusTOFireStore(e);
      });
      print('statusesFromSQL.length******************* = ${statusesFromSQL.length}');
      print('statuses length******************* = ${statuses.length}');
      //deleteAllBMIStatus();
    }
    else{
      print('/////////no item in sql////////');
    }
  }*/
}