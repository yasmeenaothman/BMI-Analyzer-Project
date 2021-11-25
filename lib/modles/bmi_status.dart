import 'package:flutter/material.dart';

class BMIStatus {
  String userId;
  String height;
  String weight;
  double status;
  String date;
  String time;
  BMIStatus({
    @required this.userId,
    @required this.height,
    @required this.weight,
    @required this.status,
    @required this.date,
    @required this.time,
  });

  BMIStatus.fromMap(Map map) {
    this.userId = map["userId"];
    this.height = map["height"];
    this.weight = map["weight"];
    this.status = map["status"];
    this.date = map["date"];
    this.time = map["time"];
  }

  toMap() {
    return {
      "userId": this.userId,
      "height": this.height,
      "weight": this.weight,
      "status": this.status,
      "date": this.date,
      "time": this.time,
    };
  }
}
