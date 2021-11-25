import 'package:flutter/material.dart';

class UserData {
  String id;
  String name;
  String email;
  String gender;
  String dateOfBirth;

  UserData({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.gender,
    @required this.dateOfBirth,
  });

  UserData.fromMap(Map map) {
    this.id = map["id"];
    this.name = map["name"];
    this.email = map["email"];
    this.gender = map["gender"];
    this.dateOfBirth = map["dateOfBirth"];
  }

  toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "gender": this.gender,
      "dateOfBirth": this.dateOfBirth,
    };
  }
}
