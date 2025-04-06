import 'package:digital_kabaria_app/Utils/app_colors.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:digital_kabaria_app/widgets/chat_card_widget.dart';
import 'package:flutter/material.dart';

class CompanyChatScreen extends StatefulWidget {
  const CompanyChatScreen({super.key});

  @override
  State<CompanyChatScreen> createState() => _CompanyChatScreenState();
}

class _CompanyChatScreenState extends State<CompanyChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        backgroundColor: AppColors.whiteColor,
        title: const AppText(text: "Chats",fontWeight: FontWeight.w800,),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return ChatCardWidget(url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT93mIeSAhdQKfPqXBQ0FFqPZ6NL5fKPnOwHg&s",title: "Ahsan",subtitle: "Hi",);

      }),
    );
  }
}