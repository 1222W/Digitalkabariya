import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:flutter/material.dart';

class ChatCardWidget extends StatelessWidget {
  String url;
  String title;
  String subtitle;
   ChatCardWidget({super.key,this.url = "",this.title = "",this.subtitle = ""});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(url),
      ),
      title: AppText(text: title),
      subtitle: AppText(text: subtitle),
    );
  }
}