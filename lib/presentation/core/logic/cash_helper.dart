import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static late SharedPreferences _prefs;
  static Future <void>  init() async{
    _prefs = await SharedPreferences.getInstance();
  }
  static setIsFirstTime()async{
    await _prefs.setBool("isFirstTime", false);
  }
  static bool get isFirstTime {
    return _prefs.getBool("isFirstTime")??true;
  }
  static String get name{
   return _prefs.getString("name")??"";
  }
  static String get token{
   return _prefs.getString("token")??"eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZjY2MjdiMjgzODQyN2M5MzRlZDhhYjZkNmEwYTE3ZiIsIm5iZiI6MTcxOTA5Nzg5OC45MzAwMDMsInN1YiI6IjY2NjVjNzM2OTk1ZDBlOTk1ZTlmMzdlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6kT2DpUllTujyy27ZO5TwNoQmPZeW38DvNZqeV4nrxU";
  }
  static int get password{
    return _prefs.getInt("password")??0;
  }
  static get logout{
    return _prefs.remove("isFirstTime");
  }
  static Future setCount(int value)async{
    await _prefs.setInt("count", value);
  }
  static int get count{
    return _prefs.getInt("count")??0;
  }
  }