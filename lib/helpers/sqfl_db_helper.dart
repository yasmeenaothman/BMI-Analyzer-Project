import 'dart:io';

import 'package:bmi_project/modles/bmi_status.dart';
import 'package:bmi_project/modles/constants.dart';
import 'package:bmi_project/modles/food_details.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'AuthHelper.dart';

class DbHelper{
  DbHelper._();
  static DbHelper helper = DbHelper._();
  Database database;
  initDatabase() async {
    database = await createDatabase();
  }
  Future<Database> createDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    Database database = await openDatabase(
      directory.path+'/${Constants.dbName}',
      version: 1,
      onCreate: (db,v) async {
        /*await db.execute('''CREATE TABLE ${Constants.foodTableName} (
        ${Constants.foodNameColumnName} TEXT PRIMARY KEY AUTOINCREMENT,
        ${Constants.userIdColumnName} TEXT,
        ${Constants.categoryColumnName} TEXT,
        ${Constants.caloryColumnName} REAL,
        ${Constants.foodPhotoColumnName} BLOB)''');*/
        await db.execute('''CREATE TABLE ${Constants.bmiStatusTableName} (
         ${Constants.userIdColumnName} TEXT,
         ${Constants.heightColumnName} REAL ,
         ${Constants.weightColumnName} REAL,
         ${Constants.statusColumnName} TEXT,
         ${Constants.dateColumnName} TEXT,
         ${Constants.timeColumnName} TEXT)''');
        print('the tables is created');
      },
      onOpen: (db) async {
        print('yes the db is opend');
      },
    );
    return database;
  }
  insertFood(FoodDetails food,Database database) async{
    int rowNumber = await database.insert('${Constants.foodTableName}', food.toMap());
    print('${food.name} $rowNumber is added');
  }
  insertBMIStatus(BMIStatus status,Database database) async{
    int rowNumber = await database.insert('${Constants.bmiStatusTableName}', status.toMap());
    rowNumber==0?print('no added'):AuthHelper.authHelper.showToast('whenConnect'.tr());
    print('${status.status} $rowNumber is added successful');
  }
  Future<List<FoodDetails>> getAllFood() async{
    List<Map<String,Object>> food = await database.query(Constants.foodTableName);
    return food.map((e) => FoodDetails.fromMap(e)).toList();
  }
  Future<List<BMIStatus>> getAllStatuses() async{
    List<Map<String,Object>> statuses = await database.query(Constants.bmiStatusTableName);
    List<BMIStatus> allStatuses= statuses.map((e) => BMIStatus.fromMap(e)).toList();
    print('===========================${allStatuses.length}');
    return allStatuses;
  }
  deleteAllBMIStatus() async{
    await database.delete(Constants.bmiStatusTableName);
  }
}