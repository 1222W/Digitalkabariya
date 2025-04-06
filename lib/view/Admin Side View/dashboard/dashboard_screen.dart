import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/dashboard/dashboard_home_screen.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/dashboard/dashboard_logout_screen.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/dashboard/dashboard_profile_screen.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/dashboard/dashboard_rates_screen.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/dashboard/dashboard_widgets/home_tab_widgets.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/dashboard/dashboard_widgets/side_menu_widget.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedScreenIndex = 0;
  final List<Widget> screens = [
    const DashboardHomeScreen(),
    const DashboardUsersScreen(),
     DashboardRatesScreen(),
     const DashboardFeedback(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(child: SideMenuWidget(
              onMenuItemSelected: (int index) {
                setState(() {
                  selectedScreenIndex = index;
                });
              },
            )),
          ),
          Expanded(
            flex: 8,
            child: screens[selectedScreenIndex],
          ),
          const Expanded(
            flex: 3,
            child: const ProfileComponentWidget(),
          ),
        ],
      ),
    );
  }
}
