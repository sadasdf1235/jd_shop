import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<void> setInt(String key,int value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }
  static Future<void> setBool(String key,bool value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
  static Future<void> setDouble(String key,double value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }
  static Future<void> setString(String key,dynamic value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static Future<void> setStringList(String key,dynamic value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static Future<int> getInt(String key)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key)!;
  }
  static Future<bool> getBool(String key)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key)!;
  }
  static Future<double> getDouble(String key)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key)!;
  }
  static Future<String> getString(String key)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key)!;
  }
  static Future<List> getStringList(String key)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key)!;
  }
  static Future<void> clear(String key)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  static Future<void> clearAll()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}