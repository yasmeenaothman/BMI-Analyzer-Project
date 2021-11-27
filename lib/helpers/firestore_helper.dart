import 'package:bmi_project/modles/bmi_status.dart';
import 'package:bmi_project/modles/food_details.dart';
import 'package:bmi_project/modles/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  addUserTOFireStore(UserData userData) async {
    await firebaseFireStore
        .collection("Users")
        .doc(userData.id)
        .set(userData.toMap());
  }

  updateUserTOFireStore(UserData userData) async {
    await firebaseFireStore
        .collection("Users")
        .doc(userData.id)
        .set(userData.toMap());
  }

  Future<UserData> getUserFromFireStore(String uid) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFireStore.collection("Users").doc(uid).get();
    print(documentSnapshot.data());
    return UserData.fromMap(documentSnapshot.data());
  }
  Future<String> getUserEmailFromFireStoreByUserName(String name) async {
    QuerySnapshot querySnapshot =
    await firebaseFireStore.collection("Users").where("name",isEqualTo: name).get();
    return  querySnapshot.docs.length!=0?querySnapshot.docs[0]["email"]:null;
  }
  addFoodTOFireStore(FoodDetails foodDetails) async {
    await firebaseFireStore
        .collection("Foods")
        .doc(foodDetails.name)
        .set(foodDetails.toMap());
  }

  updateFoodTOFireStore(FoodDetails foodDetails) async {
    await firebaseFireStore
        .collection("Foods")
        .doc(foodDetails.name)
        .set(foodDetails.toMap());
  }

  Future<FoodDetails> getFoodFromFireStore(String name) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFireStore.collection("Foods").doc(name).get();
    print(documentSnapshot.data());
    return FoodDetails.fromMap(documentSnapshot.data());
  }

  Future<List<FoodDetails>> getAllFoods(String userId) async {
    QuerySnapshot querySnapshot = await firebaseFireStore
        .collection("Foods")
        .where("userId", isEqualTo: userId)
        .get();
    List<FoodDetails> foods =
        querySnapshot.docs.map((e) => FoodDetails.fromMap(e.data())).toList();
    print(foods.length);
    return foods;
  }
  deleteFoodFromFireStore(String name) async{
    await firebaseFireStore.collection("Foods").doc(name).delete();
  }
  addBMIStatusTOFireStore(BMIStatus bmiStatus) async {
    await firebaseFireStore
        .collection("Statuses")
        .add(bmiStatus.toMap());
  }

  Future<List<BMIStatus>> getAllBMIStatus(String userId) async {
    QuerySnapshot querySnapshot = await firebaseFireStore
        .collection("Statuses")
        .where("userId", isEqualTo: userId).orderBy("date",)
        .get();
    List<BMIStatus> statuses =
    querySnapshot.docs.map((e) => BMIStatus.fromMap(e.data())).toList();
    print(statuses.length);
    return statuses;
  }

}
