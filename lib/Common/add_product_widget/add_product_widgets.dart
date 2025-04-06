import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ProductImageContainer extends StatelessWidget {
  void Function()? onTap;
ImageProvider<Object>? backgroundImage;
   ProductImageContainer({super.key,this.onTap,this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        dashPattern: const [5],
        color: Colors.black,
        strokeWidth: 1,
        borderType: BorderType.Circle,
        child:  CircleAvatar(
          backgroundImage: backgroundImage,
          radius: 40,
          backgroundColor: Colors.transparent,
          
        ),
      ),
    );
  }
}

