import 'package:digital_kabaria_app/Utils/app_colors.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';
import 'package:digital_kabaria_app/model/side_menu_data.dart';
import 'package:flutter/material.dart';

class SideMenuWidget extends StatefulWidget {
  final  onMenuItemSelected;
  const SideMenuWidget({super.key,this.onMenuItemSelected});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var data = SideMenuData();
    return Container(
      decoration: const BoxDecoration(
      border: Border(
        right: BorderSide(
          color: Colors.white, 
          width: 2.0, 
        ),
      ),
    ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: ListView.builder(
            itemCount: data.menu.length,
            itemBuilder: (context, index) {
              return buildSideData(data, index);
            }),
      ),
    );
  }

  buildSideData(SideMenuData data, int index) {
    final isSelected = selectedIndex == index;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: isSelected ? AppColors.whiteColor : Colors.transparent),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          widget.onMenuItemSelected(index);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical:12.0),
          child: Row(
            children: [
              Icon(
                data.menu[index].icon,
                color: isSelected ? AppColors.blackColor : AppColors.greyColor,
              ),
              const SizedBox(
                width: 10.0,
              ),
              AppText(
                text: data.menu[index].text,
                color: isSelected ? AppColors.blackColor : AppColors.greyColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
