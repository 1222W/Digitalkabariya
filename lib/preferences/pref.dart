import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static const user = "USER";
  static setUser(userData)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(user, userData);
  }

  static getUser()async{
        SharedPreferences sp = await SharedPreferences.getInstance();
   return sp.getString(user);
  }
  
  static clearPref()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();

  }
}