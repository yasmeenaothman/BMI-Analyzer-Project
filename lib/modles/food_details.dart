import 'package:flutter/material.dart';

class FoodDetails {
  String userId;
  String name;
  String category;
  double calory;
  String foodPhotoUrl;
  String unit;

  FoodDetails({
    @required this.userId,
    @required this.name,
    @required this.category,
    @required this.calory,
    @required this.foodPhotoUrl,
    @required this.unit,
  });

  FoodDetails.fromMap(Map map) {
    this.userId = map["userId"];
    this.name = map["name"];
    this.category = map["category"];
    this.calory = map["calory"];
    this.foodPhotoUrl = map["foodPhotoUrl"];
    this.unit = map["unit"];
  }

  toMap() {
    return {
      "userId": this.userId,
      "name": this.name,
      "category": this.category,
      "calory": this.calory,
      "foodPhotoUrl": this.foodPhotoUrl,
      "unit": this.unit,
    };
  }
}
