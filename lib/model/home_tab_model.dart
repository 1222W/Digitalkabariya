import 'package:flutter/material.dart';

class HomeTabCardModel {
  IconData icon;
  String title;
  String subTitle;
  HomeTabCardModel({this.icon = Icons.abc,this.title = "",this.subTitle = ""});
  
}

class HomeTabCardData {

List<HomeTabCardModel> data = [
  HomeTabCardModel(icon: Icons.person,title: "Total Users",subTitle: "20"),
  HomeTabCardModel(icon: Icons.person,title: "Active Users",subTitle: "10"),
  HomeTabCardModel(icon: Icons.person,title: "Blocked Users",subTitle: "10"),
  HomeTabCardModel(icon: Icons.shopify_sharp,title: "Total Products",subTitle: "50"),
];  
}