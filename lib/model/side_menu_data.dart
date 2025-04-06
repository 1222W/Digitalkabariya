import 'package:flutter/material.dart';

class MenuModel {
  final IconData icon;
  final String text;
  MenuModel({this.icon = Icons.abc,this.text = ""});
}

class SideMenuData {
  List<MenuModel> menu  = [
  MenuModel(icon: Icons.home,text: "Home"),
  MenuModel(icon: Icons.person,text: "Users"),
  MenuModel(icon: Icons.money,text: "Rates"),
  MenuModel(icon: Icons.feed,text: "Feedback"),
  // MenuModel(icon: Icons.logout,text: "Sign out"),
];
  
}

