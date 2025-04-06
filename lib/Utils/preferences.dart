import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static const USER = "user";
 static saveData(Map<String,dynamic> user)async{
   SharedPreferences sp =await SharedPreferences.getInstance();
 var data =sp.setString(USER, jsonEncode(user));
 print("data ${data}");
   
   }

   static getData()async{
   SharedPreferences sp =await SharedPreferences.getInstance();
  var getData =   sp.getString(USER);
  print("getData $getData");
  return jsonDecode(getData!);
   }
  
 static clear()async{
   SharedPreferences sp =await SharedPreferences.getInstance();
   sp.clear();
    
  }
}