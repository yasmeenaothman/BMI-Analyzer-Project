import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  SharedPreferenceHelper._();
  static SharedPreferenceHelper sharedHelper = SharedPreferenceHelper._();
  SharedPreferences sharedPreferences;
  initSharedPreferences() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  putBoolean(String key, bool value) async{
    bool isPut = await sharedPreferences.setBool(key, value);
    print('is put in sharedPreference? $isPut');
  }
  bool getBoolean(String key) {
    return sharedPreferences.getBool(key);
  }
}